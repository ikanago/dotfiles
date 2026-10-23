#!/usr/bin/env bash
# fetch-ci-logs.sh
# Usage: fetch-ci-logs.sh <PR_URL>
#
# Fetches failed CI logs for a pull request.
# Detects the CI provider (GitHub Actions or CircleCI) from each failing check's link.
#
# Requirements:
#   - gh CLI (authenticated)
#   - $CIRCLE_TOKEN for CircleCI checks (skips CircleCI checks if unset)
#   - jq, curl

set -euo pipefail

usage() {
  echo "Usage: $0 <PR_URL>" >&2
  echo "Example: $0 https://github.com/acme/myrepo/pull/42" >&2
  exit 1
}

[[ $# -lt 1 ]] && usage

PR_URL="$1"

# --- Step 1: Get all failing checks ---
echo "==> Fetching failing checks for $PR_URL"
echo ""

CHECKS_JSON=$(gh pr checks "$PR_URL" --json name,state,link -q  '.[] | select(.state == "FAILURE" and (.link | startswith("https://app.circleci.com") | not))' 2>&1) || {
  echo "Error: Failed to fetch PR checks. Is the PR URL correct?" >&2
  echo "$CHECKS_JSON" >&2
  exit 1
}

if [[ -z "$CHECKS_JSON" ]]; then
  echo "All checks pass. No failures found."
  exit 0
fi

# Parse into array of {name, link} objects
FAILING_CHECKS=$(echo "$CHECKS_JSON" | jq -s '.')
CHECK_COUNT=$(echo "$FAILING_CHECKS" | jq 'length')

echo "Found $CHECK_COUNT failing check(s):"
echo "$FAILING_CHECKS" | jq -r '.[] | "  - \(.name): \(.link)"'
echo ""

# --- Step 2: Fetch logs for each failing check ---

fetch_github_actions_logs() {
  local link="$1"
  local name="$2"

  # Extract owner/repo and run_id from link
  # Pattern: https://github.com/<owner>/<repo>/actions/runs/<run_id>/...
  if [[ "$link" =~ github\.com/([^/]+/[^/]+)/actions/runs/([0-9]+) ]]; then
    local repo="${BASH_REMATCH[1]}"
    local run_id="${BASH_REMATCH[2]}"
  else
    echo "Warning: Could not parse GitHub Actions URL: $link" >&2
    return 1
  fi

  echo "==> Fetching GitHub Actions logs: $name"
  echo "    repo=$repo  run_id=$run_id"
  echo ""

  gh run view "$run_id" --repo "$repo" --log-failed 2>&1 | tail -100
  echo ""
}

fetch_circleci_logs() {
  local link="$1"
  local name="$2"

  if [[ -z "${CIRCLE_TOKEN:-}" ]]; then
    echo "Warning: CIRCLE_TOKEN is not set. Skipping CircleCI check: $name" >&2
    return 0
  fi

  # Parse URL: support two formats
  if [[ "$link" =~ app\.circleci\.com/pipelines/github/([^/]+)/([^/]+)/[^/]+/workflows/[^/]+/jobs/([0-9]+) ]]; then
    local owner="${BASH_REMATCH[1]}"
    local repo="${BASH_REMATCH[2]}"
    local build_num="${BASH_REMATCH[3]}"
  elif [[ "$link" =~ circleci\.com/gh/([^/]+)/([^/?]+)/([0-9]+) ]]; then
    local owner="${BASH_REMATCH[1]}"
    local repo="${BASH_REMATCH[2]}"
    local build_num="${BASH_REMATCH[3]}"
  else
    echo "Warning: Could not parse CircleCI URL: $link" >&2
    return 1
  fi

  echo "==> Fetching CircleCI logs: $name"
  echo "    owner=$owner  repo=$repo  build=$build_num"
  echo ""

  local build_json
  build_json=$(curl -sf -H "Circle-Token: $CIRCLE_TOKEN" \
    "https://circleci.com/api/v1.1/project/github/${owner}/${repo}/${build_num}")

  if [[ -z "$build_json" ]]; then
    echo "Error: Empty response from CircleCI API for build $build_num" >&2
    return 1
  fi

  local job_name build_status
  job_name=$(echo "$build_json" | jq -r '.workflows.job_name // .build_parameters.CIRCLE_JOB // "unknown"')
  build_status=$(echo "$build_json" | jq -r '.status')
  echo "Job: $job_name  |  Status: $build_status"
  echo ""

  local step_count
  step_count=$(echo "$build_json" | jq '.steps | length')

  if [[ "$step_count" == "0" || "$step_count" == "null" ]]; then
    echo "No steps found in build response." >&2
    return 1
  fi

  local found_failure=0

  for i in $(seq 0 $((step_count - 1))); do
    local step step_name action_count
    step=$(echo "$build_json" | jq ".steps[$i]")
    step_name=$(echo "$step" | jq -r '.name')
    action_count=$(echo "$step" | jq '.actions | length')

    for j in $(seq 0 $((action_count - 1))); do
      local action status output_url
      action=$(echo "$step" | jq ".actions[$j]")
      status=$(echo "$action" | jq -r '.status')
      output_url=$(echo "$action" | jq -r '.output_url // empty')

      if [[ "$status" == "failed" || "$status" == "timedout" ]]; then
        found_failure=1
        echo "===================================================================="
        echo "FAILED STEP: $step_name  (status: $status)"
        echo "===================================================================="

        if [[ -z "$output_url" ]]; then
          echo "(no output_url available for this step)"
          echo ""
          continue
        fi

        # output_url is a pre-signed S3 URL — no auth header needed
        local log_json
        log_json=$(curl -sf "$output_url" 2>/dev/null || echo "[]")

        echo "$log_json" \
          | jq -r '.[].message' \
          | tail -100

        echo ""
      fi
    done
  done

  if [[ "$found_failure" -eq 0 ]]; then
    echo "No failed steps found. Build status: $build_status"
    echo "All step statuses:"
    echo "$build_json" | jq -r '.steps[] | "\(.name): \(.actions[].status)"'
  fi
}

# --- Dispatch each failing check to the right provider ---

for i in $(seq 0 $((CHECK_COUNT - 1))); do
  NAME=$(echo "$FAILING_CHECKS" | jq -r ".[$i].name")
  LINK=$(echo "$FAILING_CHECKS" | jq -r ".[$i].link")

  if [[ "$LINK" =~ github\.com/.*/actions/runs/ ]]; then
    fetch_github_actions_logs "$LINK" "$NAME"
  elif [[ "$LINK" =~ circleci\.com ]]; then
    fetch_circleci_logs "$LINK" "$NAME"
  else
    echo "==> Unknown CI provider for check '$NAME': $LINK"
    echo "    Skipping."
    echo ""
  fi
done

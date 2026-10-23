#!/usr/bin/env bash
# fetch-circleci-logs.sh
# Usage: fetch-circleci-logs.sh <circleci-job-url>
#
# Fetches failed step logs from a CircleCI job URL.
# Requires $CIRCLE_TOKEN to be set.
#
# URL format:
#   https://app.circleci.com/pipelines/github/<owner>/<repo>/<pipeline_num>/workflows/<workflow_id>/jobs/<job_num>

set -euo pipefail

usage() {
  echo "Usage: $0 <circleci-job-url>" >&2
  echo "Example: $0 https://app.circleci.com/pipelines/github/acme/myrepo/42/workflows/abc123/jobs/1234" >&2
  exit 1
}

[[ $# -lt 1 ]] && usage

URL="$1"

if [[ -z "${CIRCLE_TOKEN:-}" ]]; then
  echo "Error: CIRCLE_TOKEN is not set. Export it before running this script." >&2
  exit 1
fi

# Parse URL: support two formats:
#   new: https://app.circleci.com/pipelines/github/<owner>/<repo>/<pipeline_num>/workflows/<workflow_id>/jobs/<job_num>
#   old: https://circleci.com/gh/<owner>/<repo>/<build_num>
if [[ "$URL" =~ app\.circleci\.com/pipelines/github/([^/]+)/([^/]+)/[^/]+/workflows/[^/]+/jobs/([0-9]+) ]]; then
  OWNER="${BASH_REMATCH[1]}"
  REPO="${BASH_REMATCH[2]}"
  BUILD_NUM="${BASH_REMATCH[3]}"
elif [[ "$URL" =~ circleci\.com/gh/([^/]+)/([^/?]+)/([0-9]+) ]]; then
  OWNER="${BASH_REMATCH[1]}"
  REPO="${BASH_REMATCH[2]}"
  BUILD_NUM="${BASH_REMATCH[3]}"
else
  echo "Error: Could not parse CircleCI URL: $URL" >&2
  echo "Supported formats:" >&2
  echo "  https://app.circleci.com/pipelines/github/<owner>/<repo>/<pipeline_num>/workflows/<workflow_id>/jobs/<job_num>" >&2
  echo "  https://circleci.com/gh/<owner>/<repo>/<build_num>" >&2
  exit 1
fi

echo "==> Fetching CircleCI build details"
echo "    owner=$OWNER  repo=$REPO  build=$BUILD_NUM"
echo ""

BUILD_JSON=$(curl -sf -H "Circle-Token: $CIRCLE_TOKEN" \
  "https://circleci.com/api/v1.1/project/github/${OWNER}/${REPO}/${BUILD_NUM}")

if [[ -z "$BUILD_JSON" ]]; then
  echo "Error: Empty response from CircleCI API. Check that CIRCLE_TOKEN is valid and the build number is correct." >&2
  exit 1
fi

# Extract job name and overall status for context
JOB_NAME=$(echo "$BUILD_JSON" | jq -r '.workflows.job_name // .build_parameters.CIRCLE_JOB // "unknown"')
BUILD_STATUS=$(echo "$BUILD_JSON" | jq -r '.status')
echo "Job: $JOB_NAME  |  Status: $BUILD_STATUS"
echo ""

# Iterate over steps and their actions
STEP_COUNT=$(echo "$BUILD_JSON" | jq '.steps | length')

if [[ "$STEP_COUNT" == "0" || "$STEP_COUNT" == "null" ]]; then
  echo "No steps found in build response." >&2
  exit 1
fi

FOUND_FAILURE=0

for i in $(seq 0 $((STEP_COUNT - 1))); do
  STEP=$(echo "$BUILD_JSON" | jq ".steps[$i]")
  STEP_NAME=$(echo "$STEP" | jq -r '.name')
  ACTION_COUNT=$(echo "$STEP" | jq '.actions | length')

  for j in $(seq 0 $((ACTION_COUNT - 1))); do
    ACTION=$(echo "$STEP" | jq ".actions[$j]")
    STATUS=$(echo "$ACTION" | jq -r '.status')
    OUTPUT_URL=$(echo "$ACTION" | jq -r '.output_url // empty')

    if [[ "$STATUS" == "failed" || "$STATUS" == "timedout" ]]; then
      FOUND_FAILURE=1
      echo "===================================================================="
      echo "FAILED STEP: $STEP_NAME  (status: $STATUS)"
      echo "===================================================================="

      if [[ -z "$OUTPUT_URL" ]]; then
        echo "(no output_url available for this step)"
        echo ""
        continue
      fi

      # output_url is a pre-signed S3 URL — no auth header needed
      LOG_JSON=$(curl -sf "$OUTPUT_URL" 2>/dev/null || echo "[]")

      # Extract and join message fields, then show last 100 lines
      echo "$LOG_JSON" \
        | jq -r '.[].message' \
        | tail -100

      echo ""
    fi
  done
done

if [[ "$FOUND_FAILURE" -eq 0 ]]; then
  echo "No failed steps found. Build status: $BUILD_STATUS"
  echo "All step statuses:"
  echo "$BUILD_JSON" | jq -r '.steps[] | "\(.name): \(.actions[].status)"'
fi

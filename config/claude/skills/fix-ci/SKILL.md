---
name: fix-ci
description: Debug and fix CI failures from a PR link. Fetches failing job/step logs from GitHub Actions or CircleCI, identifies the root cause, then proposes and applies a fix. Use when the user provides a PR URL and wants to investigate and fix CI failures.
allowed-tools:
  - Bash(gh checks *)
  - Bash(gh run view *)
  - Bash(~/.claude/skills/fix-ci/fetch-ci-logs.sh *)
  - Read
  - Edit
---

You are fixing CI failures for a pull request. The user has provided a PR URL (or it may be in the arguments).

## Step 1: Fetch failing checks and logs

Run the bundled script to get all failing checks and their logs in one shot:
```bash
~/.claude/skills/fix-ci/fetch-ci-logs.sh <PR_URL>
```

If no checks are failing, the script reports that and exits.

## Step 2: Summarize failures

For each failing job/step:
- Print the job and step name
- Show the last ~100 lines of the log
- Identify the root cause: test name, error message, file path, line number, exit code

## Step 3: Determine the fix

Read the relevant source files to understand the failure. Common failure types:
- Test failure: read the test file and implementation, identify the bug or test expectation mismatch
- Lint/format error: identify the offending lines
- Build error: identify the missing dependency or compilation issue
- Type error: identify the type mismatch

## Step 4: Apply the fix and push

After reading relevant files and identifying the fix:
1. Apply edits using the Edit tool
2. Stage, commit, and push:

```bash
git add <changed files>
git commit -m "fix: <concise description of what was fixed>"
git push
```

Use the branch that the PR is on (check with `gh pr view <PR_URL> --json headRefName`).

## Key notes

- The fetch-ci-logs.sh script truncates logs to last 100 lines to avoid context overflow
- If multiple checks fail, the script processes each one
- Before pushing, confirm the fix makes sense. If the root cause is ambiguous, say so and ask the user before committing

---
name: create-pr
description: Create a PR
allowed-tools:
  - Bash(git switch *)
  - Bash(git symbolic-ref *)
  - Bash(sed *)
  - Bash(git status *)
  - Bash(git add *)
  - Bash(git commit *)
  - Bash(git push *)
---

## Steps
1. Get a default branch
  - `git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'`
1. Create a new branch from which you create a PR:
  - `git switch -c <branch-name> <default-branch-name>`
2. Add and commit the changes you made. Don't include unnecessary files for the fix:
  - `git add <files-to-add>`
3. Commit the changes (keep the message short and concise):
  - `git commit -m <commit-message>`
4. Push the changes:
  - `git push -u origin HEAD`
5. Create the PR:
  - `gh pr create --title "{replace with actual PR Title}" --body "{replace with actual PR description}" --base {replace with confirmed base branch} --draft`
    - The title should be specific enough to be understandable standalone
    - On creating body
      - Use `.github.com/pull_request_template.md` if available

## Principles on Writing Descriptions
- Never just explain the change. Summarize what and why it was changed
  - You can ask the user about why since code sometimes does not tell it
- Focus on outcomes, not activities
- Never delete template sections or checkbox options
- Check appropriate boxes [x], keep others [ ]

## Quality Gates
- Never create PR from a default branch

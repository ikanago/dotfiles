---
name: write-doc
description: Summarizes things into Obsidian Vault. Use when user mentions "document" or "obsidian".
allowed-tools:
  - Edit
  - Read
  - Write
---

# Write Doc

## Steps
### 1. Write a First Version
Follow a user's instruction explained in `$ARGUMENTS`.
If it's omitted, just summarize the conversation until now.

Create or update a document in `~/ghq/github.com/moneyforward/nagaoka.yuta/`.
Do not create a sub directory to store the document.

Follow a general writing guides in @guide.md for a good document.

### 2. Ask a Reviewer Agent to Review
Spawn a sub-agent defined in @agents/reviewer.md to ask a review.
A prompt is the contents of @agents/reviewer.md with `{{document_path}}` replaced by a path to the document.
It leaves reviews in markdown comments in a form of `<!-- REVIEW: {content} -->`

### 3. Address Review Comments
After the review is done, you resolve the review comments.
If there is no comments, you can say writing the document is done.
If not, you have to take one of these action for each review comment:
- Address a comment: accept it and fix the document. You still have to follow @guide.md here. Do not remove the review comment by yourself.
- Reply a comment: if you have an argument to it, you can leave a reply `<!-- REPLY: {content} -->`.

### 4. Repeat
Back to the step 2 to ask a review on the updated document.

## Notes
- Use `datadog_url_generator` MCP when you build an URL to Datadog metrics.

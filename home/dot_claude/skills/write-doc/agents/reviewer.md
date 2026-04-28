# Document Reviewer

Your responsibility is reviewing a document to follow the writing guide @../guide.md and make the document reliable and comprehensive.

## Steps
### 1. Read the Document
Read a document at `{{document_path}}`.

### 2. Leave Reviews
You have two things to do in this step:
- For each `<!-- REVIEW -->`, check if it's addressed
  - This is a review comment you left in the previous session
  - If you feel there is a fix to your previous review, remove the comment to resolve it.
  - If a writer left `<!-- REPLY -->`
    - If you agree with the reply and there's no need to fix something, remove the original review comment and the reply so far.
    - Or leave another reply in the same form to continue the discussion
- For each point that do not follow the writing guide @../guide.md, leave `<!-- REVIEW: {content} -->` to tell it to a writer

### 3. Summarize the Review
Output a list of reviews for a short summarry.
```
- "150ms" in section X: no evidence. attach datadog link
- Solution #1: weak logic. you ignore the fact that ...
```

If there is not review comment, you can tell so.

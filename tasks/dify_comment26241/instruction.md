# Code Review Task

You are a maintainer reviewing a pull request to the `langgenius/dify` repository.

**PR title:** feat(workflow): workflow as tool output schema

**PR description:**

> [!IMPORTANT]
>
> 1. Make sure you have read our [contribution guidelines](https://github.com/langgenius/dify/blob/main/CONTRIBUTING.md)
> 1. Ensure there is an associated issue and you have been assigned to it
> 1. Use the correct syntax to link this PR: `Fixes #<issue number>`.

## Summary

Fixes https://github.com/langgenius/dify/issues/25980

**Workflow as tool add specific output, follow-up nodes can use output variable directly**

### Detail

1. ~~db upgrade: table `tool_workflow_providers` add `output_schema` field~~
2. workflow as tool provider model add `output_schema` field
3. frontend support `output_schema` display and flow connection
4. workflow as tool add reserved parameter warning and validate

## Screenshots

### Before
<img width="1912" height="653" alt="image" src="https://github.com/user-attachments/assets/d819a59f-bf2e-4902-8cec-0cdc4b25c171" />
<img width="1033" height="958" alt="image" src="https://github.com/user-attachments/assets/8c464acc-9f8e-438e-b42d-eeaed09eabb5" />

We need to use a code node to convert json and extract the data what we need

### After
<img width="1434" height="790" alt="image" src="https://github.com/user-attachments/assets/a892dde9-826e-4d2f-99e6-96fd5f405415" />
<img width="1434" height="788" alt="image" src="https://github.com/user-attachments/assets/9acf5625-c33e-4efe-99a8-5038beedbf2f" />
<img width="1431" height="787" alt="image" src="https://github.com/user-attachments/assets/144b7ed1-b3e6-41b4-9233-e9682b263b2c" /><img width="404" height="671" alt="image" src="https://github.com/user-attachments/assets/a41687e2-84e4-4067-ad75-502b5d1c6aa1" />

We can use output variable directly!

## Checklist

- [ ] This change requires a documentation update, included: [Dify Document](https://github.com/langgenius/dify-docs)
- [x] I understand that this PR may be closed in case there was no previous discussion or issues. (This doesn't apply to typos!)
- [x] I've added a test for each change that was introduced, and I tried as much as possible to make a single atomic change.
- [x] I've updated the documentation accordingly.
- [x] I ran `dev/reformat`(backend) and `cd web && npx lint-staged`(frontend) to appease the lint gods

## Working environment

The repository is checked out at `/app/dify` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.

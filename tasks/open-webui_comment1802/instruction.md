# Code Review Task

You are a maintainer reviewing a pull request to the `open-webui/open-webui` repository.

**PR title:** ✨feat added environment variables and sync.yml

**PR description:**

## Pull Request Checklist

## Description

✨feat added environment variables and sync.yml

---
### Changelog Entry

#1793

### Fixed
✨feat added environment variables 
✨feat added sync.yml

### Changed

| Section | Content | Description |
|:--------|:---------------------|:------------|
| Images  | IMAGE_GENERATION_ENGINE | Select the image generation engine. Options: `openai`, `ollama`, `comfyul`. |
|         | IMAGE_GENERATION_MODEL | Selects the image model. |
|         | IMAGE_SIZE | Sets the image size. Default is `512x512`. |
|         | IMAGE_STEPS | Sets the image steps. Default is `50`. |
| RAG | PDF_EXTRACT_IMAGES | Toggles whether to enable OCR for recognizing PDF. |
| Additions | sync.yml | Added `sync.yml` for automatic synchronization and updates of the latest code for forked repositories using github action. 

### Removed
NO Removed, Only Add

### Verify
I have self-tested and it passed.

![image](https://github.com/open-webui/open-webui/assets/132346501/74a0db23-3b8d-4254-aa20-4ce63ecd3cc8)

![image](https://github.com/open-webui/open-webui/assets/132346501/07f90c4c-6949-4644-ac2f-62a9a1843249)

![image](https://github.com/open-webui/open-webui/assets/132346501/d0d1ab34-0180-433f-a0bb-86f6a2c212ae)

## Working environment

The repository is checked out at `/app/open-webui` at this PR's **base commit**
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

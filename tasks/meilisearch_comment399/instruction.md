# Code Review Task

You are a maintainer reviewing a pull request to the `meilisearch/meilisearch` repository.

**PR title:** Rewrite the synonym endpoint

**PR description:**

Related to #398 

closes #398, closes #392, closes #389 

Test:

Search "Green" > Only result with "Green"
<img width="1920" alt="Capture d’écran 2019-12-12 à 12 40 15" src="https://user-images.githubusercontent.com/6064892/70709248-be575a00-1cdc-11ea-9d00-fe5c728f73fb.png">

Add to synonyms "Green = Blue"
<img width="1920" alt="Capture d’écran 2019-12-12 à 12 40 30" src="https://user-images.githubusercontent.com/6064892/70709249-be575a00-1cdc-11ea-883e-5a7d9a200c3c.png">

Check synonyms list. "Green = Blue"
<img width="1920" alt="Capture d’écran 2019-12-12 à 12 42 45" src="https://user-images.githubusercontent.com/6064892/70709316-e8a91780-1cdc-11ea-9f22-0d19ce4ca966.png">

Search "Green" > Result with "Green" and "Blue"
<img width="1920" alt="Capture d’écran 2019-12-12 à 12 40 41" src="https://user-images.githubusercontent.com/6064892/70709250-beeff080-1cdc-11ea-87ed-b672c3edefe0.png">

Remove all synonyms
<img width="1920" alt="Capture d’écran 2019-12-12 à 12 40 53" src="https://user-images.githubusercontent.com/6064892/70709251-beeff080-1cdc-11ea-87b6-d3b78652c07d.png">

Search "Green" > Only result with "Green"
<img width="1920" alt="Capture d’écran 2019-12-12 à 12 41 03" src="https://user-images.githubusercontent.com/6064892/70709253-bf888700-1cdc-11ea-89e5-15524f6c950d.png">

## Working environment

The repository is checked out at `/app/meilisearch` at this PR's **base commit**
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

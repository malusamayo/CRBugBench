# Code Review Task

You are a maintainer reviewing a pull request to the `OpenHands/OpenHands` repository.

**PR title:** feat: display exact error for runtime requests exception handling

**PR description:**

**End-user friendly description of the problem this fixes or functionality that this introduces**

- [ ] Include this change in the Release Notes. If checked, you must provide an **end-user friendly** description for your change below

---
**Give a summary of what the PR does, explaining any non-trivial design decisions**

This PR display exact error for runtime requests response's `detail` field whenever a HTTPError happens.

---
**Link of any specific issues this addresses**

---

To run this PR locally, use the following command:
```
docker run -it --rm   -p 3000:3000   -v /var/run/docker.sock:/var/run/docker.sock   --add-host host.docker.internal:host-gateway   -e SANDBOX_RUNTIME_CONTAINER_IMAGE=docker.all-hands.dev/all-hands-ai/runtime:681e486-nikolaik   --name openhands-app-681e486   docker.all-hands.dev/all-hands-ai/openhands:681e486
```

## Working environment

The repository is checked out at `/app/OpenHands` at this PR's **base commit**
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

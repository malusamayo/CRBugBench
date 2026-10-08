# Code Review Task

You are a maintainer reviewing a pull request to the `embassy-rs/embassy` repository.

**PR title:** `PacketQueue::init()`

**PR description:**

`PacketQueue` is pretty big, so I added a method to initialize it without requiring an allocation on the stack (which could in fact overflow). Before this PR, the only solution would be to declare a `PacketQueue` instance as a `static mut`, while now one could for example have a `Box<MaybeUninit<PacketQueue<...>>>` and then use `init()` on it.

Ideally, the same work would need to be done for all those structures that own big arrays which could overflow the stack.

## Working environment

The repository is checked out at `/app/embassy` at this PR's **base commit**
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

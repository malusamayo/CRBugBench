# Code Review Task

You are a maintainer reviewing a pull request to the `netbox-community/netbox` repository.

**PR title:** 14731 plugins catalog

**PR description:**

### Fixes: #14731 

Changed from the design of cards to a standard table as per comments.  Held off on writing tests as it is info display only and it sounds like we want to change to cards fairly soon which would require re-writing a lot of the tests.  We could mock the API and check the display based on that, but not sure what really to test beyond that.

![ACLs | NetBox 2024-06-28 08-28-16](https://github.com/netbox-community/netbox/assets/99642/d78355b3-0989-476e-8426-ab8074b3d719)
![ACLs | NetBox 2024-06-28 08-27-44](https://github.com/netbox-community/netbox/assets/99642/856c581c-73ff-4e32-b859-3da9efd6b913)
![ACLs | NetBox 2024-06-28 08-27-59](https://github.com/netbox-community/netbox/assets/99642/581a0c98-a5e1-43b2-ae45-e3a162940f4c)
<img width="1132" alt="Plugins | NetBox 2024-07-15 21-33-43" src="https://github.com/user-attachments/assets/673e1347-c1c9-4fa3-ac8b-469cbe1f8d9f">

## Working environment

The repository is checked out at `/app/netbox` at this PR's **base commit**
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

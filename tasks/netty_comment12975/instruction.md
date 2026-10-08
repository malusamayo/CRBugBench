# Code Review Task

You are a maintainer reviewing a pull request to the `netty/netty` repository.

**PR title:** Move validation of connection headers in HTTP/2 back to `HpackDecoder`

**PR description:**

Motivation:

#12755 added validation for presence of connection-related headers while `HpackDecoder` decodes the incoming frame. Then #12760 moved this validation from `HpackDecoder` to `DefaultHttp2Headers`. As the result, existing use-case that could use `DefaultHttp2Headers` for HTTP/2 and HTTP/1.X broke when users add  any of the mentioned prohibited headers. The HTTP/1.X to HTTP/2 translation logic usually has sanitization process that removes connection-related headers. It's enough to run this validation only for incoming messages and we should preserve backward compatibility for 4.1.

Modifications:

- Move `isConnectionHeader` and `te` validations from `DefaultHttp2Headers` back to `HpackDecoder`;
- Add tests to verify `HpackDecoder` fails incoming headers as expected;
- Add tests to verify mentioned headers can be added to `DefaultHttp2Headers`;

Result:

Backward compatibility is preserved, while validation for connection-related headers is done in `HpackDecoder`.

## Working environment

The repository is checked out at `/app/netty` at this PR's **base commit**
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

# Code Review Task

You are a maintainer reviewing a pull request to the `explosion/spaCy` repository.

**PR title:** Fix behaviour of Matcher's ? quantifier for v2.1 (#3105)

**PR description / commit message:**

Fix behaviour of Matcher's ? quantifier for v2.1 (#3105)

* Add failing test for matcher bug #3009

* Deduplicate matches from Matcher

* Update matcher ? quantifier test

* Fix bug with ? quantifier in Matcher

The ? quantifier indicates a token may occur zero or one times. If the
token pattern fit, the matcher would fail to consider valid matches
where the token pattern did not fit. Consider a simple regex like:

.?b

If we have the string 'b', the .? part will fit --- but then the 'b' in
the pattern will not fit, leaving us with no match. The same bug left us
with too few matches in some cases. For instance, consider:

.?.?

If we have a string of length two, like 'ab', we actually have three
possible matches here: [a, b, ab]. We were only recovering 'ab'. This
should now be fixed. Note that the fix also uncovered another bug, where
we weren't deduplicating the matches. There are actually two ways we
might match 'a' and two ways we might match 'b': as the second token of the pattern,
or as the first token of the pattern. This ambiguity is spurious, so we
need to deduplicate.

Closes #2464 and #3009

* Fix Python2

## Working environment

The repository is checked out at `/app/spaCy` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.

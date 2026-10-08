# Code Review Task

You are a maintainer reviewing a pull request to the `elastic/elasticsearch` repository.

**PR title:** Implement dissect command (ESQL-887)

**PR description / commit message:**

Implement dissect command (ESQL-887)

extracts multiple text fields out of a single text value, based on a pattern provided as input.

This command ports to ESQL the functionalities available in Dissect Processor
https://www.elastic.co/guide/en/elasticsearch/reference/current/dissect-processor.html

The syntax is

dissect <expression> <pattern> (append_separator=<separator>)?

where 
- <expression> any expression that returns a KEYWORD
- <pattern> is a string representing a valid pattern for dissect
- <separator> is a string used as separator between tokens in case the pattern includes Append modifiers

eg.

row a = "foo bar" | dissect a "%{b} %{c}"

a:keyword | b:keyword | c:keyword
foo bar   | foo       | bar


row a = "foo 1 bar 2 baz" | dissect a "%{+b} %{c} %{+b} %{d} %{+b}" append_separator=","

a:keyword        | b:keyword   | c:keyword    | d:keyword 
foo 1 bar 2 baz  | foo,bar,baz | 1            | 2         

The pattern syntax is the same defined in Dissect Processor

## Working environment

The repository is checked out at `/app/elasticsearch` at this PR's **base commit**
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

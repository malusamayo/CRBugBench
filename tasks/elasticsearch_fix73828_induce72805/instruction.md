# Code Review Task

You are a maintainer reviewing a pull request to the `elastic/elasticsearch` repository.

**PR title:** [ML] Make ml_standard tokenizer the default for new categorization jobs (#72805)

**PR description / commit message:**

[ML] Make ml_standard tokenizer the default for new categorization jobs (#72805)

Categorization jobs created once the entire cluster is upgraded to
version 7.14 or higher will default to using the new ml_standard
tokenizer rather than the previous default of the ml_classic
tokenizer, and will incorporate the new first_non_blank_line char
filter so that categorization is based purely on the first non-blank
line of each message.

The difference between the ml_classic and ml_standard tokenizers
is that ml_classic splits on slashes and colons, so creates multiple
tokens from URLs and filesystem paths, whereas ml_standard attempts
to keep URLs, email addresses and filesystem paths as single tokens.

It is still possible to config the ml_classic tokenizer if you
prefer: just provide a categorization_analyzer within your
analysis_config and whichever tokenizer you choose (which could be
ml_classic or any other Elasticsearch tokenizer) will be used.

To opt out of using first_non_blank_line as a default char filter,
you must explicitly specify a categorization_analyzer that does not
include it.

If no categorization_analyzer is specified but categorization_filters
are specified then the categorization filters are converted to char
filters applied that are applied after first_non_blank_line.

Closes elastic/ml-cpp#1724

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

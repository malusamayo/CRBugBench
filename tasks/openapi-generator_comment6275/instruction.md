# Code Review Task

You are a maintainer reviewing a pull request to the `OpenAPITools/openapi-generator` repository.

**PR title:** [python-experimental] Support schema property which has $ref to 'oneOf' schema and child schema is null type

**PR description:**

This is a follow-up to #6262. It adds support for the scenario when a oneOf/anyOf child schema is the 'null' type.  
This should be merged AFTER #6262.

<!-- Please check the completed items below -->
### PR checklist

- [x] Read the [contribution guidelines](https://github.com/openapitools/openapi-generator/blob/master/CONTRIBUTING.md).
- [x] If contributing template-only or documentation-only changes which will change sample output, [build the project](https://github.com/OpenAPITools/openapi-generator#14---build-projects) before.
- [x] Run the shell script(s) under `./bin/` (or Windows batch scripts under`.\bin\windows`) to update Petstore samples related to your fix. This is important, as CI jobs will verify _all_ generator outputs of your HEAD commit, and these must match the expectations made by your contribution. You only need to run `./bin/{LANG}-petstore.sh`, `./bin/openapi3/{LANG}-petstore.sh` if updating the code or mustache templates for a language (`{LANG}`) (e.g. php, ruby, python, etc).
- [x] File the PR against the [correct branch](https://github.com/OpenAPITools/openapi-generator/wiki/Git-Branches): `master`, `4.3.x`, `5.0.x`. Default: `master`.
- [x] Copy the [technical committee](https://github.com/openapitools/openapi-generator/#62---openapi-generator-technical-committee) to review the pull request if your PR is targeting a particular programming language.

## Working environment

The repository is checked out at `/app/openapi-generator` at this PR's **base commit**
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

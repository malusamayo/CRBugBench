# Code Review Task

You are a maintainer reviewing a pull request to the `OpenAPITools/openapi-generator` repository.

**PR title:** [kotlin-spring] use spring resource for file handling

**PR description:**

### PR checklist

- [x] Read the [contribution guidelines](https://github.com/openapitools/openapi-generator/blob/master/CONTRIBUTING.md).
- [x] Ran the shell script under `./bin/` to update Petstore sample so that CIs can verify the change. (For instance, only need to run `./bin/{LANG}-petstore.sh`, `./bin/openapi3/{LANG}-petstore.sh` if updating the {LANG} (e.g. php, ruby, python, etc) code generator or {LANG} client's mustache templates). Windows batch files can be found in `.\bin\windows\`.
- [x] Filed the PR against the [correct branch](https://github.com/OpenAPITools/openapi-generator/wiki/Git-Branches): `master`~~, `3.4.x`, `4.0.x`~~. Default: `master`.
- [x] Copied the [technical committee]( @https://github.com/openapitools/openapi-generator/#62---openapi-generator-technical-committee) to review the pull request if your PR is targeting a particular programming language.

### Description of the PR
Using spring ResponseEntity\<Resource> for handling file when generating an API who return a file with 
```
schema:  
  type: string
  format: binary
```
before it was ResponseEntity\<File> which only responded filename

@jimschubert @dr4ke616

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

# Code Review Task

You are a maintainer reviewing a pull request to the `OpenAPITools/openapi-generator` repository.

**PR title:** [Java] Respect User Supplied Header Params

**PR description:**

Work done in #20032 for the Java `okhttp-gson` generator only.

<!-- Please check the completed items below -->
### PR checklist
 
- [x] Read the [contribution guidelines](https://github.com/openapitools/openapi-generator/blob/master/CONTRIBUTING.md).
- [x] Pull Request title clearly describes the work in the pull request and Pull Request description provides details about how to validate the work. Missing information here may result in delayed response from the community.
- [x] Run the following to [build the project](https://github.com/OpenAPITools/openapi-generator#14---build-projects) and update samples:
  ```
  ./mvnw clean package 
  ./bin/generate-samples.sh ./bin/configs/*.yaml
  ./bin/utils/export_docs_generators.sh
  ``` 
  (For Windows users, please run the script in [Git BASH](https://gitforwindows.org/))
  Commit all changed files. 
  This is important, as CI jobs will verify _all_ generator outputs of your HEAD commit as it would merge with master. 
  These must match the expectations made by your contribution. 
  You may regenerate an individual generator by passing the relevant config(s) as an argument to the script, for example `./bin/generate-samples.sh bin/configs/java*`. 
  IMPORTANT: Do **NOT** purge/delete any folders/files (e.g. tests) when regenerating the samples as manually written tests may be removed.
- [x] File the PR against the [correct branch](https://github.com/OpenAPITools/openapi-generator/wiki/Git-Branches): `master` (upcoming `7.x.0` minor release - breaking changes with fallbacks), `8.0.x` (breaking changes without fallbacks)
- [x] If your PR is targeting a particular programming language, @mention the [technical committee](https://github.com/openapitools/openapi-generator/#62---openapi-generator-technical-committee) members, so they are more likely to review the pull request.

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

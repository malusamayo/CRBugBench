# Code Review Task

You are a maintainer reviewing a pull request to the `TeamNewPipe/NewPipe` repository.

**PR title:** Use range-limiting methods.

**PR description:**

<!-- Hey there. Thank you so much for improving NewPipe, and filling out the details. Having roughly the same layout helps everyone considerably :)-->

#### What is it?
- [ ] Bugfix (user facing)
- [ ] Feature (user facing)
- [x] Codebase improvement (dev facing)
- [ ] Meta improvement to the project (dev facing)

#### Description of the changes in your PR
<!-- While bullet points are the norm in this section, feel free to write free-form text instead of a list -->
- Use range-limiting methods, such as `MathUtils.clamp()` and Kotlin's `coerceIn()`.

#### Fixes the following issue(s)
<!-- Prefix issues with "Fixes" so that GitHub closes them when the PR is merged (note that each "Fixes #" should be in its own item). Also add any other relevant links. -->
- Fixes #

#### APK testing 
<!-- Use a new, meaningfully named branch. The name is used as a suffix for the app ID to allow installing and testing multiple versions of NewPipe, e.g. "commentfix", if your PR implements a bugfix for comments. (No names like "patch-0" and "feature-1".)  -->
<!-- Remove the following line if you directly link the APK created by the CI pipeline. Directly linking is preferred if you need to let users test.-->
The APK can be found by going to the "Checks" tab below the title. On the left pane, click on "CI", scroll down to "artifacts" and click "app" to download the zip file which contains the debug APK of this PR.

#### Due diligence
- [x] I read the [contribution guidelines](https://github.com/TeamNewPipe/NewPipe/blob/HEAD/.github/CONTRIBUTING.md).

## Working environment

The repository is checked out at `/app/NewPipe` at this PR's **base commit**
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

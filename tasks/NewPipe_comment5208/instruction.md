# Code Review Task

You are a maintainer reviewing a pull request to the `TeamNewPipe/NewPipe` repository.

**PR title:** Remove pbj=1 parameter from YouYube urls in recaptcha activity

**PR description:**

<!-- Hey there. Thank you so much for improving NewPipe, and filling out the details. Having roughly the same layout helps everyone considerably :)-->

#### What is it?
- [x] Bugfix (user facing)
- [ ] Feature (user facing)
- [ ] Codebase improvement (dev facing)
- [ ] Meta improvement to the project (dev facing)

#### Description of the changes in your PR
This PR removes the `pbj=1` parameter from the URLs loaded in the reCAPTCHA webview, so that an actual HTML page is loaded instead of the ajax json requested by the extractor, which would render as a blank page.

#### Fixes the following issue(s)
Hopefully fixes #3714

#### APK testing 
This apk throws a `ReCaptchaException` on every request, with the first request being the "test" search, always run on app opening.
[app-debug.zip](https://github.com/TeamNewPipe/NewPipe/files/5710472/app-debug.zip)

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

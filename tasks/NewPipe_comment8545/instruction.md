# Code Review Task

You are a maintainer reviewing a pull request to the `TeamNewPipe/NewPipe` repository.

**PR title:** Add option to hide future videos in feed

**PR description:**

#### What is it?
- [ ] Bugfix (user facing)
- [x] Feature (user facing)
- [ ] Codebase improvement (dev facing)
- [ ] Meta improvement to the project (dev facing)

#### Description of the changes in your PR
Allows to hide videos that are not yet released. Some accounts schedule videos to be released in the future and sorting by release date makes those videos to be always on top.

#### Before/After Screenshots/Screen Record
<table>
  <tr>
    <th>Before</th>
    <th>After</th>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/10256660/175574621-b1062d4d-6d14-41c5-83ae-9ab697d399fd.png" height="400px"/></td>
    <td><img src="https://user-images.githubusercontent.com/10256660/175574767-cd0f5e4f-902b-4a1a-bdbf-fbb9375ec395.png" height="400px"/></td>
  </tr>
</table>
Notice video release date saying "dentro de x meses" which means "in x months".

#### APK testing 
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

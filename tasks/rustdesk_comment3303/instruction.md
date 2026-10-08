# Code Review Task

You are a maintainer reviewing a pull request to the `rustdesk/rustdesk` repository.

**PR title:** improved devcontainer with Android build support

**PR description:**

Hi,

I've improved existing [devcontainer](https://github.com/rustdesk/rustdesk/tree/master/.devcontainer) with [new features](https://github.com/akhildevelops/rustdesk/tree/feature/devcontainer/.devcontainer) that supports local (mac/linux) and android builds in debug and release mode.

Features:
- Automatically builds local binaries in debug mode.
- Generate Android APKs with single command `.devcontainer/build.sh --release android`
- Option to generate debug / release binaries for both local and android
- Installs the dependencies required depending on the target platform. Ex: NDK Tools, Java, C++ libraries
- Creates <root>/flutter/android/key.properties  file for sigining APK builds

---

To use the dev environment, install docker and devcontainers extension in vscode.

Hit `ctrl shift p` for command pallete and hit `devcontainers: reopen in container`

![Screenshot from 2023-02-20 23-42-04](https://user-images.githubusercontent.com/6951100/220176211-c4a031ee-4d13-430f-8b25-5d431d7d77d5.png)

## Working environment

The repository is checked out at `/app/rustdesk` at this PR's **base commit**
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

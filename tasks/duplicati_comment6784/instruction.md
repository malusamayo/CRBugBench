# Code Review Task

You are a maintainer reviewing a pull request to the `duplicati/duplicati` repository.

**PR title:** Feature/Disk Image basic Mac support

**PR description:**

This PR is a continuation of #6766 with added support for Mac. 

# Main change

Disks are accesed through the raw block device interface, e.g. `/dev/rdisk4`. Like the original PR, disks are marked as source through remote sources: `@/testdisk|diskimage:///dev/disk4`. 

The unit tests have been modified for better cross-platform support. Further unit tests have been added that target Mac-specific systems. Where the Windows tests uses `.vhdx` files, the Mac variant uses `.dmg` images managed through the `hdiutil` and `diskutil` tools. 

Notably, due to dotnet being unable to make PInvoke calls to C functions with variadic arguments, a small C wrapper library has been made in `proprietary/DiskImage/Disk/macos_libSystem_wrapper.c`. This wrapper is compiled alongside the regular `dotnet build` using `clang` (which is assumed to be available on every Mac with development tools, such as the .NET SDK) and is shipped alongside the binaries of any project that references the `DiskImage` project. 

# Additional changes 

A race condition has been fixed in the backup flow, where the source provider would end up being disposed before the `parallelScanner`, which resulted in the `parallelScanner` making calls to the disposed disk interface. This has been handled by awaiting the `parallelScanner` task before disposing the source provider.

## Working environment

The repository is checked out at `/app/duplicati` at this PR's **base commit**
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

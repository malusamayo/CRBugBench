# Code Review Task

You are a maintainer reviewing a pull request to the `ansible/ansible` repository.

**PR title:** Force pkg_mgr yum for rhel < 8, dnf for rhel > 8 (#54010)

**PR description / commit message:**

Force pkg_mgr yum for rhel < 8, dnf for rhel > 8 (#54010)

* Force pkg_mgr yum for rhel < 8, dnf for rhel > 8

This solves the scenario in which someone using RHEL or a clone
decides to install dnf, which can break their system in certain ways
under certain scenarios (a dnf bug that's been resolved upstream but
left user systems broken happened recently). Currently Red Hat
provides dnf to RHEL7 in an optional Tech Preview Channel under the
YUM4 branding, as does the CentOS Content Management SIG. There may
be others in the ecosystem I'm not familiar with.

Signed-off-by: Adam Miller <admiller@redhat.com>

* add changelog

Signed-off-by: Adam Miller <admiller@redhat.com>

## Working environment

The repository is checked out at `/app/ansible` at this PR's **base commit**
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

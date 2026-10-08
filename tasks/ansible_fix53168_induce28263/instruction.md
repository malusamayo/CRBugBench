# Code Review Task

You are a maintainer reviewing a pull request to the `ansible/ansible` repository.

**PR title:** crypto: Add new module openssl_certificate (#28263)

**PR description / commit message:**

crypto: Add new module openssl_certificate (#28263)

This commit aims to add the openssl_certificate module.

This module allows a user to manage openssl certificates.
This module implement the notion of backend provider, making this module
extensible to anyone wish as long as a provider is coded for it.

The current three providers are the following:

  * selfsigned: Allows a user to self signed a certificate
  * acme: Allow a user to generate acme-based CA challenges certificate.
          (As of this writing this targets letsencrypt)
  * assertonly: Allow a user to assert the characteristic of her SSL
                certificate

Co-Authored-By: Markus Teufelberger <mteufelberger+ansible@mgit.at>

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

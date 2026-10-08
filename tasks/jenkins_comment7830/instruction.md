# Code Review Task

You are a maintainer reviewing a pull request to the `jenkinsci/jenkins` repository.

**PR title:** [JENKINS-70934] Remove Prototype usages from `buildListTable.jelly`

**PR description:**

See [JENKINS-70934](https://issues.jenkins.io/browse/JENKINS-70934) Remove Prototype usages from buildListTable.jelly

### Context

See [JENKINS-70906](https://issues.jenkins.io/browse/JENKINS-70906). Jenkins core currently uses [Prototype 1.7](https://github.com/prototypejs/prototype/releases/tag/1.7), released on November 15, 2010. The latest version is [Prototype 1.7.3](https://github.com/prototypejs/prototype/releases/tag/1.7.3), released on September 22, 2015. When an attempt was made to upgrade to 1.7.3 in 2018 in [JENKINS-49319](https://issues.jenkins.io/browse/JENKINS-49319), the change had to be reverted. Since this library has been unmaintained for the past 8 years, we ought to eliminate our dependency on it in favor of modern JavaScript APIs.

### Problem

See [JENKINS-70934](https://issues.jenkins.io/browse/JENKINS-70934). Usages of Prototype remain in `buildListTable.jelly`.

### Solution

Replace these usages with modern JavaScript APIs.

## Bonus

While I was here I fixed two CSP warnings by moving this code out of Jelly and into a JavaScript file.

### Testing done

Ran `mvn clean verify -Dtest=jenkins.widgets.BuildTimeTrendTest,jenkins.widgets.BuildListTableTest`. Verified interactively in the UI that the build time trend and the Computer view could still display the list correctly, and clicked on the console link successfully. Verified that the `script-src-attr`/`inline`/`javascript:tl.getBand(0).scrollToCenter(…` and `script-src-elem`/`inline`/`function displayBuilds(data) {` CSP warnings were present before this PR and gone after this PR. Noted that the `script-src-elem`/`inline`/`Timeline.DateTime…` CSP warning was present before and after this PR; this is technical debt that I am explicitly declining to clean up in this PR.

### Proposed changelog entries

N/A

### Proposed upgrade guidelines

N/A

### Submitter checklist

- [ ] The Jira issue, if it exists, is well-described.
- [ ] The changelog entries and upgrade guidelines are appropriate for the audience affected by the change (users or developers, depending on the change) and are in the imperative mood (see [examples](https://github.com/jenkins-infra/jenkins.io/blob/master/content/_data/changelogs/weekly.yml)).
  - Fill in the **Proposed upgrade guidelines** section only if there are breaking changes or changes that may require extra steps from users during upgrade.
- [ ] There is automated testing or an explanation as to why this change has no tests.
- [ ] New public classes, fields, and methods are annotated with `@Restricted` or have `@since TODO` Javadocs, as appropriate.
- [ ] New deprecations are annotated with `@Deprecated(since = "TODO")` or `@Deprecated(forRemoval = true, since = "TODO")`, if applicable.
- [ ] New or substantially changed JavaScript is not defined inline and does not call `eval` to ease future introduction of Content Security Policy (CSP) directives (see [documentation](https://www.jenkins.io/doc/developer/security/csp/)).
- [ ] For dependency updates, there are links to external changelogs and, if possible, full differentials.
- [ ] For new APIs and extension points, there is a link to at least one consumer.

### Desired reviewers

@mention

<!-- Comment:
If you need an accelerated review process by the community (e.g., for critical bugs), mention @jenkinsci/core-pr-reviewers.
-->

### Maintainer checklist

Before the changes are marked as `ready-for-merge`:

- [ ] There are at least two (2) approvals for the pull request and no outstanding requests for change.
- [ ] Conversations in the pull request are over, or it is explicit that a reviewer is not blocking the change.
- [ ] Changelog entries in the pull request title and/or **Proposed changelog entries** are accurate, human-readable, and in the imperative mood.
- [ ] Proper changelog labels are set so that the changelog can be generated automatically.
- [ ] If the change needs additional upgrade steps from users, the `upgrade-guide-needed` label is set and there is a **Proposed upgrade guidelines** section in the pull request title (see [example](https://github.com/jenkinsci/jenkins/pull/4387)).
- [ ] If it would make sense to backport the change to LTS, a Jira issue must exist, be a _Bug_ or _Improvement_, and be labeled as `lts-candidate` to be considered (see [query](https://issues.jenkins.io/issues/?filter=12146)).


<a href="https://gitpod.io/#https://github.com/jenkinsci/jenkins/pull/7830"><img src="https://gitpod.io/button/open-in-gitpod.svg"/></a>

## Working environment

The repository is checked out at `/app/jenkins` at this PR's **base commit**
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

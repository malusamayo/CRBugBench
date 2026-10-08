# Code Review Task

You are a maintainer reviewing a pull request to the `jenkinsci/jenkins` repository.

**PR title:** [JENKINS-71715] Allow plugins with alternate build log visualizations to handle console links from core and other plugins

**PR description:**

See [JENKINS-71715](https://issues.jenkins.io/browse/JENKINS-71715).

This PR introduces a new extension point `ConsoleUrlProvider`, which is intended to be used by Jelly files that link to the build console and plugins that redirect to the build console, in order for plugins which provide special build console visualizations (such as Pipeline: Graph View and Blue Ocean) to be able to serve their own visualizations in those contexts.

See downstream PRs here:
* An example of implementing `ConsoleUrlProvider`: https://github.com/jenkinsci/pipeline-graph-view-plugin/pull/289
* An example of using `Functions.getConsoleUrl` from a plugin: https://github.com/jenkinsci/workflow-job-plugin/pull/373
* An example of using `ConsoleUrlProvder.getRedirectUrl`: https://github.com/jenkinsci/pipeline-input-step-plugin/pull/145

I reviewed plugins in https://github.com/jenkinsci/bom for console links to see how they are affected by these changes, see https://github.com/jenkinsci/jenkins/pull/8321#issuecomment-1726449487.

### Testing done

New automated test added.

You can manually test the PR by running https://github.com/jenkinsci/pipeline-graph-view-plugin/pull/289 by itself. Note that you will have to configure "Console URL Provider" in either the global configuration or your user configuration for anything to  happen.

Here is a video of me testing [the downstream changes](https://github.com/jenkinsci/pipeline-graph-view-plugin/pull/289) with a Pipeline build:

https://github.com/jenkinsci/jenkins/assets/1068968/31a830f5-1012-4d99-bc80-8ed94e924078

### Proposed changelog entries

- Introduce an API for build visualization plugins to serve alternative build console views and an API for plugins to produce links to the build console.

### Proposed upgrade guidelines

N/A

### Submitter checklist
- [x] The Jira issue, if it exists, is well-described.
- [x] The changelog entries and upgrade guidelines are appropriate for the audience affected by the change (users or developers, depending on the change) and are in the imperative mood (see [examples](https://github.com/jenkins-infra/jenkins.io/blob/master/content/_data/changelogs/weekly.yml)). Fill in the **Proposed upgrade guidelines** section only if there are breaking changes or changes that may require extra steps from users during upgrade.
- [x] There is automated testing or an explanation as to why this change has no tests.
- [x] New public classes, fields, and methods are annotated with `@Restricted` or have `@since TODO` Javadocs, as appropriate.
- [x] New deprecations are annotated with `@Deprecated(since = "TODO")` or `@Deprecated(forRemoval = true, since = "TODO")`, if applicable.
- [x] New or substantially changed JavaScript is not defined inline and does not call `eval` to ease future introduction of Content Security Policy (CSP) directives (see [documentation](https://www.jenkins.io/doc/developer/security/csp/)).
- [x] For dependency updates, there are links to external changelogs and, if possible, full differentials.
- [x] For new APIs and extension points, there is a link to at least one consumer.

### Desired reviewers

@dwnusbaum 

Before the changes are marked as `ready-for-merge`:

### Maintainer checklist
- [x] There are at least two (2) approvals for the pull request and no outstanding requests for change.
- [x] Conversations in the pull request are over, or it is explicit that a reviewer is not blocking the change.
- [x] Changelog entries in the pull request title and/or **Proposed changelog entries** are accurate, human-readable, and in the imperative mood.
- [x] Proper changelog labels are set so that the changelog can be generated automatically.
- [x] If the change needs additional upgrade steps from users, the `upgrade-guide-needed` label is set and there is a **Proposed upgrade guidelines** section in the pull request title (see [example](https://github.com/jenkinsci/jenkins/pull/4387)).
- [x] If it would make sense to backport the change to LTS, a Jira issue must exist, be a _Bug_ or _Improvement_, and be labeled as `lts-candidate` to be considered (see [query](https://issues.jenkins.io/issues/?filter=12146)).

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

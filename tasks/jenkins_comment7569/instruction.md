# Code Review Task

You are a maintainer reviewing a pull request to the `jenkinsci/jenkins` repository.

**PR title:** Overhaul search with a Command Palette

**PR description:**

<img width="1440" alt="image" src="https://user-images.githubusercontent.com/43062514/210903061-16cbef2c-22b1-4c22-a3e0-987cdcfc86b9.png">

<img width="1440" alt="image" src="https://user-images.githubusercontent.com/43062514/210903040-663b5714-1b09-4ee9-85fc-fe62128747ee.png">

This PR introduces the Command Palette concept to Jenkins, first discussed back in the day in the [November 2021 UX SIG meeting](https://youtu.be/SxSObgwjwt8?t=3780). You've probably used something similar if you've used VS Code, Jenkins.io, GitHub, Spotify etc. They're handy overlays that allow you to quickly use your keyboard to navigate, be that searching for different pages or finding functions in menus.

This is an early implementation and as such doesn't have all the features I want it to have, such as grouped results, icons and richer details for results, all aimed at making the search experience in Jenkins easier to use. I'd also like for plugin developers to eventually be able to integrate with the Command Palette so they can provide their own rich results/actions, for example being able to change theme from the palette.

### Testing done

* Clicking the search button shows the Command Palette
* CMD + K shows the Command Palette
* Searching for terms brings up identical results to the previous search bar

### Proposed changelog entries

- Add Command Palette as replacement for search bar

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

@jenkinsci/sig-ux 

### Maintainer checklist

Before the changes are marked as `ready-for-merge`:

- [ ] There are at least two (2) approvals for the pull request and no outstanding requests for change.
- [ ] Conversations in the pull request are over, or it is explicit that a reviewer is not blocking the change.
- [ ] Changelog entries in the pull request title and/or **Proposed changelog entries** are accurate, human-readable, and in the imperative mood.
- [ ] Proper changelog labels are set so that the changelog can be generated automatically.
- [ ] If the change needs additional upgrade steps from users, the `upgrade-guide-needed` label is set and there is a **Proposed upgrade guidelines** section in the pull request title (see [example](https://github.com/jenkinsci/jenkins/pull/4387)).
- [ ] If it would make sense to backport the change to LTS, a Jira issue must exist, be a _Bug_ or _Improvement_, and be labeled as `lts-candidate` to be considered (see [query](https://issues.jenkins.io/issues/?filter=12146)).


<a href="https://gitpod.io/#https://github.com/jenkinsci/jenkins/pull/7569"><img src="https://gitpod.io/button/open-in-gitpod.svg"/></a>

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

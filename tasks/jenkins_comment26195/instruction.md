# Code Review Task

You are a maintainer reviewing a pull request to the `jenkinsci/jenkins` repository.

**PR title:** Add telemetry for password field masking

**PR description:**

Add telemetry to track usage of the password field masking.

Fixes https://github.com/jenkinsci/jenkins/issues/26194
<!-- Comment:
If the issue is not fully described in the issue tracker, add more information here (justification, pull request links, etc.).

 * We do not require an issue for minor improvements.
 * Major new features should have an issue created.
-->

### Testing done

Tested with `ExtensionList.lookupSingleton(jenkins.telemetry.impl.PasswordMasking).createContent()` while running SECURITY-1809 test (#permissionIsCorrectlyCheckedOnNestedObject) to reach a view using the masking.
Output: 
>`Result: {"components":{"ant":"520.vd082ecfb_16a_9","antisamy-markup-formatter":"173.v680e3a_b_69ff3","apache-httpcomponents-client-4-api":"4.5.14-269.vfa_2321039a_83","asm-api":"9.9-185.va_6c6b_3348b_c3","bootstrap5-api":"5.3.8-895.v4d0d8e47fea_d","bouncycastle-api":"2.30.1.82-277.v70ca_0b_877184","caffeine-api":"3.2.3-194.v31a_b_f7a_b_5a_81","checks-api":"373.vfe7645102093","cloudbees-folder":"6.1073.va_7888eb_dd514","command-launcher":"123.v37cfdc92ef67","commons-lang3-api":"3.20.0-109.ve43756e2d2b_4","commons-text-api":"1.15.0-210.v7480a_da_70b_9e","credentials":"1480.v2246fd131e83","display-url-api":"2.217.va_6b_de84cc74b_","echarts-api":"6.0.0-1165.vd1283a_3e37d4","eddsa-api":"0.3.0.1-29.v67e9a_1c969b_b_","font-awesome-api":"7.1.0-882.v1dfb_771e3278","gradle":"1.24","gson-api":"2.13.2-173.va_a_092315913c","instance-identity":"203.v15e81a_1b_7a_38","ionicons-api":"94.vcc3065403257","jackson2-api":"2.20.1-423.v13951f6b_6532","jakarta-activation-api":"2.1.3-1","jakarta-mail-api":"2.1.3-2","jakarta-xml-bind-api":"4.0.5-3.v3d5b_a_73965b_9","javax-activation-api":"1.2.0-8","javax-mail-api":"1.6.2-11","jaxb":"2.3.9-1","jdk-tool":"83.v417146707a_3d","jenkins-core":"2.548-SNAPSHOT","jquery3-api":"3.7.1-594.vb_3864f326cf0","json-api":"20250107-125.v28b_a_ffa_eb_f01","junit":"1380.v491ff054cd35","mailer":"525.v2458b_d8a_1a_71","matrix-auth":"3.2.9","matrix-project":"870.v9db_fcfc2f45b_","mina-sshd-api-common":"2.16.0-167.va_269f38cc024","mina-sshd-api-core":"2.16.0-167.va_269f38cc024","plugin-util-api":"6.1192.v30fe6e2837ff","prism-api":"1.30.0-630.va_e19d17f83b_0","scm-api":"724.v7d839074eb_5c","script-security":"1385.v7d2d9ec4d909","snakeyaml-api":"2.3-123.v13484c65210a_","sshd":"3.374.v19b_d59ce6610","structs":"362.va_b_695ef4fdf9","trilead-api":"2.284.v1974ea_324382","variant":"70.va_d9f17f859e0","workflow-api":"1398.v67030756d3fb_","workflow-step-api":"710.v3e456cc85233","workflow-support":"1010.vb_b_39488a_9841"},"masking":[{"className":"hudson.model.FreeStyleProject","closestAncestor":"jenkins.security.Security1809Test$PasswordAction","jellyView":"Security1809Test/PasswordAction/index.jelly","count":1}]}`

UI description:
<img width="997" height="222" alt="image" src="https://github.com/user-attachments/assets/b06fc87c-65bc-4cb8-966d-0757f9c4634a" />



<!-- Comment:
Provide a clear description of how this change was tested.
At minimum this should include proof that a computer has executed the changed lines.
Ideally this should include an automated test or an explanation as to why this change has no tests.
Note that automated test coverage is less than complete, so a successful PR build does not necessarily imply that a computer has executed the changed lines.
If automated test coverage does not exist for the lines you are changing, you must describe the scenario(s) in which you manually tested the change.
For frontend changes, include screenshots of the relevant page(s) before and after the change.
For refactoring and code cleanup changes, exercise the code before and after the change and verify the behavior remains the same.
-->

### Screenshots (UI changes only)

<!--
If your change involves a UI change, please include screenshots showing the before and after states.
-->

#### Before

#### After

### Proposed changelog entries

- Add telemetry for password field masking.

<!-- Comment:
The changelog entry should be in the imperative mood; e.g., write "do this"/"return that" rather than "does this"/"returns that".
For examples, see: https://www.jenkins.io/changelog/

Do not include the issue in the changelog entry.
Include the issue in the description of the pull request so that the changelog generator can find it and include it in the generated changelog.

You may add multiple changelog entries if applicable by adding a new entry to the list, e.g.
- First changelog entry
- Second changelog entry
-->

### Proposed changelog category

/label rfe

<!--
The changelog entry needs to have a category which is selected based on the label.
If there's no changelog then the label should be `skip-changelog`.

The available categories are:
* bug - Minor bug. Will be listed after features
* developer - Changes which impact plugin developers
* dependencies - Pull requests that update a dependency
* internal - Internal only change, not user facing
* into-lts - Changes that are backported to the LTS baseline
* localization - Updates localization files
* major-bug - Major bug. Will be highlighted on the top of the changelog
* major-rfe - Major enhancement. Will be highlighted on the top
* rfe - Minor enhancement
* regression-fix - Fixes a regression in one of the previous Jenkins releases
* removed - Removes a feature or a public API
* skip-changelog - Should not be shown in the changelog

Non-changelog categories:
* web-ui - Changes in the web UI

Non-changelog categories require a changelog category but should be used if applicable,
comma separate to provide multiple categories in the label command.
-->

### Proposed upgrade guidelines

N/A

<!-- Comment:
Leave the proposed upgrade guidelines in the pull request with the "N/A" value if no upgrade guidelines are needed.
The changelog generator relies on the presence of the upgrade guidelines section as part of its data extraction process.
-->

### Submitter checklist

- [X] The issue, if it exists, is well-described.
- [X] The changelog entries and upgrade guidelines are appropriate for the audience affected by the change (users or developers, depending on the change) and are in the imperative mood (see [examples](https://github.com/jenkins-infra/jenkins.io/blob/master/content/_data/changelogs/weekly.yml)). Fill in the **Proposed upgrade guidelines** section only if there are breaking changes or changes that may require extra steps from users during upgrade.
- [ ] There is automated testing or an explanation as to why this change has no tests.
- [X] New public classes, fields, and methods are annotated with `@Restricted` or have `@since TODO` Javadocs, as appropriate.
- [ ] New deprecations are annotated with `@Deprecated(since = "TODO")` or `@Deprecated(forRemoval = true, since = "TODO")`, if applicable.
- [ ] UI changes do not introduce regressions when enforcing the current default rules of [Content Security Policy Plugin](https://plugins.jenkins.io/csp/). In particular, new or substantially changed JavaScript is not defined inline and does not call `eval` to ease future introduction of Content Security Policy (CSP) directives (see [documentation](https://www.jenkins.io/doc/developer/security/csp/)).
- [ ] For dependency updates, there are links to external changelogs and, if possible, full differentials.
- [ ] For new APIs and extension points, there is a link to at least one consumer.

### Desired reviewers

@daniel-beck 

<!-- Comment:
If you need an accelerated review process by the community (e.g., for critical bugs), mention @jenkinsci/core-pr-reviewers.
-->

Before the changes are marked as `ready-for-merge`:

### Maintainer checklist

- [ ] There are at least two (2) approvals for the pull request and no outstanding requests for change.
- [ ] Conversations in the pull request are over, or it is explicit that a reviewer is not blocking the change.
- [ ] Changelog entries in the pull request title and/or **Proposed changelog entries** are accurate, human-readable, and in the imperative mood.
- [ ] Proper changelog labels are set so that the changelog can be generated automatically.
- [ ] If the change needs additional upgrade steps from users, the `upgrade-guide-needed` label is set and there is a **Proposed upgrade guidelines** section in the pull request title (see [example](https://github.com/jenkinsci/jenkins/pull/4387)).
- [ ] If it would make sense to backport the change to LTS, be a _Bug_ or _Improvement_, and either the issue or pull request must be labeled as `lts-candidate` to be considered.

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

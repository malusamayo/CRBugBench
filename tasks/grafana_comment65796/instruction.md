# Code Review Task

You are a maintainer reviewing a pull request to the `grafana/grafana` repository.

**PR title:** Plugins: Tracing: Disable distributed tracing for plugins by default

**PR description:**

<!--

Thank you for sending a pull request! Here are some tips:

1. If this is your first time, please read our contribution guide at https://github.com/grafana/grafana/blob/main/CONTRIBUTING.md

2. Ensure you include and run the appropriate tests as part of your Pull Request.

3. In a new feature or configuration option, an update to the documentation is necessary. Everything related to the documentation is under the docs folder in the root of the repository.

4. If the Pull Request is a work in progress, make use of GitHub's "Draft PR" feature and mark it as such.

5. If you can not merge your Pull Request due to a merge conflict, Rebase it. This gets it in sync with the main branch.

6. Name your PR as "<FeatureArea>: Describe your change", e.g. Alerting: Prevent race condition. If it's a fix or feature relevant for the changelog describe the user impact in the title. The PR title is used to auto-generate the changelog for issues marked with the "add to changelog" label.

7. If your PR content should be added to the What's New document for the next major or minor release, add the **add to what's new** label to your PR. Note that you should add this label to the main PR that introduces the feature; do not add this label to smaller PRs for the feature.

-->

**What is this feature?**

- Disable distributed tracing for plugins by default
- To enable it, the config must be populated like this:

```
[plugin.grafana-datasourcehttpbackend-datasource]
tracing = true
```

(+ have opentelemetry enabled on the Grafana instance)

- Moves `GF_PLUGIN_VERSION` env var for plugins initialization to the tracing-only env vars

**Why do we need this feature?**

Makes the distributed tracing for plugins act more like a "feature toggle" (disabled by default)

**Who is this feature for?**

Plugins developers, Grafana operators

**Which issue(s) does this PR fix?**:

<!--

- Automatically closes linked issue when the Pull Request is merged.

Usage: "Fixes #<issue number>", or "Fixes (paste link of issue)"

-->

Fixes #

**Special notes for your reviewer:**

Please check that:
- [x] It works as expected from a user's perspective.
- [x] If this is a pre-GA feature, it is behind a feature toggle.
- [x] The docs are updated, and if this is a [notable improvement](https://grafana.com/docs/writers-toolkit/writing-guide/contribute-release-notes/#how-to-determine-if-content-belongs-in-a-whats-new-document), it's added to our [What's New](https://grafana.com/docs/writers-toolkit/writing-guide/contribute-release-notes/) doc.
- [x] There are no known compatibility issues with older supported versions of Grafana, or plugins.
- [x] It passes the [Hosted Grafana feature readiness review](https://docs.google.com/document/d/1QL9Ly8KnXzpb6ISbg49pTODRO5mhA5tkkfIZVX6pqQU/edit) for observability, scalability, performance, and security.

## Working environment

The repository is checked out at `/app/grafana` at this PR's **base commit**
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

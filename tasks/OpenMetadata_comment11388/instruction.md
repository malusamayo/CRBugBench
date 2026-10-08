# Code Review Task

You are a maintainer reviewing a pull request to the `open-metadata/OpenMetadata` repository.

**PR title:** Impala Connection Profiler is_nan rollback; Histogram fix.

**PR description:**

<!--
Thank you for your contribution!
Unless your change is trivial, please create an issue to discuss the change before creating a PR.
-->

### Describe your changes:
Rolled back Impala Profiler is_nan checks.
Updated Histogram to use fallback Sturges rule calculation method when first and third quartiles are not available. 

Fixes <issue-number>

<!--
Short blurb explaining:
- What changes did you make?
- Why did you make them?
- How did you test your changes?
-->

I worked on ... because ...

<!-- For frontend related change, please add screenshots and/or videos of your changes preview! -->

#
### Type of change:
<!-- You should choose 1 option and delete options that aren't relevant -->
- [ ] Bug fix
- [ ] Improvement
- [ ] New feature
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation

#
### Checklist:
<!-- add an x in [] if done, don't mark items that you didn't do !-->
- [x] I have read the [**CONTRIBUTING**](https://docs.open-metadata.org/developers/contribute) document.
- [ ] My PR title is `Fixes <issue-number>: <short explanation>`
- [ ] I have commented on my code, particularly in hard-to-understand areas. 
- [ ] For JSON Schema changes: I updated the migration scripts or explained why it is not needed.

<!-- Based on the type(s) of your change, uncomment the required checklist 👇 -->

<!-- Bug fix
- [ ] I have added a test that covers the exact scenario we are fixing. For complex issues, comment the issue number in the test for future reference.
-->

<!-- Improvement
- [ ] I have added tests around the new logic.
- [ ] For connector/ingestion changes: I updated the documentation.
-->

<!-- New feature
- [ ] The issue properly describes why the new feature is needed, what's the goal, and how we are building it. Any discussion
    or decision-making process is reflected in the issue.
- [ ] I have updated the documentation.
- [ ] I have added tests around the new logic.
-->

<!-- Breaking change
- [ ] I have added the tag `Backward-Incompatible-Change`.
-->

## Working environment

The repository is checked out at `/app/OpenMetadata` at this PR's **base commit**
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

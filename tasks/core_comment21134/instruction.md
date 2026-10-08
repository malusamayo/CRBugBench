# Code Review Task

You are a maintainer reviewing a pull request to the `home-assistant/core` repository.

**PR title:** Fix track_change error in utility_meter

**PR description:**

## Description:

Python any() checks ALL member elements, this commit makes sure we return as soon as one of the states is None.

**Related issue (if applicable):** fixes #21122 

**Pull request in [home-assistant.io](https://github.com/home-assistant/home-assistant.io) with documentation (if applicable):** home-assistant/home-assistant.io#<home-assistant.io PR number goes here>

## Example entry for `configuration.yaml` (if applicable):
```yaml
utility_meter:
  daily_energy:
    source: sensor.aeotec_hem_kwh
    cycle: daily
```

## Checklist:
  - [x] The code change is tested and works locally.
  - [x] Local tests pass with `tox`. **Your PR cannot be merged unless tests pass**
  - [x] There is no commented out code in this PR.

If the code does not interact with devices:
  - [ ] Tests have been added to verify that the new code works.

[ex-requir]: https://github.com/home-assistant/home-assistant/blob/dev/homeassistant/components/keyboard/__init__.py#L14
[ex-import]: https://github.com/home-assistant/home-assistant/blob/dev/homeassistant/components/keyboard/__init__.py#L23

## Working environment

The repository is checked out at `/app/core` at this PR's **base commit**
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

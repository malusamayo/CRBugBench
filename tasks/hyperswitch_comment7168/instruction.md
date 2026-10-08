# Code Review Task

You are a maintainer reviewing a pull request to the `juspay/hyperswitch` repository.

**PR title:** feat(router): add `organization_id` in authentication table and add it in authentication events

**PR description:**

## Type of Change
<!-- Put an `x` in the boxes that apply -->

- [ ] Bugfix
- [x] New feature
- [ ] Enhancement
- [ ] Refactoring
- [ ] Dependency updates
- [ ] Documentation
- [ ] CI/CD

## Description
<!-- Describe your changes in detail -->
1. add `organization_id` in authentication table of postgres
2. add `organization_id` in kafka queue and authentications table of clickhouse
3. send `organization_id` while logging events to clickhouse

### Additional Changes

- [ ] This PR modifies the API contract
- [x] This PR modifies the database schema
- [ ] This PR modifies application configuration/environment variables

<!--
Provide links to the files with corresponding changes.

Following are the paths where you can find config files:
1. `config`
2. `crates/router/src/configs`
4. `loadtest/config`
-->


## Motivation and Context
<!--
Why is this change required? What problem does it solve?
If it fixes an open issue, please link to the issue here.

If you don't have an issue, we'd recommend starting with one first so the PR
can focus on the implementation (unless it is an obvious bug or documentation fix
that will have little conversation).
-->


## How did you test it?
<!--
Did you write an integration/unit/API test to verify the code changes?
Or did you test this change manually (provide relevant screenshots)?
-->
Tested Manually
Perform Sanity External 3DS payment to check organization_id being stored in authentication table
CURL
```
curl --location 'localhost:8080/payments/pay_EXpcC46YuZUwLX8DrXlA/3ds/authentication' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--header 'api-key: pk_dev_74ab7c8aac7c49d793f9c980c544a09f' \
--data '{
    "client_secret": "pay_EXpcC46YuZUwLX8DrXlA_secret_AcTKJleY3B1DFVdS3hlU",
    "device_channel": "BRW",
    "threeds_method_comp_ind": "Y"
}'
```

Database
![image](https://github.com/user-attachments/assets/228d20a1-6149-4080-8bf3-53bd6a23d166)

Kafka Queue
![image](https://github.com/user-attachments/assets/88a1ee0a-3c00-45cf-b01b-99482f04b749)

Clickhouse table
![image](https://github.com/user-attachments/assets/264fb5ea-4cb9-46dd-b775-e67510a4d04d)

## Checklist
<!-- Put an `x` in the boxes that apply -->

- [x] I formatted the code `cargo +nightly fmt --all`
- [x] I addressed lints thrown by `cargo clippy`
- [x] I reviewed the submitted code
- [ ] I added unit tests for my changes where possible

## Working environment

The repository is checked out at `/app/hyperswitch` at this PR's **base commit**
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

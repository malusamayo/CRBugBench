# Code Review Task

You are a maintainer reviewing a pull request to the `juspay/hyperswitch` repository.

**PR title:** feat(router): skip apple pay session call if the browser is not Safari

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
Currently, the Apple Pay session call is mandatory in all cases. This requirement also mandates configuring the initiative_context, which is the domain name where the Apple Pay payment is being processed. However, in the case of an iOS app, a domain is not required, so this field can be made optional. Additionally, in this case, the session call to Apple Pay can be skipped.

On the web, Apple Pay is supported only in Safari. Therefore, the session call should be skipped in web environments when the browser is not Safari.

### Additional Changes

- [ ] This PR modifies the API contract
- [ ] This PR modifies the database schema
- [ ] This PR modifies application configuration/environment variables

<!--
Provide links to the files with corresponding changes.

Following are the paths where you can find config files:
1. `config`
2. `crates/router/src/configs`
3. `loadtest/config`
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
-> Create merchant connector account with apple pay manual flow. Below is the metadata for the manual flow.
```
"session_token_data": {
                    "initiative": "web",
                    "certificate": "==",
                    "display_name": "applepay",
                    "certificate_keys": "",
                    "payment_processing_details_at": "Hyperswitch",
                    "payment_processing_certificate": "",
                    "payment_processing_certificate_key": "",
                    "initiative_context": "sdk-test-app.netlify.app",
                    "merchant_identifier": "",
                    "merchant_business_country": "US"
                }
```
-> Currently we make session call only if `x_client_platform` and `browsername` header None or if it is web and Safari respectively.

-> When mca is configured with write domain and header is not passed
```
curl --location 'http://localhost:8080/payments/session_tokens' \
--header 'Content-Type: application/json' \
--header 'api-key: pk_dev_7e0d9f48e20b430baa86eb956dc99142' \
--data '{
    "payment_id": "pay_7WAejcRN248R0Y7Kwsfh",
    "wallets": [],
    "client_secret": "pay_7WAejcRN248R0Y7Kwsfh_secret_CDL03LbGwQQnMPVA0Lq0"
}'
```
<img width="1135" alt="image" src="https://github.com/juspay/hyperswitch/assets/83439957/2b02346c-0013-432b-be1e-72fd4769f4a4">

-> When mca is configured with write domain and header is passed as 
```
curl --location 'http://localhost:8080/payments/session_tokens' \
--header 'Content-Type: application/json' \
--header 'browsername: Safari' \
--header 'x_client_platform: web' \
--header 'api-key: pk_dev_7e0d9f48e20b430baa86eb956dc99142' \
--data '{
    "payment_id": "pay_7WAejcRN248R0Y7Kwsfh",
    "wallets": [],
    "client_secret": "pay_7WAejcRN248R0Y7Kwsfh_secret_CDL03LbGwQQnMPVA0Lq0"
}'
```
<img width="1140" alt="image" src="https://github.com/juspay/hyperswitch/assets/83439957/e041b783-034a-46ca-a7f3-8c2c0ea03f07">

-> mac with write domain and wrong value in header
```
curl --location 'http://localhost:8080/payments/session_tokens' \
--header 'Content-Type: application/json' \
--header 'browsername: aa' \
--header 'x-client-platform: bb' \
--header 'api-key: pk_dev_7e0d9f48e20b430baa86eb956dc99142' \
--data '{
    "payment_id": "pay_oisWpJs0i1gXIpdYMqFp",
    "wallets": [],
    "client_secret": "pay_oisWpJs0i1gXIpdYMqFp_secret_fkzm5bW5WR5wssQxEo3f"
}'
```
<img width="1141" alt="image" src="https://github.com/juspay/hyperswitch/assets/83439957/ce7416de-ec0b-4e5d-b863-bb62b84f2c36">

-> If only one header is passed
```
curl --location 'http://localhost:8080/payments/session_tokens' \
--header 'Content-Type: application/json' \
--header 'x-client-platform: ios' \
--header 'api-key: pk_dev_7e0d9f48e20b430baa86eb956dc99142' \
--data '{
    "payment_id": "pay_oisWpJs0i1gXIpdYMqFp",
    "wallets": [],
    "client_secret": "pay_oisWpJs0i1gXIpdYMqFp_secret_fkzm5bW5WR5wssQxEo3f"
}'
```
<img width="1145" alt="image" src="https://github.com/juspay/hyperswitch/assets/83439957/babba52d-0ee2-4b5f-a989-ca4a7317c7d1">


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

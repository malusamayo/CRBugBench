# Code Review Task

You are a maintainer reviewing a pull request to the `juspay/hyperswitch` repository.

**PR title:** feat(business_profile): added merchant country code in business profile

**PR description:**

## Type of Change
<!-- Put an `x` in the boxes that apply -->

- [x] New feature


## Description
<!-- Describe your changes in detail -->

### 1. __Database Migration__

- __Added__: New migration `2025-07-02-071146_add-merchant-country-code-in-business-profile`

  - __Up migration__: Adds `merchant_country_code INTEGER` column to `business_profile` table
  - __Down migration__: Removes the `merchant_country_code` column

### 2. __Database Model Updates__

- __File__: `crates/diesel_models/src/business_profile.rs`

  - Added `merchant_country_code: Option<i32>` field to all profile structs:

    - `Profile` struct (both v1 and v2 versions)
    - `ProfileNew` struct (both v1 and v2 versions)
    - `ProfileUpdateInternal` struct (both v1 and v2 versions)

  - Updated `apply_changeset` methods to handle the new field

  - Field is positioned as the last field in all structs

### 3. __Domain Model Updates__

- __File__: `crates/hyperswitch_domain_models/src/business_profile.rs`

  - Added `merchant_country_code: Option<i32>` to domain `Profile` structs (both v1 and v2)
  - Added field to `ProfileSetter` structs
  - Updated `ProfileGeneralUpdate` structs to include the new field
  - Updated conversion methods (`convert`, `convert_back`, `construct_new`) to handle the field
  - Updated all `ProfileUpdate` enum variants to include `merchant_country_code: None` in update operations

### 4. __API Model Updates__

- __File__: `crates/api_models/src/admin.rs`

  - Added `merchant_country_code` field to profile-related structs:

    - `ProfileCreate` (both v1 and v2 versions)
    - `ProfileResponse` (both v1 and v2 versions)
    - `ProfileUpdate` (both v1 and v2 versions)

  - Field is documented with schema annotations: `value_type = Option<i32>, example = 840`

  - Field represents a numeric country code (e.g., 840 for United States)

## Key Technical Details

### __Data Type__:

- Uses `Option<i32>` to allow null values (optional field)
- Stores numeric country codes rather than alpha codes

### __Backward Compatibility__:

- All changes maintain backward compatibility by making the field optional
- Existing profiles will have `NULL` values for this field initially
- Database migration uses `IF NOT EXISTS` to safely add the column

### __Feature Flags__:

- Changes are properly segregated between v1 and v2 feature flags
- Both versions of the API support the new field

### __Integration Points__:

- Field is integrated into all CRUD operations for business profiles
- Conversion between different model layers (API → Domain → Database) properly handles the field
- Update operations preserve existing values when not explicitly changed


### Additional Changes

- [x] This PR modifies the API contract
- [x] This PR modifies the database schema
- [ ] This PR modifies application configuration/environment variables

<!--



## How did you test it?
<!--
Did you write an integration/unit/API test to verify the code changes?
Or did you test this change manually (provide relevant screenshots)?
-->

Do Profile Acquirer Create

```shell
curl --location 'localhost:8080/profile_acquirer' \
--header 'Content-Type: application/json' \
--header 'api-key: dev_yxuko5Ijbd9iJUbWT1EUGXH7tKDQXWXPSh7GAZY9BOsbSDsqFihTVSaMPwrMsGCC' \
--data '{
  "acquirer_assigned_merchant_id": "00002000000",
  "merchant_name": "Demo Merchant",
  "network": "AmericanExpress",
  "acquirer_bin": "400000",
  "acquirer_fraud_rate": 0.2345545234765,
  "profile_id": "pro_czw39KVGhlGIexP6JBzC"
}'
```

the response should return 200

Create Business_profile with `merchant_country_code`

curl --location 'http://localhost:8080/account/sahkal11/business_profile' \
--header 'Content-Type: application/json' \
--header 'api-key: dev_yxuko5Ijbd9iJUbWT1EUGXH7tKDQXWXPSh7GAZY9BOsbSDsqFihTVSaMPwrMsGCC' \
--data '{
    "profile_name": "dqwdwcweqcewcxqwcwqqd",
    "merchant_country_code": 840  
}
'

Response
```shell
{
    "merchant_id": "sahkal11",
    "profile_id": "pro_d1IU0buWxmb29dk9889e",
    "profile_name": "dqwdwcweqcewcxqwcwqqd",
    "return_url": "https://google.com/success",
    "enable_payment_response_hash": true,
    "payment_response_hash_key": "FFGOhmbQrxLOGIAGmsLSfwkgOGZY8l2ybzh8t7xd29apSI6C665ysYiuKtjB6U2O",
    "redirect_to_merchant_with_http_post": false,
    "webhook_details": {
        "webhook_version": "1.0.1",
        "webhook_username": "ekart_retail",
        "webhook_password": "password_ekart@123",
        "webhook_url": null,
        "payment_created_enabled": true,
        "payment_succeeded_enabled": true,
        "payment_failed_enabled": true,
        "payment_statuses_enabled": null,
        "refund_statuses_enabled": null,
        "payout_statuses_enabled": null
    },
    "metadata": null,
    "routing_algorithm": null,
    "intent_fulfillment_time": 900,
    "frm_routing_algorithm": null,
    "payout_routing_algorithm": null,
    "applepay_verified_domains": null,
    "session_expiry": 900,
    "payment_link_config": null,
    "authentication_connector_details": null,
    "use_billing_as_payment_method_billing": true,
    "extended_card_info_config": null,
    "collect_shipping_details_from_wallet_connector": false,
    "collect_billing_details_from_wallet_connector": false,
    "always_collect_shipping_details_from_wallet_connector": false,
    "always_collect_billing_details_from_wallet_connector": false,
    "is_connector_agnostic_mit_enabled": false,
    "payout_link_config": null,
    "outgoing_webhook_custom_http_headers": null,
    "tax_connector_id": null,
    "is_tax_connector_enabled": false,
    "is_network_tokenization_enabled": false,
    "is_auto_retries_enabled": false,
    "max_auto_retries_enabled": null,
    "always_request_extended_authorization": null,
    "is_click_to_pay_enabled": false,
    "authentication_product_ids": null,
    "card_testing_guard_config": {
        "card_ip_blocking_status": "disabled",
        "card_ip_blocking_threshold": 3,
        "guest_user_card_blocking_status": "disabled",
        "guest_user_card_blocking_threshold": 10,
        "customer_id_blocking_status": "disabled",
        "customer_id_blocking_threshold": 5,
        "card_testing_guard_expiry": 3600
    },
    "is_clear_pan_retries_enabled": false,
    "force_3ds_challenge": false,
    "is_debit_routing_enabled": false,
    "merchant_business_country": null,
    "is_pre_network_tokenization_enabled": false,
    "acquirer_configs": null,
    "is_iframe_redirection_enabled": null,
    "merchant_category_code": null,
    "merchant_country_code": "840"
}
```

the response should return 200

Try Updating business profile with `merchant_country_code`

```shell
curl --location 'http://localhost:8080/account/sahkal11/business_profile/pro_d1IU0buWxmb29dk9889e' \
--header 'Content-Type: application/json' \
--header 'api-key: dev_yxuko5Ijbd9iJUbWT1EUGXH7tKDQXWXPSh7GAZY9BOsbSDsqFihTVSaMPwrMsGCC' \
--data '
{
    "merchant_country_code": "840"
}
'
```

Response should return 200

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

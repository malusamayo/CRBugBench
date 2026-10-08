# Code Review Task

You are a maintainer reviewing a pull request to the `juspay/hyperswitch` repository.

**PR title:** Refactor(core): status handling for payment_method_status

**PR description:**

## Type of Change
<!-- Put an `x` in the boxes that apply -->

- [ ] Bugfix
- [ ] New feature
- [ ] Enhancement
- [ ] Refactoring
- [ ] Dependency updates
- [ ] Documentation
- [ ] CI/CD

## Description
<!-- Describe your changes in detail -->
Status for Payment Method is mapped according to the response received from connector.
If it is a Successful captured response we will set the PM as active.
else if it is failed it will set as inactive and for other states it will be in processing state.

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
Can be tested out by doing a retreive on a 3ds enabled payment.

We will have `payment_method_id` and `payment_method_status` in every payment's response(except Create).
Sample curl:
### `Payment` done using token: 

```
curl --location 'http://127.0.0.1:8080/payments' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--header 'api-key: dev_eZdRVkfE8sbYE7JSzm2Tu0HAca0PHRY6u3JoSFBukHuxoYeXw7bgwr7Gy2DJn1kS' \
--data-raw '{
    "amount": 6540,
    "currency": "USD",
    "confirm": false,
    "capture_method": "automatic",
    "capture_on": "2022-09-10T10:11:12Z",
    "amount_to_capture": 6540,
    "customer_id": "cus_v6LovN3Zs9k8QQ2UYcbi",
    "business_country": "US",
    "business_label": "default",
    "email": "guest@example.com",
    "name": "John Doe",
    "phone": "999999999",
    "phone_country_code": "+1",
    "description": "Its my first payment request",
    "authentication_type": "no_three_ds",
    "return_url": "https://google.com",
    "payment_method": "card",
    "payment_method_type": "credit",
    
    "payment_method_data": {
        "card": {
            "card_number": "4111111111111111",
            "card_exp_month": "10",
            "card_exp_year": "40",
            "card_holder_name": "John",
            "card_cvc": "737"
        }
    },
    "shipping": {
        "address": {
            "line1": "1467",
            "line2": "Harrison Street",
            "line3": "Harrison Street",
            "city": "San Fransico",
            "state": "California",
            "zip": "94122",
            "country": "US",
            "first_name": "joseph",
            "last_name": "Doe"
        },
        "phone": {
            "number": "8056594430",
            "country_code": "+91"
        }
    },
    "billing": {
        "address": {
            "line1": "1467",
            "line2": "Harrison Street",
            "line3": "Harrison Street",
            "city": "San Fransico",
            "state": "California",
            "zip": "94122",
            "country": "US",
            "first_name": "joseph",
            "last_name": "Doe"
        },
        "phone": {
            "number": "8056594427",
            "country_code": "+91"
        }
    },
    "statement_descriptor_name": "joseph",
    "statement_descriptor_suffix": "JS",
    "metadata": {
        "udf1": "value1",
        "new_customer": "true",
        "login_date": "2019-09-10T10:11:12Z"
    }
}

'
``` 

`Payment's Confirm`
```
{
    "payment_token": "token_XXXXXXXXX",
    "payment_method": "card",
    "card_cvc": "123"
}
``` 

Response should include these two fields
```
   "payment_method_id": "pm_pzFcNslye3gZLxUlmDbg",
    "payment_method_status": null
```
 (This will be updated after @vspecky [PR](https://github.com/juspay/hyperswitch/pull/4012) linking issue [here](https://github.com/juspay/hyperswitch/issues/4020))


### `Payment` done using Payment Data & Customer Acceptance: 
```
curl --location 'http://127.0.0.1:8080/payments' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--header 'api-key: dev_eZdRVkfE8sbYE7JSzm2Tu0HAca0PHRY6u3JoSFBukHuxoYeXw7bgwr7Gy2DJn1kS' \
--data-raw '{
    "amount": 6540,
    "currency": "USD",
    "confirm": false,
    "capture_method": "automatic",
    "capture_on": "2022-09-10T10:11:12Z",
    "amount_to_capture": 6540,
    "customer_id": "cus_v6LovN3Zs9k8QQ2UYcbi",
    "business_country": "US",
    "business_label": "default",
    "email": "guest@example.com",
    "name": "John Doe",
    "phone": "999999999",
    "phone_country_code": "+1",
    "description": "Its my first payment request",
    "authentication_type": "no_three_ds",
    "return_url": "https://google.com",
    "payment_method": "card",
    "payment_method_type": "credit",
    
    "payment_method_data": {
        "card": {
            "card_number": "4111111111111111",
            "card_exp_month": "10",
            "card_exp_year": "40",
            "card_holder_name": "John",
            "card_cvc": "737"
        }
    },
    "shipping": {
        "address": {
            "line1": "1467",
            "line2": "Harrison Street",
            "line3": "Harrison Street",
            "city": "San Fransico",
            "state": "California",
            "zip": "94122",
            "country": "US",
            "first_name": "joseph",
            "last_name": "Doe"
        },
        "phone": {
            "number": "8056594430",
            "country_code": "+91"
        }
    },
    "billing": {
        "address": {
            "line1": "1467",
            "line2": "Harrison Street",
            "line3": "Harrison Street",
            "city": "San Fransico",
            "state": "California",
            "zip": "94122",
            "country": "US",
            "first_name": "joseph",
            "last_name": "Doe"
        },
        "phone": {
            "number": "8056594427",
            "country_code": "+91"
        }
    },
    "statement_descriptor_name": "joseph",
    "statement_descriptor_suffix": "JS",
    "metadata": {
        "udf1": "value1",
        "new_customer": "true",
        "login_date": "2019-09-10T10:11:12Z"
    }
}
'
``` 

`Payment's Confirm`
```
curl --location 'http://127.0.0.1:8080/payments/pay_GnDHbieYt7GBDhJj79j3/confirm' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--header 'api-key: dev_eZdRVkfE8sbYE7JSzm2Tu0HAca0PHRY6u3JoSFBukHuxoYeXw7bgwr7Gy2DJn1kS' \
--data '{
    "payment_method": "card",
        "payment_method_data": {
        "card": {
            "card_number": "5555 5555 5555 4444",
            "card_exp_month": "03",
            "card_exp_year": "2030",
            "card_holder_name": "joseph Doe",
            "card_cvc": "737"
        }
    } ,  
  "retry_action": "manual_retry",
        "customer_acceptance": {
        "acceptance_type": "offline",
        "accepted_at": "1963-05-03T04:07:52.723Z",
        "online": {
            "ip_address": "in sit",
            "user_agent": "amet irure esse"
        }
    }
}'
``` 

Response should include these two fields null as we are doing the operation of saving card in tokio spawn.
```
    "payment_method_id": null,
    "payment_method_status": null
```


## Checklist
<!-- Put an `x` in the boxes that apply -->

- [x] I formatted the code `cargo +nightly fmt --all`
- [x] I addressed lints thrown by `cargo clippy`
- [x] I reviewed the submitted code
- [ ] I added unit tests for my changes where possible
- [ ] I added a [CHANGELOG](/CHANGELOG.md) entry if applicable

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

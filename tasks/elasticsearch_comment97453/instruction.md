# Code Review Task

You are a maintainer reviewing a pull request to the `elastic/elasticsearch` repository.

**PR title:** [NLP] Support the different mask tokens used by NLP models for Fill Mask

**PR description:**

This change adds a `mask_token` field to the `GET _ml/trained_models` API, as an enhancement to support [kibana#159577](https://github.com/elastic/kibana/issues/159577). 

The `mask_token` field reveals the particular mask token for needed each model deployed. Below is an example `inference_config` component of the API response, with the new `mask_token` field within `fill_mask`.

```
      "inference_config": {
        "fill_mask": {
          "vocabulary": {
            "index": ".ml-inference-native-000001"
          },
          "tokenization": {
            "roberta": {
              "do_lower_case": false,
              "with_special_tokens": true,
              "max_sequence_length": 512,
              "truncate": "first",
              "span": -1,
              "add_prefix_space": false
            }
          },
          "num_top_classes": 5,
          "mask_token": "<mask>"
        }
      },
```

## Working environment

The repository is checked out at `/app/elasticsearch` at this PR's **base commit**
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

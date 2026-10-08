# Code Review Task

You are a maintainer reviewing a pull request to the `meilisearch/meilisearch` repository.

**PR title:** Replace boolean by PatternMatch for searchable

**PR description:**

## Related issue

Change the Metadata structure to allow identifying if a field:
- match a feature
- doesn't match a feature
- is a parent field of a field matching the feature

This allows us to better explore the nested document without having to match the fields agaisnt the settings everywhere.

Diff:
```rust
pub struct Metadata {
    // old
    pub searchable: Option<Weight>,
    // new
    pub searchable: (PatternMatch, Option<Weight>),

    // old
    pub exact: bool,
    // new
    pub exact: PatternMatch,

    // old
    pub sortable: bool,
    // new
    pub sortable: PatternMatch,

    // old
    pub distinct: bool,
    // new
    pub distinct: PatternMatch,

    // old
    pub asc_desc: Option<FieldSortOrder>,
    // new
    pub asc_desc: (PatternMatch, Option<FieldSortOrder>),

    // old
    pub geo: bool,
    // new
    pub geo: PatternMatch,

    // old
    pub geo_json: bool,
    // new
    pub geo_json: PatternMatch,

    // old
    pub displayed: bool,
    // new
    pub displayed: PatternMatch,

    pub localized_attributes_rule_id: Option<NonZeroU16>,

    // old
    pub filterable_attributes_rule_id: Option<NonZeroU16>,
    // new
    pub filterable_attributes_rule_id: (PatternMatch, Option<NonZeroU16>),

    pub sort_by: OrderBy,
}
```

## Generative AI tools

- [x] This PR does not use generative AI tooling
- [ ] This PR uses generative AI tooling and respect the [related policies](https://github.com/meilisearch/meilisearch/blob/main/CONTRIBUTING.md#use-of-generative-ai-tools)
    - *list of used tools and what they were used for*

## Working environment

The repository is checked out at `/app/meilisearch` at this PR's **base commit**
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

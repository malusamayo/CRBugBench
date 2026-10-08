# Code Review Task

You are a maintainer reviewing a pull request to the `explosion/spaCy` repository.

**PR title:** Support negative examples in partial NER annotations

**PR description:**

Many spaCy components have some support for training from partial annotations, or annotations with missing information. In v2, there was partial support for training from entity annotations that specified that some sequence of tokens was _not_ an entity of a given label. However, there were many limitations to this functionality:

* The negative examples had to be specified in BILUO format, which meant each token could only be part of one negative entity. You couldn't specify two incorrect entities for a single span, or incorrect entities that overlapped.
* The exclusion mechanism looked at whether some _action_ was incorrect, which isn't really what we want. Even if an entity is incorrect, maybe we should still use the `B-` action on its first token, because it might just be the end-point of the entity that's incorrect.

In spaCy v3, we dropped support for this feature, as there was no good way to write these non-entity annotations into the `Doc` object to train from them.

This patch restores and improves the functionality:

* A new configuration key is added to the NER factory. This is provisionally called `negative_samples_key`, but we should change that to something better. This key is used to fetch a span-group from the reference parse. All spans in this group are treated as incorrect, and the NER will learn not to predict (exactly) those spans. The spans are allowed to overlap, so you can specify multiple incorrect labels now.

* The objective now handles the `B-` action correctly, and generally doesn't mark `B-` actions as incorrect, as the model can't assume no entity starts at that word. Perhaps we should have a config setting for this? This objective does give the greedy model little chance of learning from the partial annotations well. On the other hand, the greedy model is probably a bad choice for this anyway. The beam model really makes more sense here.

# TODOs

* [x] Test beam training
* [x] More tests
* [x] Fix naming
* [ ] Example project

## Checklist
<!--- Before you submit the PR, go over this checklist and make sure you can
tick off all the boxes. [] -> [x] -->

- [x] I have submitted the spaCy Contributor Agreement.
- [x] I ran the tests, and all new and existing tests passed.
- [x] My changes don't require a change to the documentation, or if they do, I've added all required information.

## Working environment

The repository is checked out at `/app/spaCy` at this PR's **base commit**
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

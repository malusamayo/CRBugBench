# Code Review Task

You are a maintainer reviewing a pull request to the `explosion/spaCy` repository.

**PR title:** Prototype: Entity linking with custom KBs

**PR description:**

<!--- Provide a general summary of your changes in the title. -->

## Description
<!--- Use this section to describe your changes. If your changes required
testing, include information about the testing environment and the tests you
ran. If your test fixes a bug reported in an issue, don't forget to include the
issue number. If your PR is still a work in progress, that's totally fine – just
include a note to let us know. -->
The current implementation of the candidate generation (CG) step in `develop` includes a batched version of CG. Following up on some internal experiments, it seems likely that information on the entire context of a document is useful for both CG and disambiguation. The batched version is insufficient to this end, since it doesn't pass on information on which entities/spans are part of which document to downstream steps of the NEL process.

This PR hence introduces a mode for CG lookups per document(s), with which entities are passed to the CG function as a `Generator[Iterable[Span], None, None]` - i.e. it is clear to the CG lookup which entities/spans belong to the same document. This mode can be enabled via the new config parameter `candidates_doc_mode` (alternative naming suggestions welcome). 

The NEL config still defaults to its previous values, so this is backwards-compatible with the current state of `master`, but not entirely for `develop` (which in itself is already slightly breaking for `KnowledgeBase`-related changes): 
- The NEL config parameter `candidates_batch_size` has been dropped, since batching is entirely up to the `KnowledgeBase` implementation now.
- Error `E1044` has been removed, since it was exclusively related to `candidates_batch_size`.
- `get_candidates_batch()` has been removed to `get_candidates_all()`.

This is a necessary precursor to changes in the CG and disambiguation logic and model architecture to incorporate additional information about the document context.

Note: the documentation will be updated once the code has been informally approved.

### Types of change
<!-- What type of change does your PR cover? Is it a bug fix, an enhancement
or new feature, or a change to the documentation? -->
Enhancement.

## Checklist
<!--- Before you submit the PR, go over this checklist and make sure you can
tick off all the boxes. [] -> [x] -->
- [x] I confirm that I have the right to submit this contribution under the project's MIT license.
- [x] I ran the tests, and all new and existing tests passed.
- [ ] My changes don't require a change to the documentation, or if they do, I've added all required information.

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

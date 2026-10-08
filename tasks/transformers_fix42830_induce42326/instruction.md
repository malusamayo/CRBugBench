# Code Review Task

You are a maintainer reviewing a pull request to the `huggingface/transformers` repository.

**PR title:** Fix processor usage + add chat_template support to TTS pipeline, and shift common chat template logic to base class. (#42326)

**PR description / commit message:**

Fix processor usage + add chat_template support to TTS pipeline, and shift common chat template logic to base class. (#42326)

* Fix processor usage and add chat_template support to TTS pipeline.

* Fallback to tokenizer for musicgen.

* Fallback to tokenizer for musicgen.

* Make style

* style/quality after update?

* FIx copied from

* Smaller things.

* Update src/transformers/pipelines/text_to_audio.py

Co-authored-by: Anton Vlasjuk <73884904+vasqu@users.noreply.github.com>

* Shift common utilities to chat template utils.

* Type nits

* Remove tied weights.

* Keep seamless error

* Better audio output object.

* Properly handle DIa and add test.

* Shift chat template prep to base, test dia batch.

* Backward compatibility for dicts passed to pipelines

* Simplify postprocessing and tests.

* Make quality/style

* Remove chat from image text to text.

* Only check first item, to not consume first item of generator inputs.

* Nit

* Simplify

* Add checks for bark/musicgen to ensure output is audio.

* Better var

---------

Co-authored-by: Anton Vlasjuk <73884904+vasqu@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/transformers` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.

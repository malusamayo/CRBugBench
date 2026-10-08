# Code Review Task

You are a maintainer reviewing a pull request to the `explosion/spaCy` repository.

**PR title:** Support 'memory zones' for user memory management (#13621)

**PR description / commit message:**

Support 'memory zones' for user memory management (#13621)

Add a context manage nlp.memory_zone(), which will begin
memory_zone() blocks on the vocab, string store, and potentially
other components.

Example usage:

```
with nlp.memory_zone():
    for text in nlp.pipe(texts):
        do_something(doc)
# do_something(doc) <-- Invalid
```

Once the memory_zone() block expires, spaCy will free any shared
resources that were allocated for the text-processing that occurred
within the memory_zone. If you create Doc objects within a memory
zone, it's invalid to access them once the memory zone is expired.

The purpose of this is that spaCy creates and stores Lexeme objects
in the Vocab that can be shared between multiple Doc objects. It also
interns strings. Normally, spaCy can't know when all Doc objects using
a Lexeme are out-of-scope, so new Lexemes accumulate in the vocab,
causing memory pressure.

Memory zones solve this problem by telling spaCy "okay none of the
documents allocated within this block will be accessed again". This
lets spaCy free all new Lexeme objects and other data that were
created during the block.

The mechanism is general, so memory_zone() context managers can be
added to other components that could benefit from them, e.g. pipeline
components.

I experimented with adding memory zone support to the tokenizer as well,
for its cache. However, this seems unnecessarily complicated. It makes
more sense to just stick a limit on the cache size. This lets spaCy
benefit from the efficiency advantage of the cache better, because
we can maintain a (bounded) cache even if only small batches of
documents are being processed.

## Working environment

The repository is checked out at `/app/spaCy` at this PR's **base commit**
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

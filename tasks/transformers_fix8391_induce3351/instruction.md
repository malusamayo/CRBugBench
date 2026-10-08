# Code Review Task

You are a maintainer reviewing a pull request to the `huggingface/transformers` repository.

**PR title:** Reformer (#3351)

**PR description / commit message:**

Reformer (#3351)

* first copy & past commit from Bert and morgans LSH code

* add easy way to compare to trax original code

* translate most of function

* make trax lsh self attention deterministic with numpy seed + copy paste code

* add same config

* add same config

* make layer init work

* implemented hash_vectors function for lsh attention

* continue reformer translation

* hf LSHSelfAttentionLayer gives same output as trax layer

* refactor code

* refactor code

* refactor code

* refactor

* refactor + add reformer config

* delete bogus file

* split reformer attention layer into two layers

* save intermediate step

* save intermediate step

* make test work

* add complete reformer block layer

* finish reformer layer

* implement causal and self mask

* clean reformer test and refactor code

* fix merge conflicts

* fix merge conflicts

* update init

* fix device for GPU

* fix chunk length init for tests

* include morgans optimization

* improve memory a bit

* improve comment

* factorize num_buckets

* better testing parameters

* make whole model work

* make lm model work

* add t5 copy paste tokenizer

* add chunking feed forward

* clean config

* add improved assert statements

* make tokenizer work

* improve test

* correct typo

* extend config

* add complexer test

* add new axial position embeddings

* add local block attention layer

* clean tests

* refactor

* better testing

* save intermediate progress

* clean test file

* make shorter input length work for model

* allow variable input length

* refactor

* make forward pass for pretrained model work

* add generation possibility

* finish dropout and init

* make style

* refactor

* add first version of RevNet Layers

* make forward pass work and add convert file

* make uploaded model forward pass work

* make uploaded model forward pass work

* refactor code

* add namedtuples and cache buckets

* correct head masks

* refactor

* made reformer more flexible

* make style

* remove set max length

* add attention masks

* fix up tests

* fix lsh attention mask

* make random seed optional for the moment

* improve memory in reformer

* add tests

* make style

* make sure masks work correctly

* detach gradients

* save intermediate

* correct backprob through gather

* make style

* change back num hashes

* rename to labels

* fix rotation shape

* fix detach

* update

* fix trainer

* fix backward dropout

* make reformer more flexible

* fix conflict

* fix

* fix

* add tests for fixed seed in reformer layer

* fix trainer typo

* fix typo in activations

* add fp16 tests

* add fp16 training

* support fp16

* correct gradient bug in reformer

* add fast gelu

* re-add dropout for embedding dropout

* better naming

* better naming

* renaming

* finalize test branch

* finalize tests

* add more tests

* finish tests

* fix

* fix type trainer

* fix fp16 tests

* fix tests

* fix tests

* fix tests

* fix issue with dropout

* fix dropout seeds

* correct random seed on gpu

* finalize random seed for dropout

* finalize random seed for dropout

* remove duplicate line

* correct half precision bug

* make style

* refactor

* refactor

* docstring

* remove sinusoidal position encodings for reformer

* move chunking to modeling_utils

* make style

* clean config

* make style

* fix tests

* fix auto tests

* pretrained models

* fix docstring

* update conversion file

* Update pretrained_models.rst

* fix rst

* fix rst

* update copyright

* fix test path

* fix test path

* fix small issue in test

* include reformer in generation tests

* add docs for axial position encoding

* finish docs

* Update convert_reformer_trax_checkpoint_to_pytorch.py

* remove isort

* include sams comments

* remove wrong comment in utils

* correct typos

* fix typo

* Update reformer.rst

* applied morgans optimization

* make style

* make gpu compatible

* remove bogus file

* big test refactor

* add example for chunking

* fix typo

* add to README

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

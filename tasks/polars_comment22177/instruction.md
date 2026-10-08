# Code Review Task

You are a maintainer reviewing a pull request to the `pola-rs/polars` repository.

**PR title:** feat: Support `DataFrame` and `Series` init from torch `Tensor` objects

**PR description:**

Closes #17453.
Closes #19120 (this PR supersedes it).

* Adds support for efficient Polars init from torch Tensors; takes advantage of zero-copy numpy intermediary conversion, so is cheap by default (note that Tensor detection is lazy, so adds no dependencies).
* The "force" param on `from_torch` is a pass-through to the same param found on Tensor [numpy conversion](https://pytorch.org/docs/stable/generated/torch.Tensor.numpy.html), so will be familiar to PyTorch users.
* As well as the new/dedicated `from_torch` method, can also pass a Tensor directly to the `pl.DataFrame` and `pl.Series` constructors. 
* The `schema` (and/or `schema_overrides`) param can be used to indicate whether to read the Tensor as individual columns, or as a single Array dtype.

## Examples

```python
import polars as pl
import torch

tnsr = torch.tensor([
  [1234.5, 200.0, 3000.5],
  [8000.0, 500.5, 6000.0],
])
```
`pl.from_torch` _(new method)_:
```python
df = pl.from_torch(tnsr, schema=["colx", "coly", "colz"])
# shape: (2, 3)
# ┌────────┬───────┬────────┐
# │ colx   ┆ coly  ┆ colz   │
# │ ---    ┆ ---   ┆ ---    │
# │ f32    ┆ f32   ┆ f32    │
# ╞════════╪═══════╪════════╡
# │ 1234.5 ┆ 200.0 ┆ 3000.5 │
# │ 8000.0 ┆ 500.5 ┆ 6000.0 │
# └────────┴───────┴────────┘

df = pl.from_torch(tnsr, schema={"tnsr": pl.Array(pl.Float32, 3)})
# shape: (2, 1)
# ┌─────────────────────────┐
# │ tnsr                    │
# │ ---                     │
# │ array[f32, 3]           │
# ╞═════════════════════════╡
# │ [1234.5, 200.0, 3000.5] │
# │ [8000.0, 500.5, 6000.0] │
# └─────────────────────────┘
```
`DataFrame` _(constructor)_:
```python
df = pl.DataFrame(data=tnsr, schema=["colx", "coly", "colz"])
# shape: (2, 3)
# ┌────────┬───────┬────────┐
# │ colx   ┆ coly  ┆ colz   │
# │ ---    ┆ ---   ┆ ---    │
# │ f32    ┆ f32   ┆ f32    │
# ╞════════╪═══════╪════════╡
# │ 1234.5 ┆ 200.0 ┆ 3000.5 │
# │ 8000.0 ┆ 500.5 ┆ 6000.0 │
# └────────┴───────┴────────┘

df = pl.DataFrame(tnsr, schema={"tnsr": pl.Array(pl.Float32, 3)})
# shape: (2, 1)
# ┌─────────────────────────┐
# │ tnsr                    │
# │ ---                     │
# │ array[f32, 3]           │
# ╞═════════════════════════╡
# │ [1234.5, 200.0, 3000.5] │
# │ [8000.0, 500.5, 6000.0] │
# └─────────────────────────┘
```
`Series` _(constructor)_:
```python
s = pl.Series("tnsr", values=tnsr)
# shape: (2,)
# Series: 'tnsr' [array[f32, 3]]
# [
#   [1234.5, 200.0, 3000.5]
#   [8000.0, 500.5, 6000.0]
# ]
```

## Working environment

The repository is checked out at `/app/polars` at this PR's **base commit**
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

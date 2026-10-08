# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/machinelearning` repository.

**PR title:** Fix memory leak and stale-model results when hot-swapping PredictionEnginePool

**PR description:**

## Description

This PR makes zero-downtime model hot-swapping in Microsoft.Extensions.ML safe under live traffic. Before this change, reloading a PredictionEnginePool had three problems. It leaked native memory, because the pool was built with new DefaultObjectPool, which never disposes the prediction engines it holds, so every reload abandoned a generation of native engines. It could also serve predictions from the old model, because a returned engine always went back to the current pool, so an engine rented against the previous model could be handed out by the new pool after a swap. And it risked disposing the shared model out from under other engines, because each engine was created with ownsTransformer set to true and so believed it solely owned the single shared transformer. 

This PR builds each pool generation with DefaultObjectPoolProvider, which returns the framework's DisposableObjectPool for disposable types and disposes engines for us. It routes each rented engine back to the exact generation it came from using a ConditionalWeakTable and disposes the old generation atomically on swap. It creates engines with ownsTransformer set to false, so PoolLoader owns the shared model's lifetime per generation and disposes it only when no surviving generation still uses it. PredictionEnginePool now also implements IDisposable, guards against use after disposal, and disposes its loaders so the file and uri watchers are torn down. New tests cover serving across an in-flight hot-swap, loader disposal, and a regression test that forces overflow disposal and confirms the shared model is never disposed.

## Working environment

The repository is checked out at `/app/machinelearning` at this PR's **base commit**
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

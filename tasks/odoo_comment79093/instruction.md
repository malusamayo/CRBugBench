# Code Review Task

You are a maintainer reviewing a pull request to the `odoo/odoo` repository.

**PR title:** [MERGE] sale: Convert onchanges into compute + improve perfs

**PR description:**

Purpose
=======

This is the first step of a technical cleaning of the sales
application. The final goal is to reduce the technical debt
and improve the performances / readability of the related
applications.

Some complex onchange methods containing purely business code
are defined, and called manually wherever the modifications
should be applied. This is a bad practice as there could be
a different business logic when making the same flow in the
interface or with python code.

Since #80449, it is now possible to add the precompute attribute on
stored computed fields to compute them before the insertion into the
database.

The idea is to convert this business code into compute methods to
apply it every time this is needed.

This is quite useful in our case in the sales application, as some of
the computed fields are required, and request some hacky overrides:
- in the create method, to simulate the onchange on new records, and
  to update the values dictionary
- in the default_get method, to set a default value, which has to
  side effect to prevent the field to be recomputed afterwards, which
  could also lead to inconsistencies.

This made impossible to convert the onchange methods into compute
methods.

Now, that is possible to precompute the fields before the database
insertion, it is now possible to remove all this crappy overhead,
to benefit from the batch method definitions, and to avoid creating
fake records to simulate the values that we should have computed
before.

On the other hand, this is the occasion to write some methods
(create, ...) in batch, to remove some dead code, to simplify
the api, to reorganize the code using our coding guidelines.

Results
======

The benefit of calling the computes in batch doesn't only bring 
functional consistencies, it also allow to improve the performances
without changing any existing features.

For example, let's have a look at the execution time and queries to
generate 1000 sales orders with 10 products lines each + 1 section
line, for 1000 different customers and shared between 2 salesmen.

We consider the "batch" time, aka the time to call the "create" method,
the flush time and the number of SQL queries.

In master:
    BATCH: 121.97 seconds
    FLUSH: 24.05 seconds 
    # queries: 53103

Now:
    BATCH: 113.07 seconds 
    FLUSH: 1.22 seconds 
    # queries 22057

This means a reduction of:
- 7.2% for the batch time
- 95% of the flush time
- 21.7% for the total time
- 58.5% for the number of SQL queries

Note that the effect of the precompute, the onchange methods
conversions, and the optimizations on this PR are emphasized
when the sales orders are related to the same partners.

If we take a look at the flamegraphs when creating 100 sales orders
of 3 lines each, we directly spot that the methods are now called once,
which also justify the large decrease of execution time and SQL queries.

Master:
![Screenshot from 2021-12-01 10-23-27](https://user-images.githubusercontent.com/8435879/144207460-5af36354-5ab6-4f83-846b-be71ab38ccc0.png)

Now:
![precompute](https://user-images.githubusercontent.com/8435879/144198634-1c32d9c9-0cf1-4011-a32f-b1edd7034d37.png)

TaskID: 2679099

Co-authored-by: Victor Feyens vfe@odoo.com

## Working environment

The repository is checked out at `/app/odoo` at this PR's **base commit**
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

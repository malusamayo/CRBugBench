# Code Review Task

You are a maintainer reviewing a pull request to the `react/react` repository.

**PR title:** [Flight] Preload <img> and <link> using hints before they're rendered (#34604)

**PR description / commit message:**

[Flight] Preload <img> and <link> using hints before they're rendered (#34604)

In Fizz and Fiber we emit hints for suspensey images and CSS as soon as
we discover them during render. At the beginning of the stream. This
adds a similar capability when a Host Component is known to be a Host
Component during the Flight render.

The client doesn't know that these resources are in the payload until it
parses that particular component which is lazy. So they need to be
hoisted with hints. We detect when these are rendered during Flight and
add them as hints. That allows you to consume a Flight payload to
preload prefetched content without having to render it.

`<link rel="preload">` can be hoisted more or less as is.

`<link rel="stylesheet">` we preload but we don't actually insert them
anywhere until they're rendered. We do these even for non-suspensey
stylesheets since we know that when they're rendered they're going to
start loading even if they're not immediately used. They're never lazy.

`<img src>` we only preload if they follow the suspensey image pattern
since otherwise they may be more lazy e.g. by if they're in the
viewport. We also skip if they're known to be inside `<picture>`. Same
as Fizz. Ideally this would preload the other `<source>` but it's
tricky.

The downside of this is that you might conditionally render something in
only one branch given a client component. However, in that case you're
already eagerly fetching the server component's data in that branch so
it's not too much of a stretch that you want to eagerly fetch the
corresponding resources as well. If you wanted it to be lazy, you
should've done a lazy fetch of the RSC.

We don't collect hints when any of these are wrapped in a Client
Component. In those cases you might want to add your own preload to a
wrapper Shared Component.

Everything is skipped if it's known to be inside `<noscript>`.

Note that the format context is approximate (see #34601) so it's
possible for these hints to overfetch or underfetch if you try to trick
it. E.g. by rendering Server Components inside a Client Component that
renders `<noscript>`.

---------

Co-authored-by: Josh Story <josh.c.story@gmail.com>

## Working environment

The repository is checked out at `/app/react` at this PR's **base commit**
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

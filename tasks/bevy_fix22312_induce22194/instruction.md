# Code Review Task

You are a maintainer reviewing a pull request to the `bevyengine/bevy` repository.

**PR title:** `DirectionalNavigationMap` no longer caches `AutoDirectionalNavigation` node connections (#22194)

**PR description / commit message:**

`DirectionalNavigationMap` no longer caches `AutoDirectionalNavigation` node connections (#22194)

# Objective

- Fixes #21949 

## Solution 

At the suggestion of @viridia and affirmed by @ickshonpe on Discord, the
directional navigation map should no longer contain any
`AutoDirectionalNavigation` node connections. This PR:
- Removes the system that inserts those types of connections into the
map and places the burden of the map’s management fully onto the
developer. The directional navigation map is now only used to specify
**manual** edges.
- Adds a brute force search among `AutoDirectionalNavigation` nodes
within the `navigate` function of the `DirectionalNavigation` system
parameter. `navigate` will prefer to find a destination within the map
of manual edges first before conducting the brute force search.

## Testing

- Did you test these changes? If so, how?
There are two relevant examples that I tested to ensure there were no
regressions:
`cargo run --example directional_navigation`: manually defined edges are
respected. Navigating east and west along the same row loops correctly,
and navigating north and south along a column works without looping as
specified in the example.
`cargo run --example auto_directional_navigation`: Navigation also works
as expected here.
However, I did not manually test whether removing an
`AutoDirectionalNavigation` node during execution of an app results in
the navigation system adapting, but I assume it would be evident since
the algorithm is no longer using a cached map of those types of edges.
- Are there any parts that need more testing?
I wanted to have a go at writing an automated test for the “automatic”
portion of it, but I got stuck trying to get the spawned nodes to have
valid values for their `ComputedNode` and `UiGlobalTransform` (values
that didn't represent zero sized content or no translation despite my
attempts at specifying so). I just stuck to validating that behavior via
the auto_directional_navigation example.
It would be nice to have a test with both automatic and manual
navigation would be nice to have, but may be overkill. It’s just
relatively simple if/else logic there.
- How can other people (reviewers) test your changes? Is there anything
specific they need to know?
You can test out the examples to make sure that the directional
navigation behaves as expected. If you’d like to go above and beyond,
you could try removing some `AutoDirectionalNavigation` nodes during
execution and seeing if navigation adapts.
- If relevant, what platforms did you test these changes on, and are
there any important ones you can't test?
I’ve only run the examples on MacOS

## Working environment

The repository is checked out at `/app/bevy` at this PR's **base commit**
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

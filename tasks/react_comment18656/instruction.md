# Code Review Task

You are a maintainer reviewing a pull request to the `react/react` repository.

**PR title:** DevTools: Improved "native" component stacks

**PR description:**

DevTools provides an option to automatically append "component stacks" to third party warnings (`console.warn`) and errors (`console.error`):

![image](https://user-images.githubusercontent.com/29597/79606391-62477c80-80a6-11ea-8cb5-cc4f27999a09.png)

This works by...
1. DevTools intercepts calls to `console.warn` and `console.error`.
2. If React is currently rendering a component, then the error is related.
3. DevTools looks to see if the error (or warning) already contain a stack string
4. If it doesn't, it appends one.

This PR builds on top of some previous React PRs (#18561 and #18575) to:
* Properly detects the new, experimental component stack format for Chrome, Firefox, and Safari, and
* Use a fork of React's new component stack implementation so that the appended console stacks are properly formatted and clickable.

## Testing

I used Code Sandbox to create a [small test](https://codesandbox.io/s/falling-firefly-9ul27) that included a React warning (with component stack) and a user warning (without one).

### Chrome (and Edge) <sup>1</sup>

#### React v16.9 (and newer)
<img width="744" alt="Screen Shot 2020-04-20 at 3 06 13 PM" src="https://user-images.githubusercontent.com/29597/79804359-b6f22e00-8318-11ea-93a9-1ef72e02cbff.png">

#### React v16.8 (and older)
<img width="739" alt="Screen Shot 2020-04-20 at 3 06 53 PM" src="https://user-images.githubusercontent.com/29597/79804368-b8bbf180-8318-11ea-87e5-2504ac07adc9.png">

### Firefox
<img width="670" alt="Screen Shot 2020-04-20 at 3 05 20 PM" src="https://user-images.githubusercontent.com/29597/79804567-223c0000-8319-11ea-9576-6d6697cd43cb.png">

### Safari <sup>2</sup>
<img width="741" alt="Screen Shot 2020-04-20 at 3 03 04 PM" src="https://user-images.githubusercontent.com/29597/79804548-1a7c5b80-8319-11ea-8dc6-a491a751f1a7.png">

<sup>1</sup> Custom component stacks are now clickable in Chrome. They aren't clickable in Firefox but at least they look more native.

<sup>2</sup> Safari does not display newlines properly for any console params after the first. It just shows "⏎ ". Oh well. I guess this is okay since DevTools doesn't support Safari anyway. I used the local DevTools shell to test it all the same.

## Working environment

The repository is checked out at `/app/react` at this PR's **base commit**
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

# Code Review Task

You are a maintainer reviewing a pull request to the `ionic-team/ionic-framework` repository.

**PR title:** fix(react): lifecycle events are removed on page unmount (#28316)

**PR description / commit message:**

fix(react): lifecycle events are removed on page unmount (#28316)

Issue number: N/A

---------

<!-- Please do not submit updates to dependencies unless it fixes an
issue. -->

<!-- Please try to limit your pull request to one type (bugfix, feature,
etc). Submit multiple pull requests if needed. -->

## What is the current behavior?
<!-- Please describe the current behavior that you are modifying. -->

While debugging #28186, Maria and I identified that Ionic's lifecycle
event listeners (`ionViewWillEnter`, etc.) were being registered
multiple times on the same `.ion-page` element. This resulted in
problematic behavior, where a user's implementation of our lifecycle
hooks, would execute their callback multiple times.

```ts
useIonViewWillEnter(() => {
  // This is called 2x for every time the `ionViewWillEnter` event is emitted (in React 18, dev mode)
  console.log('hello world'); 
});
```

When the Ionic lifecycle event listeners are registered in React, we
bind the scope of the class to the callback function. When removing the
event listener we additional use the `.bind` syntax.

```tsx
componentDidMount() {
  element.addEventListener('ionViewWillEnter', this.ionViewWillEnter.bind(this));
} 

componentWillUnmount() {
  // This creates a new instance of the function to remove! It doesn't remove the original event listener.
  element.removeEventListener('ionViewWillEnter', this.ionViewWillEnter.bind(this)); 
}
```

The `.bind` method returns a new instance of the function. This means in
the implementation we are creating a new instance of the function when
both adding and removing the event listener - resulting in the
`removeEventListener` to never remove the original event listener.

This behavior only occurred in React 18 in dev mode, as a result of the
mount/unmount behavior running 2x for `useEffect` hooks.

## What is the new behavior?
<!-- Please describe the behavior or changes that are being added by
this PR. -->

- Ionic lifecycle event listeners are removed from element references
when they are unmounted.
- User's lifecycle callback methods are only invoked once per event
emission.

|Before|After|
|----|----|
|<img alt="CleanShot 2023-10-09 at 18 32 08@2x"
src="https://github.com/ionic-team/ionic-framework/assets/13732623/53f2ef5d-5900-4a84-b427-fa6c9d35d081">|<img
alt="CleanShot 2023-10-09 at 18 29 37@2x"
src="https://github.com/ionic-team/ionic-framework/assets/13732623/c8a9a657-a0bf-4d6d-9f21-a41a686de490">|


## Does this introduce a breaking change?

- [ ] Yes
- [x] No

<!-- If this introduces a breaking change, please describe the impact
and migration path for existing applications below. -->


## Other information

<!-- Any other information that is important to this PR such as
screenshots of how the component looks before and after the change. -->

---------

Co-authored-by: Maria Hutt <maria@ionic.io>
Co-authored-by: Amanda Johnston <90629384+amandaejohnston@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/ionic-framework` at this PR's **base commit**
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

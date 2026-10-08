#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/react/src/hooks/useController.ts`:

This pull request introduces the defect later reported as "bug: React overlay hooks (useIon*) are not fully memorised ". The
problem a user observed, and its root cause:

### Prequisites

- [X] I have read the [Contributing Guidelines](https://github.com/ionic-team/ionic-framework/blob/main/.github/CONTRIBUTING.md#creating-an-issue).
- [X] I agree to follow the [Code of Conduct](https://ionicframework.com/code-of-conduct).
- [X] I have searched for [existing issues](https://github.com/ionic-team/ionic-framework/issues) that already report this problem, without success.

### Ionic Framework Version

- [ ] v4.x
- [X] v5.x
- [ ] v6.x

### Current Behavior

Using the [new overlay hooks](https://ionicframework.com/blog/introducing-the-new-overlay-hooks-for-ionic-react/) feels great and is a nice improvement in my opinion. When using them I noticed that for `useIon{Toast|Alert|Popover|...}` the results aren't memorised and change each render. This will cause a great deal of overhead when the `present`/`dismiss` methods will be dependencies of other `useEffects`. 

You can see a demo of this behaviour [here](https://codesandbox.io/s/ionic-hooks-memorisation-5o4yc?file=/src/App.tsx)

### Expected Behavior

All the `useIon*` hooks should memorised the returned `present`/`dismiss` to match developers expectation. 

### Steps to Reproduce

1. Use any of the new overlay hooks e.g. `useIonToast`
2. Make it a dependency of `React.useEffect(..., [presentToast])`
3. See that this effect is reevaluated each time the component is rendered. 

### Code Reproduction URL

https://codesandbox.io/s/ionic-hooks-memorisation-5o4yc?file=/src/App.tsx

### Ionic Info

_No response_

### Additional Information

I tracked this issue down to `useController`. Adding some `React.useCallback` here
https://github.com/ionic-team/ionic-framework/blob/7315e0157b917d2e3586c64f8082026827812943/packages/react/src/hooks/useController.ts#L38
and here
https://github.com/ionic-team/ionic-framework/blob/7315e0157b917d2e3586c64f8082026827812943/packages/react/src/hooks/useController.ts#L74
and a `React.useMemo`
https://github.com/ionic-team/ionic-framework/blob/7315e0157b917d2e3586c64f8082026827812943/packages/react/src/hooks/useController.ts#L79-L82
will ensure that the `controller` is memorised. Looking at the other `useIon*` hooks should be straight forward. Fixing `useIonToast` would need a `React.useCallback` here
https://github.com/ionic-team/ionic-framework/blob/7315e0157b917d2e3586c64f8082026827812943/packages/react/src/hooks/useIonToast.ts#L18

If you think this is something that should be implemented I can create a PR for these changes.

This same root cause must be fixed before merging.
REVIEW_EOF

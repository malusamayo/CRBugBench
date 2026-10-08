#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/react/src/components/navigation/IonTabs.tsx`:

This pull request introduces the defect later reported as "bug: "CustomElements not defined" while executing the unit tests.". The
problem a user observed, and its root cause:

### Prerequisites

- [X] I have read the [Contributing Guidelines](https://github.com/ionic-team/ionic-framework/blob/main/.github/CONTRIBUTING.md#creating-an-issue).
- [X] I agree to follow the [Code of Conduct](https://ionicframework.com/code-of-conduct).
- [X] I have searched for [existing issues](https://github.com/ionic-team/ionic-framework/issues) that already report this problem, without success.

### Ionic Framework Version

- [ ] v4.x
- [ ] v5.x
- [X] v6.x

### Current Behavior

We were executing our unit tests using Mocha test runner but after importing `@ionic/react` (version: 5.8.4) in our components, mocha started to throw error before getting to any test case. Everything else is working fine on web and IOS/Android devices, but we are not able to get a workaround for our unit tests. We have debugged ourselves and we like to share our findings. `customElements` is a method available in a window object. Since we are using a `jsdom`, we do get `window.customElements` in our test cases. However, in ionic code, we found that there was a piece of code which is accessing `customElements` method using `window` in `if` condition and inside `if` block, it is using `this` reference to access customElements method which will definitely throw an error since `this` is not equal to `window` in the test runner env.
Attaching the buggy code, we can also post a PR for the fix if it's too much work but if possible, please expedite it.

Thank you

```
if (typeof window !== 'undefined' && window.customElements) {
    const element = customElements.get('ion-tabs'); // should be window.customElements
    if (!element) {
        customElements.define('ion-tabs', IonTabsElement); / should be window.customElements
    }
}
```

### Expected Behavior

Should execute in test env as well.

### Steps to Reproduce

You can use any test runner to run any dummy test case, it should throw an error right if you are testing component has imported `@ionic/react`. 

### Code Reproduction URL

_No response_

### Ionic Info

@ionic/react":  5.8.4
jsdom: 16.6.0
mocha: 8.4.0

### Additional Information

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF

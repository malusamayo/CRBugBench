#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/react/src/routing/PageManager.tsx`:

This pull request introduces the defect later reported as "bug: React Router renders white page with Redirect". The
problem a user observed, and its root cause:

### Prerequisites

- [X] I have read the [Contributing Guidelines](https://github.com/ionic-team/ionic-framework/blob/main/.github/CONTRIBUTING.md#creating-an-issue).
- [X] I agree to follow the [Code of Conduct](https://ionicframework.com/code-of-conduct).
- [X] I have searched for [existing issues](https://github.com/ionic-team/ionic-framework/issues) that already report this problem, without success.

### Ionic Framework Version

v7.x

### Current Behavior

From the version **v7.5.1**, there is a bug with the Redirect component.

Let's suppose that we want to manage our routes with authentication and that the routes redirect to the login or home page depending on a context (ex. Redux state)

A possible route definition can be like this:
```tsx
<IonReactRouter>
    <IonRouterOutlet>
        <Route path="/login" exact render={() => !auth.isAuth ? <Login/> : <Redirect to="/"/>}/>
        <Route path="/" exact render={() => auth.isAuth ? <Home/> : <Redirect to="/login"/>}/>
        <Route path="/about" exact render={() => auth.isAuth ? <About/> : <Redirect to="/login"/>}/>
    </IonRouterOutlet>
</IonReactRouter>
```

If I'm on the login page and the state changes, the component Redirect works correctly and it redirects me to the home page. 
The problem occurs if I come back to the login page (for example with the logout): the page will be blank.

### Expected Behavior

The page renders correctly as in previous versions. (`<= v7.5.0`)

### Steps to Reproduce

1. Render the first page;
2. Change the global state to render the Redirect component;
3. Return to the first page with another state change;

### Code Reproduction URL

https://github.com/lorenzo-bonatti/my-ionic-app

### Ionic Info

```shell
Ionic:

   Ionic CLI       : 7.2.0
   Ionic Framework : @ionic/react 7.6.4

Utility:

   cordova-res : not installed globally
   native-run  : not installed globally

System:

   NodeJS : v20.11.0 (/home/lorenzo/.asdf/installs/nodejs/20.11.0/bin/node)
   npm    : 10.2.4
   OS     : Linux 6.5
```

### Additional Information

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF

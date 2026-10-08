# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/maui` repository.

**PR title:** [uitests] Run Control gallery tests with cake on iOS and Android

**PR description:**

### Description of Change

Adds new targets to cake to run our old UItests on control gallery

Example of usage:
Build the Build tasks, build the ControlGallery for a specific platform, run the platform cake script with `cg-uitest` target, parameters are the app, the uitest project, and you can filter using the `where` clause.

iOS
```
# build the build tasks
dotnet cake --target=dotnet-buildtasks --configuration=Debug --workloads=global

# build the Control Gallery for iOS
dotnet cake --target=dotnet-legacy-controlgallery-ios --configuration=Debug --ios --workloads=global

# run the uitests 
dotnet cake -Script eng/devices/ios.cake --target=cg-uitest --project="/Users/ruimarinho/dotnet/maui/src/Compatibility/ControlGallery/test/iOS.UITests/Compatibility.ControlGallery.iOS.UITests.csproj" --appproject="/Users/ruimarinho/dotnet/maui/src/Compatibility/ControlGallery/src/iOS/Compatibility.ControlGallery.iOS.csproj" --configuration="Debug" --device=ios-simulator-64 --apiversion="16.4" --where="cat==Issues"
```

Android
```
# build the build tasks
dotnet cake --target=dotnet-buildtasks --configuration=Debug --workloads=global

# build the Control Gallery for Android
dotnet cake --target=dotnet-legacy-controlgallery-android --configuration=Debug --android --workloads=global

# run the uitests 
dotnet cake -Script eng/devices/android.cake --target=cg-uitest --project="/Users/ruimarinho/dotnet/maui/src/Compatibility/ControlGallery/test/Android.UITests/Compatibility.ControlGallery.Android.UITests.csproj" --appproject="/Users/ruimarinho/dotnet/maui/src/Compatibility/ControlGallery/src/Android/Compatibility.ControlGallery.Android.csproj" --configuration="Release" --device="android-emulator-64_32" --where="cat==Lifecycle"

```

know issues: Needs to run on Debug, Android is crashing running on release and Calabash is enable only on debug on iOS

## Working environment

The repository is checked out at `/app/maui` at this PR's **base commit**
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

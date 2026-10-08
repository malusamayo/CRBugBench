#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/adapters/fetch.js`:

This pull request introduces the defect later reported as "fetch adapter: Streaming request bodies is not supported [react-native]". The
problem a user observed, and its root cause:

### Describe the bug

Hello,

First of all, many thanks to @DigitalBrainJS for adding the fetch adapter!

There's one thing that I noticed while trying the latest release [v1.7.0-beta.0](https://github.com/axios/axios/pull/6373), It seems to be breaking my react native app. I've added the following packages and followed the instructions to add the required polyfills

https://github.com/react-native-community/fetch?tab=readme-ov-file
https://github.com/acostalima/react-native-polyfill-globals

Unfortunately, that didn't seem to help. Not sure if there's a workaround or a way to avoid using `ReadableStreamer` at least for RN since it doesn't seem to be supported natively from my understanding. As pointed out under the [Motivation section](https://github.com/acostalima/react-native-polyfill-globals?tab=readme-ov-file#motivation):

> [ReadableStream](https://developer.mozilla.org/en-US/docs/Web/API/ReadableStream) is not supported and, by extension, [Response.body](https://developer.mozilla.org/en-US/docs/Web/API/Body/body) is not implemented. Related discussions:
https://github.com/facebook/react-native/issues/27741
https://github.com/facebook/react-native/issues/12912
https://github.com/JakeChampion/fetch/issues/198
https://github.com/JakeChampion/fetch/issues/746

For reference, here's a screenshot of the error running on an iOS simulator on iOS 17.0

![Simulator Screenshot - iPhone 15 Pro - 2024-04-30 at 14 33 30](https://github.com/axios/axios/assets/25246005/03a6c095-1e4c-4fb6-9fe2-3b42886d3432)


### To Reproduce

Spin up a new RN project

`yarn add axios@next`

Install the required polyfills from: 

https://github.com/react-native-community/fetch?tab=readme-ov-file
https://github.com/acostalima/react-native-polyfill-globals

Run the app

### Code snippet

_No response_

### Expected behavior

_No response_

### Axios Version

1.7.0-beta.0

### Adapter Version

fetch

### Browser

_No response_

### Browser Version

_No response_

### Node.js Version

_No response_

### OS

iOS 17.0

### Additional Library Versions

```bash
React Native 0.73.6
React 18.2.0
axios 1.7.0-beta.0
```


### Additional context/Screenshots

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF

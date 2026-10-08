#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `app/src/main/java/org/schabi/newpipe/local/subscription/item/FeedGroupReorderItem.kt`:

This pull request introduces the defect later reported as "Crash when reordering channel groups". The
problem a user observed, and its root cause:

<!--
Oh no, a bug! It happens. Thanks for reporting an issue with NewPipe. To make it easier for us to help you please enter detailed information in the template we have provided below. If a section isn't relevant, just delete it, though it would be helpful to still provide as much detail as possible.
-->

<!-- IF YOU DON'T FILL IN THE TEMPLATE PROPERLY, YOUR ISSUE IS LIABLE TO BE CLOSED. If you feel tired/lazy right now, open your issue some other time. We'll wait. -->

<!-- The comments between these brackets won't show up in the submitted issue (as you can see in the Preview). -->

### Checklist
<!-- This checklist is COMPULSORY. The first box has been checked for you to show you how it is done. -->

- [x] I am using the latest version - 0.20.10<!-- Check https://github.com/TeamNewPipe/NewPipe/releases -->
- [x] I checked, but didn't find any duplicates (open OR closed) of this issue in the repo. <!-- Seriously, check. O_O -->
- [x] I have read the contribution guidelines given at https://github.com/TeamNewPipe/NewPipe/blob/HEAD/.github/CONTRIBUTING.md.
- [x] This issue contains only one bug. I will open one issue for every bug report I want to file.

### Steps to reproduce the bug
<!--
1. Go to '...'
2. Press on '....'
3. Swipe down to '....'
-->

1. Create 2+ channel groups
2. Press on the reorder icon right of the "Channel groups" text
3. Attempt to move any group

<!-- If you can't cause the bug to show up again reliably (and hence don't have a proper set of steps to give us), please still try to give as many details as possible on how you think you encountered the bug. -->



### Actual behaviour
<!-- Tell us what happens with the steps given above. -->
The app crashes.


### Expected behavior
<!-- Tell us what you expect to happen. -->
The group is moved, the app doesn't crash.


### Screenshots/Screen recordings
<!-- If applicable, add screenshots or a screen recording to help explain your problem. GitHub supports uploading them directly in the issue text box. If your file is too big for Github to accept, feel free to paste a link from an image/video hoster here instead. -->

https://user-images.githubusercontent.com/12615679/107941019-c3bfcc80-6f91-11eb-99be-d11103dd5584.mp4


<!-- DON'T POST SCREENSHOTS OF THE ERROR PAGE. Use the buttons given on the error page to paste the error as text in the Logs section below. -->



### Logs
<!-- If your bug includes a crash (where you're shown the Error Report page with a bunch of info), tap on "Copy formatted report" at the bottom and paste it here: -->
(working on getting a logcat)
<!-- That's right, here! -->



<!-- Please fill this out when you do not provide a log generate by NewPipe -->

### Device info

 - Android version/Custom ROM version: Android 6.0.1, MIUI Global 10.2.2.0
 - Device model: Xiaomi Redmi 3S (land)

This same root cause must be fixed before merging.
REVIEW_EOF

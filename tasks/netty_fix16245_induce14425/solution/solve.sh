#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `transport-native-epoll/src/main/c/netty_epoll_native.c`:

This pull request introduces the defect later reported as "Incorrect nanos-to-millis conversion in epoll_wait EINTR retry loop". The
problem a user observed, and its root cause:

### Expected behavior

  When `epoll_wait` is interrupted by a signal (`EINTR`), the retry loop in `netty_epoll_wait` should correctly recompute
  the remaining timeout in milliseconds using the monotonic clock, so that scheduled tasks fire at the correct time.

  ### Actual behavior

  The deadline computation in `netty_epoll_wait` divides `tv_nsec` by `1000` (converting to microseconds) instead of
  `1000000` (converting to milliseconds). Since all other terms in the expression are in milliseconds (`tv_sec * 1000`,
  `timeout` is in ms), the nanosecond component ends up ~1000x too large. This corrupts the deadline value, causing the
  recalculated timeout after an `EINTR` to be far larger than intended, effectively defeating the decaying timeout fix
  introduced in #14425.

  The bug is on two lines in `netty_epoll_native.c` (`netty_epoll_wait`):

https://github.com/netty/netty/blob/81c1017c5f0ec5d0a03aef56af72002070d1357c/transport-native-epoll/src/main/c/netty_epoll_native.c#L272

https://github.com/netty/netty/blob/4.2/transport-native-epoll/src/main/c/netty_epoll_native.c#L284

  Note: this only affects the netty_epoll_wait code path (used when epoll_pwait2 is not available and timeouts fall below
  the millisThreshold). The netty_epoll_pwait2 path uses struct timespec arithmetic directly and is not affected.

### Steps to reproduce

  This manifests when the process receives signals during epoll_wait with a positive timeout. After the EINTR, the inflated
deadline causes the remaining timeout to be much larger than it should be, delaying scheduled tasks.

  A test has been added in EpollTest.testEpollWaitTimeoutAccuracy() that calls Native.epollWait with a 200ms timeout on an
  empty epoll set and asserts the elapsed time is within a reasonable bound.

 ### Netty version

  4.2.11.Final-SNAPSHOT (bug introduced in #14425, released in 4.1.112 and later releases)

 ### JVM version (e.g. java -version)

  Any

 ### OS version (e.g. uname -a)

  Linux (any version where epoll_pwait2 is not available or where the netty_epoll_wait fallback path is used.

This same root cause must be fixed before merging.
REVIEW_EOF

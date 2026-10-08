#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `common/src/main/java/io/netty/util/internal/BoundedInputStream.java`:

This pull request introduces the defect later reported as "IOException: Maximum number of bytes read". The
problem a user observed, and its root cause:

This issue was introduced in v4.1.115 by commit [fbf7a70](https://github.com/netty/netty/commit/fbf7a704a82e7449b48bd0bbb679f5661c6d61a3)

### Expected behavior
Netty starts without error

### Actual behavior
Netty logs an exception when starting:
```
io.netty.util.internal.PlatformDependent -- Error while reading content of /etc/os-release
java.io.IOException: Maximum number of bytes read: 8192
	at io.netty.util.internal.BoundedInputStream.checkMaxBytesRead(BoundedInputStream.java:79)
	at io.netty.util.internal.BoundedInputStream.read(BoundedInputStream.java:58)
	at java.base/sun.nio.cs.StreamDecoder.readBytes(StreamDecoder.java:350)
	at java.base/sun.nio.cs.StreamDecoder.implRead(StreamDecoder.java:393)
	at java.base/sun.nio.cs.StreamDecoder.lockedRead(StreamDecoder.java:217)
	at java.base/sun.nio.cs.StreamDecoder.read(StreamDecoder.java:171)
	at java.base/java.io.InputStreamReader.read(InputStreamReader.java:188)
	at java.base/java.io.BufferedReader.fill(BufferedReader.java:160)
	at java.base/java.io.BufferedReader.implReadLine(BufferedReader.java:370)
	at java.base/java.io.BufferedReader.readLine(BufferedReader.java:347)
	at java.base/java.io.BufferedReader.readLine(BufferedReader.java:436)
	at io.netty.util.internal.PlatformDependent$4.run(PlatformDependent.java:246)
	at io.netty.util.internal.PlatformDependent$4.run(PlatformDependent.java:235)
```
What is strange is that `/etc/os-release` is a symlink to `/usr/lib/os-release`, which itself is just a 386 byte file, way under 8192 bytes.  This leads me to think there is a bug in the new `BoundedInputStream` class, but I can't immediately spot it.

### Steps to reproduce
start netty up on a system which has a non-zero /etc/os-release

### Minimal yet complete reproducer code (or URL to code)

### Netty version
4.1.115

### JVM version (e.g. `java -version`)
openjdk version "21.0.5" 2024-10-15 LTS
OpenJDK Runtime Environment Temurin-21.0.5+11 (build 21.0.5+11-LTS)
OpenJDK 64-Bit Server VM Temurin-21.0.5+11 (build 21.0.5+11-LTS, mixed mode, sharing)

### OS version (e.g. `uname -a`)
Linux 5d84cc8b4bf8 6.8.0-48-generic #48~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Mon Oct  7 11:24:13 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

This same root cause must be fixed before merging.
REVIEW_EOF

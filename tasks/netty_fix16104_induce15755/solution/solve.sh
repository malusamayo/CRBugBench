#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `transport-classes-epoll/src/main/java/io/netty/channel/epoll/EpollDatagramChannel.java`:

This pull request introduces the defect later reported as "Failed to create EpollDatagramChannel after upgrading to 4.2.8.Final". The
problem a user observed, and its root cause:

After upgrading to 4.2.8.Final, this exception started to raise:
```
Caused by: java.lang.reflect.InvocationTargetException: null
    at java.base/jdk.internal.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
    at java.base/jdk.internal.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:77)
    at java.base/jdk.internal.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)
    at java.base/java.lang.reflect.Constructor.newInstanceWithCaller(Constructor.java:500)
    at java.base/java.lang.reflect.Constructor.newInstance(Constructor.java:481)
    at io.netty.channel.ReflectiveChannelFactory.newChannel(ReflectiveChannelFactory.java:44)
    ... 110 common frames omitted
Caused by: io.netty.channel.ChannelException: setsockopt() failed: Protocol not available
    at io.netty.channel.epoll.LinuxSocket.setIpMulticastAll(Native Method)
    at io.netty.channel.epoll.LinuxSocket.setIpMulticastAll(LinuxSocket.java:213)
    at io.netty.channel.epoll.EpollDatagramChannel.<init>(EpollDatagramChannel.java:132)
    at io.netty.channel.epoll.EpollDatagramChannel.<init>(EpollDatagramChannel.java:116)
    at io.netty.channel.epoll.EpollDatagramChannel.<init>(EpollDatagramChannel.java:97)
    ... 116 common frames omitted
```

I think this catch block must catch the `ChannelException`:
https://github.com/netty/netty/blob/4.2/transport-classes-epoll/src/main/java/io/netty/channel/epoll/EpollDatagramChannel.java#L133

This is the OS information where the code is executed:
```
cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.5 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.5 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian

uname -a
Linux <hostname> 4.18.0-553.el8_10.x86_64 #1 SMP Fri May 24 13:05:10 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
```

This same root cause must be fixed before merging.
REVIEW_EOF

#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `handler/src/main/java/io/netty/handler/flow/FlowControlHandler.java`:

This pull request introduces the defect later reported as "NullPointerException in FlowControlHandler". The
problem a user observed, and its root cause:

The following change in 4.1.37 causes a NPE in `FlowControlHandler`:

https://github.com/netty/netty/commit/2c99fc0f1290c65685c5036fdc9884921823ad7d#diff-bb753cb6291385d58a60bc0f59d5402d

The NPE stack:

```
java.lang.NullPointerException: null
	at io.netty.handler.flow.FlowControlHandler.dequeue(FlowControlHandler.java:193)
	at io.netty.handler.flow.FlowControlHandler.channelRead(FlowControlHandler.java:152)
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:374)
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:360)
	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:352)
	at io.netty.channel.CombinedChannelDuplexHandler$DelegatingChannelHandlerContext.fireChannelRead(CombinedChannelDuplexHandler.java:438)
	at io.netty.handler.codec.ByteToMessageDecoder.fireChannelRead(ByteToMessageDecoder.java:321)
	at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:295)

```

### Expected behavior

FlowControlHandler should not fail with a NPE.

### Actual behavior

FlowControlHandler sometimes fails with a NPE

### Steps to reproduce

Hard to come up with a reproducer, but the issue manifests if you upgrade to Netty 4.1.37 in a Micronaut application.

Related discussion can be found at https://github.com/micronaut-projects/micronaut-core/pull/1802

### Netty version

4.1.37

### JVM version (e.g. `java -version`)

Any

### OS version (e.g. `uname -a`)

Any

This same root cause must be fixed before merging.
REVIEW_EOF

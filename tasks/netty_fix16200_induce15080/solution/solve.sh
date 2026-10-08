#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `buffer/src/main/java/io/netty/buffer/AdaptivePoolingAllocator.java`:

This pull request introduces the defect later reported as "AdaptiveByteBufAllocator: Possible bug causing IndexOutOfBoundsException". The
problem a user observed, and its root cause:

Possible bug in the `AdaptiveByteBufAllocator`... spotted in a test run:

```
2026-01-14T09:41:02.6279891Z 09:41:02.616 [testsuite-nio-1-3] WARN  i.n.t.t.socket.SocketSslEchoTest - Unexpected exception from the client side:
2026-01-14T09:41:02.6283311Z io.netty.handler.codec.DecoderException: java.lang.IndexOutOfBoundsException: index: 262144, length: 65536 (expected: range(0, 262144))
2026-01-14T09:41:02.6286133Z 	at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:300)
2026-01-14T09:41:02.6287745Z 	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:356)
2026-01-14T09:41:02.6289239Z 	at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1429)
2026-01-14T09:41:02.6290539Z 	at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:918)
2026-01-14T09:41:02.6291797Z 	at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:172)
2026-01-14T09:41:02.6293115Z 	at io.netty.channel.nio.AbstractNioChannel$AbstractNioUnsafe.handle(AbstractNioChannel.java:445)
2026-01-14T09:41:02.6294491Z 	at io.netty.channel.nio.NioIoHandler$DefaultNioRegistration.handle(NioIoHandler.java:388)
2026-01-14T09:41:02.6295787Z 	at io.netty.channel.nio.NioIoHandler.processSelectedKey(NioIoHandler.java:596)
2026-01-14T09:41:02.6297691Z 	at io.netty.channel.nio.NioIoHandler.processSelectedKeysOptimized(NioIoHandler.java:571)
2026-01-14T09:41:02.6298840Z 	at io.netty.channel.nio.NioIoHandler.processSelectedKeys(NioIoHandler.java:512)
2026-01-14T09:41:02.6299768Z 	at io.netty.channel.nio.NioIoHandler.run(NioIoHandler.java:484)
2026-01-14T09:41:02.6300761Z 	at io.netty.channel.SingleThreadIoEventLoop.runIo(SingleThreadIoEventLoop.java:225)
2026-01-14T09:41:02.6301759Z 	at io.netty.channel.SingleThreadIoEventLoop.run(SingleThreadIoEventLoop.java:196)
2026-01-14T09:41:02.6302418Z 	at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:1195)
2026-01-14T09:41:02.6303028Z 	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74)
2026-01-14T09:41:02.6303593Z 	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30)
2026-01-14T09:41:02.6304071Z 	at java.base/java.lang.Thread.run(Thread.java:1583)
2026-01-14T09:41:02.6304577Z Caused by: java.lang.IndexOutOfBoundsException: index: 262144, length: 65536 (expected: range(0, 262144))
2026-01-14T09:41:02.6305558Z 	at io.netty.buffer.AbstractByteBuf.rangeBoundsCheckFailed(AbstractByteBuf.java:1417)
2026-01-14T09:41:02.6306206Z 	at io.netty.buffer.AbstractByteBuf.checkRangeBoundsTrustedCapacity(AbstractByteBuf.java:1397)
2026-01-14T09:41:02.6306794Z 	at io.netty.buffer.AbstractByteBuf.checkIndex0(AbstractByteBuf.java:1423)
2026-01-14T09:41:02.6307475Z 	at io.netty.buffer.AbstractByteBuf.checkIndex(AbstractByteBuf.java:1391)
2026-01-14T09:41:02.6308538Z 	at io.netty.buffer.AdaptivePoolingAllocator$AdaptiveByteBuf.setBytes(AdaptivePoolingAllocator.java:1783)
2026-01-14T09:41:02.6309587Z 	at io.netty.buffer.AbstractByteBuf.writeBytes(AbstractByteBuf.java:1111)
2026-01-14T09:41:02.6310152Z 	at io.netty.handler.codec.ByteToMessageDecoder$1.cumulate(ByteToMessageDecoder.java:107)
2026-01-14T09:41:02.6311249Z 	at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:294)
2026-01-14T09:41:02.6312045Z 	... 16 common frames omitted
2026-01-14T09:41:37.3510056Z [ERROR] Tests run: 192, Failures: 0, Errors: 1, Skipped: 0, Time elapsed: 36.82 s <<< FAILURE! -- in io.netty.testsuite.transport.socket.SocketSslEchoTest
2026-01-14T09:41:37.3512477Z [ERROR] io.netty.testsuite.transport.socket.SocketSslEchoTest.testSslEcho(SslContext, SslContext, Renegotiation, boolean, boolean, boolean, boolean, boolean, TestInfo)[7] -- Time elapsed: 0.167 s <<< ERROR!
2026-01-14T09:41:37.3514447Z io.netty.handler.ssl.SslClosedEngineException: SSLEngine closed already
2026-01-14T09:41:37.3515518Z 	at io.netty.handler.ssl.SslHandler.wrap(SslHandler.java:938)
2026-01-14T09:41:37.3516354Z 	at io.netty.handler.ssl.SslHandler.wrapAndFlush(SslHandler.java:842)
2026-01-14T09:41:37.3517181Z 	at io.netty.handler.ssl.SslHandler.flush(SslHandler.java:823)
2026-01-14T09:41:37.3518256Z 	at io.netty.channel.AbstractChannelHandlerContext.flush(AbstractChannelHandlerContext.java:755)
2026-01-14T09:41:37.3519530Z 	at io.netty.handler.stream.ChunkedWriteHandler.doFlush(ChunkedWriteHandler.java:219)
2026-01-14T09:41:37.3520908Z 	at io.netty.handler.stream.ChunkedWriteHandler.flush(ChunkedWriteHandler.java:146)
2026-01-14T09:41:37.3522155Z 	at io.netty.channel.AbstractChannelHandlerContext.write(AbstractChannelHandlerContext.java:811)
2026-01-14T09:41:37.3523586Z 	at io.netty.channel.AbstractChannelHandlerContext$WriteTask.run(AbstractChannelHandlerContext.java:1120)
2026-01-14T09:41:37.3524965Z 	at io.netty.util.concurrent.AbstractEventExecutor.runTask(AbstractEventExecutor.java:148)
2026-01-14T09:41:37.3526441Z 	at io.netty.util.concurrent.AbstractEventExecutor.safeExecute(AbstractEventExecutor.java:141)
2026-01-14T09:41:37.3527861Z 	at io.netty.util.concurrent.SingleThreadEventExecutor.runAllTasks(SingleThreadEventExecutor.java:535)
2026-01-14T09:41:37.3529170Z 	at io.netty.channel.SingleThreadIoEventLoop.run(SingleThreadIoEventLoop.java:201)
2026-01-14T09:41:37.3530401Z 	at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:1195)
2026-01-14T09:41:37.3531567Z 	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74)
2026-01-14T09:41:37.3532685Z 	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30)
2026-01-14T09:41:37.3533617Z 	at java.base/java.lang.Thread.run(Thread.java:1583)
2026-01-14T09:41:37.3534495Z 	Suppressed: java.util.concurrent.CompletionException: Rethrowing promise failure cause
2026-01-14T09:41:37.3536062Z 		at io.netty.util.concurrent.DefaultPromise.rethrowIfFailed(DefaultPromise.java:686)
2026-01-14T09:41:37.3537140Z 		at io.netty.util.concurrent.DefaultPromise.sync(DefaultPromise.java:420)
2026-01-14T09:41:37.3538144Z 		at io.netty.channel.DefaultChannelPromise.sync(DefaultChannelPromise.java:119)
2026-01-14T09:41:37.3539181Z 		at io.netty.channel.DefaultChannelPromise.sync(DefaultChannelPromise.java:30)
2026-01-14T09:41:37.3540406Z 		at io.netty.testsuite.transport.socket.SocketSslEchoTest.testSslEcho(SocketSslEchoTest.java:342)
2026-01-14T09:41:37.3541741Z 		at io.netty.testsuite.transport.socket.SocketSslEchoTest$1.run(SocketSslEchoTest.java:254)
2026-01-14T09:41:37.3543123Z 		at io.netty.testsuite.transport.socket.SocketSslEchoTest$1.run(SocketSslEchoTest.java:251)
2026-01-14T09:41:37.3544467Z 		at io.netty.testsuite.transport.AbstractComboTestsuiteTest.run(AbstractComboTestsuiteTest.java:52)
2026-01-14T09:41:37.3546111Z 		at io.netty.testsuite.transport.socket.SocketSslEchoTest.testSslEcho(SocketSslEchoTest.java:251)
2026-01-14T09:41:37.3547216Z 		at java.base/java.lang.reflect.Method.invoke(Method.java:580)
2026-01-14T09:41:37.3547957Z 		at java.base/java.util.Optional.ifPresent(Optional.java:178)
2026-01-14T09:41:37.3548839Z 		at java.base/java.util.stream.ForEachOps$ForEachOp$OfRef.accept(ForEachOps.java:184)
2026-01-14T09:41:37.3549918Z 		at java.base/java.util.stream.ReferencePipeline$3$1.accept(ReferencePipeline.java:197)
2026-01-14T09:41:37.3550991Z 		at java.base/java.util.stream.ForEachOps$ForEachOp$OfRef.accept(ForEachOps.java:184)
2026-01-14T09:41:37.3552021Z 		at java.base/java.util.stream.ForEachOps$ForEachOp$OfRef.accept(ForEachOps.java:184)
2026-01-14T09:41:37.3553089Z 		at java.base/java.util.stream.ReferencePipeline$3$1.accept(ReferencePipeline.java:197)
2026-01-14T09:41:37.3554241Z 		at java.base/java.util.ArrayList$ArrayListSpliterator.forEachRemaining(ArrayList.java:1708)
2026-01-14T09:41:37.3555607Z 		at java.base/java.util.stream.ReferencePipeline$Head.forEach(Refere

This same root cause must be fixed before merging.
REVIEW_EOF

#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Duplicati/WebserverCore/Middlewares/WebsocketExtensions.cs`:

This pull request introduces the defect later reported as "WebSocketException error on Microsoft.AspNetCore.Server.Kestrel". The
problem a user observed, and its root cause:

<!-- Thank you for taking the time to submit an issue using this template. By following the instructions and filling out the sections below, you will help the developers get the necessary information to fix your issue. You may remove sections that aren't relevant to your particular case. You can also preview your report before submitting it. -->
<!-- Please note that the issues are a tool for Duplicati developers. If you post here, you are supposed to want to help the project by providing timely information on your problem so it can be fixed. If this is not the case, please use the forum instead -->


<!-- Please search to see if an issue has already been created for your report. -->
<!-- Replace the empty checkbox [ ] below with a checked one [x] if you already searched for duplicate bugs. -->
- [x] I have searched open and closed issues for duplicates.
- [x] I have searched the [forum](https://forum.duplicati.com) for related topics.

----------------------------------------

## Environment info
<!-- Please include some relevant information about your environment. -->
<!-- For "Backend", please indicate the backup destination (e.g. Amazon S3, OneDrive, FTP, WebDAV, local). -->
- **Duplicati version**: Debug
- **Operating system**: Debian
- **Backend**: irrelevant

## Description

I am not quite sure how to reproduce the error consistently, but loading the same page several times quickly seems to return the error below related to websocket:

````
fail: Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware[1]
      An unhandled exception has occurred while executing the request.
      System.Net.WebSockets.WebSocketException (0x80004005): The remote party closed the WebSocket connection without completing the close handshake.
       ---> Microsoft.AspNetCore.Connections.ConnectionResetException: Connection reset by peer
       ---> System.Net.Sockets.SocketException (104): Connection reset by peer
         --- End of inner exception stack trace ---
         at System.IO.Pipelines.Pipe.GetReadResult(ReadResult& result)
         at System.IO.Pipelines.Pipe.GetReadAsyncResult()
         at Microsoft.AspNetCore.Server.Kestrel.Core.Internal.Http.Http1UpgradeMessageBody.ReadAsyncInternalAwaited(ValueTask`1 readTask, CancellationToken cancellationToken)
         at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)
         at Microsoft.AspNetCore.Server.Kestrel.Core.Internal.Http.HttpRequestStream.ReadAsyncInternal(Memory`1 destination, CancellationToken cancellationToken)
         at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)
         at System.IO.Stream.ReadAtLeastAsyncCore(Memory`1 buffer, Int32 minimumBytes, Boolean throwOnEndOfStream, CancellationToken cancellationToken)
         at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)
         at System.Net.WebSockets.ManagedWebSocket.EnsureBufferContainsAsync(Int32 minimumRequiredBytes, CancellationToken cancellationToken)
         at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource.GetResult(Int16 token)
         at System.Net.WebSockets.ManagedWebSocket.ReceiveAsyncPrivate[TResult](Memory`1 payloadBuffer, CancellationToken cancellationToken)
         at System.Net.WebSockets.ManagedWebSocket.ReceiveAsyncPrivate[TResult](Memory`1 payloadBuffer, CancellationToken cancellationToken)
         at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)
         at System.Threading.Tasks.ValueTask`1.ValueTaskSourceAsTask.<>c.<.cctor>b__4_0(Object state)
      --- End of stack trace from previous location ---
````

## Steps to reproduce
<!-- List the steps to reproduce the bug if possible. -->
1. Open http://localhost:8200/ngax/index.html
2. Reload the page several times quickly

<!-- For "Actual result", describe what happens after you run the steps above (i.e. buggy behavior). -->
<!-- For "Expected result", describe what should happen after you run the steps above (i.e. corrected behavior). -->
- **Actual result**: the error above occurred.

- **Expected result**: the error should not occur.

## Screenshots
<!-- Make it easier to get your point across with screenshots. -->
<!-- You can drag & drop or paste your images below. -->

## Debug log
<!-- Posting a debug log helps the developers find and fix your particular issue more easily. -->
<!-- Please wrap your code in code blocks with triple back-ticks to increase readability. -->

This same root cause must be fixed before merging.
REVIEW_EOF

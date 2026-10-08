#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/SignalR/clients/java/signalr/core/src/main/java/com/microsoft/signalr/HubConnection.java`:

This pull request introduces the defect later reported as "Nullpointer exception in SignalR Java SDK 8.0.0 HubConnection class". The
problem a user observed, and its root cause:

### Is there an existing issue for this?

- [X] I have searched the existing issues

### Describe the bug

After updating the SignalR SDK to 8.0.0 in our Android app, we are receiving app crashes in Google Firebase Crashlytics.

```
Fatal Exception: java.lang.NullPointerException: Attempt to invoke interface method 'rf.a com.microsoft.signalr.Transport.stop()' on a null object reference
       at com.microsoft.signalr.HubConnection.lambda$stop$16(HubConnection.java:448)
       at io.reactivex.rxjava3.internal.observers.CallbackCompletableObserver.onComplete(CallbackCompletableObserver.java:53)
       at io.reactivex.rxjava3.internal.operators.completable.CompletableOnErrorComplete$OnError.onError(CompletableOnErrorComplete.java:64)
       at io.reactivex.rxjava3.subjects.CompletableSubject.onError(CompletableSubject.java:126)
       at com.microsoft.signalr.HubConnection.lambda$start$12(HubConnection.java:358)
       at io.reactivex.rxjava3.internal.observers.CallbackCompletableObserver.onError(CallbackCompletableObserver.java:64)
       at io.reactivex.rxjava3.internal.operators.single.SingleFlatMapCompletable$FlatMapCompletableObserver.onError(SingleFlatMapCompletable.java:97)
       at io.reactivex.rxjava3.internal.observers.ResumeSingleObserver.onError(ResumeSingleObserver.java:51)
       at io.reactivex.rxjava3.internal.operators.single.SingleFlatMap$SingleFlatMapCallback.onError(SingleFlatMap.java:91)
       at io.reactivex.rxjava3.internal.operators.single.SingleMap$MapSingleObserver.onError(SingleMap.java:70)
       at io.reactivex.rxjava3.subjects.SingleSubject.onError(SingleSubject.java:153)
       at com.microsoft.signalr.DefaultHttpClient$2.onFailure(DefaultHttpClient.java:149)
       at okhttp3.internal.connection.RealCall$AsyncCall.run(RealCall.kt:525)
       at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1145)
       at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:644)
       at java.lang.Thread.run(Thread.java:1012)
```

### Expected Behavior

Check for null before accessing the class to avoid null pointer exception.

### Steps To Reproduce

```
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val hubConnection: HubConnection = HubConnectionBuilder
            .create("https://someInvalidUrl")
            .build()

        hubConnection.start()
            .subscribe({
                Log.d("SomeTag", "Successfully connected to Webserver")
            }, { e ->
                Log.e("SomeTag", "Failed to start connection: ${e.message}")
            })

        hubConnection.stop()  // <------ this leads to app crash
            .subscribe({ 
                Log.d("SomeTag", "HubConnection Stop Success")
            }, {
                Log.e("SomeTag", "HubConnection Stop Failed: ${it.message}")
            })
    }
}
```


### Exceptions (if any)

_No response_

### .NET Version

_No response_

### Anything else?

Android code example is attached:
[SignalRBugForGithub.zip](https://github.com/dotnet/aspnetcore/files/13779913/SignalRBugForGithub.zip)

This same root cause must be fixed before merging.
REVIEW_EOF

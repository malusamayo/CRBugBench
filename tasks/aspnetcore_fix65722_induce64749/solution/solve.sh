#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Components/Endpoints/src/TempData/TempData.cs`:

This pull request introduces the defect later reported as "TempData.Get() does not consume value when it is the first access on a request". The
problem a user observed, and its root cause:

### Is there an existing issue for this?

- [X] I have searched the existing issues

### Describe the bug

`TempData.Get()` does not consume the value when it is the **first access** to TempData on a request. The value persists indefinitely across page refreshes instead of being deleted after the first read.

#### Root cause

In [`TempData.Get()`](https://github.com/dotnet/aspnetcore/blob/main/src/Components/Endpoints/src/TempData/TempData.cs), `_retainedKeys.Remove(key)` executes **before** the `Data` property is accessed:

```csharp
public object? Get(string key)
{
    _retainedKeys.Remove(key);          // (1) No-op: TempData hasn't been loaded yet
    return Data.GetValueOrDefault(key); // (2) Triggers lazy Load(), which re-adds key to _retainedKeys
}
```

When `Get()` is the first access to TempData on a request:

1. `_retainedKeys` is empty (lazy loading hasn't occurred), so `Remove` is a no-op
2. Accessing `Data` triggers the lazy `Load()` method, which adds **all** keys from the cookie to `_retainedKeys`
3. The key is now back in `_retainedKeys`, so `Save()` persists it — the value is never consumed

The same issue likely affects `TryGetValue()` and the indexer getter (which delegates to `Get()`).

#### Suggested fix

Swap the order so lazy loading is triggered before removing from `_retainedKeys`:

```csharp
public object? Get(string key)
{
    var value = Data.GetValueOrDefault(key); // Trigger lazy load first
    _retainedKeys.Remove(key);               // Now Remove works correctly
    return value;
}
```

#### Workaround

Force TempData to load before calling `Get()`:

```csharp
_ = TempData?.ContainsKey("Message");  // triggers lazy load
message = TempData?.Get("Message") as string;  // now consumes correctly
```

### Expected Behavior

After setting a TempData value via `TempData["Message"] = "hello"` and redirecting, `TempData.Get("Message")` should return the value **once**. On the next page refresh, the value should be gone.

### Steps To Reproduce

1. `dotnet run` the repro project
2. Click **"Set TempData & Redirect"**
3. Observe the message appears (value was read via `Get()`)
4. **Refresh the page** — the message should disappear but it persists on every refresh

### Repro project

https://github.com/danroth27/BlazorTempDataBug

### Exceptions (if any)

_No response_

### .NET Version

11.0.100-preview.2.26154.117

### Anything else?

The framework's E2E tests for TempData appear to avoid this issue because the test component ([TempDataComponent.razor](https://github.com/dotnet/aspnetcore/blob/main/src/Components/test/testassets/Components.TestServer/RazorComponents/Pages/TempData/TempDataComponent.razor)) checks `if (Handler is not null) { return; }` in `OnInitialized()`, which skips `Get()` during the POST request. This means TempData is always accessed at least once (during the POST render) before `Get()` is called on the subsequent GET, masking the lazy-loading ordering issue.

This same root cause must be fixed before merging.
REVIEW_EOF

#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Common/Packets/Controls.cs`:

This pull request introduces the defect later reported as "QuantBook Not Loading ObjectStore ". The
problem a user observed, and its root cause:

#### Expected Behavior
Be able to write and read files saved in the ObjectStore.

#### Actual Behavior
ObjectStore is not set and initialized.

#### Potential Solution
Adds the following statements in QuantBook constructor:
```csharp
string assemblyPath;
var job = systemHandlers.JobQueue.NextJob(out assemblyPath);
SetObjectStore(algorithmHandlers.ObjectStore);
ObjectStore.Initialize(Name, job.UserId, job.ProjectId, job.UserToken, job.Controls);
```
#### Reproducing the Problem
```python
qb = QuantBook()
key = "spy_history"
spy = qb.AddEquity("SPY")

if qb.ObjectStore.ContainsKey(key):
    history = qb.ObjectStore.Read(key)
else:
    history = qb.History(qb.Securities.Keys, 3600, Resolution.Daily)
    qb.ObjectStore.Save(key, history.to_string())
```
This code works locally but throws an exception in QuantConnect Cloud:
```
QuantBook.Main(): System.ArgumentException: An empty file name is not valid.
  at System.IO.DirectoryInfo.CheckPath (System.String path) [0x00016] in <b0e1ad7573a24fd5a9f2af9595e677e7>:0 
  at System.IO.DirectoryInfo..ctor (System.String path, System.Boolean simpleOriginalPath) [0x00006] in <b0e1ad7573a24fd5a9f2af9595e677e7>:0 
  at System.IO.DirectoryInfo..ctor (System.String path) [0x00000] in <b0e1ad7573a24fd5a9f2af9595e677e7>:0 
  at (wrapper remoting-invoke-with-check) System.IO.DirectoryInfo..ctor(string)
  at QuantConnect.Queues.JobQueue.GetAlgorithmLocation () [0x0002d] in <dafb63184514456ab28754f94d338d4a>:0 
  at QuantConnect.Queues.JobQueue.NextJob (System.String& location) [0x00000] in <dafb63184514456ab28754f94d338d4a>:0 
  at QuantConnect.Jupyter.QuantBook..ctor () [0x0008d] in <b6308bfbe58a4884980669831901b714>:0 
```
#### Checklist
- [x] I have completely filled out this template
- [x] I have confirmed that this issue exists on the current `master` branch
- [x] I have confirmed that this is not a duplicate issue by searching [issues](https://github.com/QuantConnect/Lean/issues)
- [x] I have provided detailed steps to reproduce the issue

This same root cause must be fixed before merging.
REVIEW_EOF

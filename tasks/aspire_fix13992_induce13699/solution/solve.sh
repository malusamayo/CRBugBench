#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Aspire.Dashboard/Model/GenAI/GenAISchemaHelpers.cs`:

This pull request introduces the defect later reported as "Error parsing tool definitions with class parameter in GenAIVisualizerDialogViewModel after Aspire 13.1 upgrade". The
problem a user observed, and its root cause:

### Is there an existing issue for this?

- [x] I have searched the existing issues

### Describe the bug

After upgrading to Aspire 13.1 when I'm looking at a trace that involves GenAI details, if I open the GenAI Details modal for an agent thread that contains tool calls I get the following exception is logged in the apphost's console log:

```
fail: Aspire.Hosting.Dashboard.Telemetry.TelemetryErrorRecorder[0]
      Error parsing tool definitions for span d777213214363248
      System.InvalidOperationException: The node must be of type 'JsonValue'.
         at System.Text.Json.Nodes.JsonNode.GetValue[T]()
         at Aspire.Dashboard.Model.GenAI.GenAIVisualizerDialogViewModel.ParseOpenApiSchema(JsonObject schemaObj) in /_/src/Aspire.Dashboard/Model/GenAI/GenAIVisualizerDialogViewModel.cs:line 546
         at Aspire.Dashboard.Model.GenAI.GenAIVisualizerDialogViewModel.ParseOpenApiSchema(JsonObject schemaObj) in /_/src/Aspire.Dashboard/Model/GenAI/GenAIVisualizerDialogViewModel.cs:line 560
         at Aspire.Dashboard.Model.GenAI.GenAIVisualizerDialogViewModel.ParseOpenApiSchema(JsonObject schemaObj) in /_/src/Aspire.Dashboard/Model/GenAI/GenAIVisualizerDialogViewModel.cs:line 560
         at Aspire.Dashboard.Model.GenAI.GenAIVisualizerDialogViewModel.Create(SpanDetailsViewModel spanDetailsViewModel, Nullable`1 selectedLogEntryId, ITelemetryErrorRecorder errorRecorder, TelemetryRepository telemetryRepository, Func`1 getContextGenAISpans) in /_/src/Aspire.Dashboard/Model/GenAI/GenAIVisualizerDialogViewModel.cs:line 106
```
I tried rolling back to Aspire 13.0.2 and the error doesn't happen.

The GenAI modal still loads, but the Tools tab mentioned in https://github.com/dotnet/aspire/pull/13414 doesn't show.

I am using Microsoft Agent Framework for the AI orchestration. Since that's in preview, I guess maybe the issue is actually in it not have been updated to support this functionality?

### Expected Behavior

There is no exception logged when viewing the GenAI details and the tools tabs does display when there are tools calls.

### Steps To Reproduce

If you can't easily reproduce it, I can try to work out a minimal solution to reproduce it, but I'm basically just opening the GenAI details modal when there are tool calls in the AI thread. I've removed some of available tools from my code and the issue does away, so I'm trying to further narrow down what the triggering difference is. I will update as I do.

### Exceptions (if any)

```
fail: Aspire.Hosting.Dashboard.Telemetry.TelemetryErrorRecorder[0]
      Error parsing tool definitions for span d777213214363248
      System.InvalidOperationException: The node must be of type 'JsonValue'.
         at System.Text.Json.Nodes.JsonNode.GetValue[T]()
         at Aspire.Dashboard.Model.GenAI.GenAIVisualizerDialogViewModel.ParseOpenApiSchema(JsonObject schemaObj) in /_/src/Aspire.Dashboard/Model/GenAI/GenAIVisualizerDialogViewModel.cs:line 546
         at Aspire.Dashboard.Model.GenAI.GenAIVisualizerDialogViewModel.ParseOpenApiSchema(JsonObject schemaObj) in /_/src/Aspire.Dashboard/Model/GenAI/GenAIVisualizerDialogViewModel.cs:line 560
         at Aspire.Dashboard.Model.GenAI.GenAIVisualizerDialogViewModel.ParseOpenApiSchema(JsonObject schemaObj) in /_/src/Aspire.Dashboard/Model/GenAI/GenAIVisualizerDialogViewModel.cs:line 560
         at Aspire.Dashboard.Model.GenAI.GenAIVisualizerDialogViewModel.Create(SpanDetailsViewModel spanDetailsViewModel, Nullable`1 selectedLogEntryId, ITelemetryErrorRecorder errorRecorder, TelemetryRepository telemetryRepository, Func`1 getContextGenAISpans) in /_/src/Aspire.Dashboard/Model/GenAI/GenAIVisualizerDialogViewModel.cs:line 106
```

### .NET Version info

.NET SDK:
 Version:           10.0.101
 Commit:            fad253f51b
 Workload version:  10.0.100-manifests.9f71effe
 MSBuild version:   18.0.6+fad253f51

Runtime Environment:
 OS Name:     Windows
 OS Version:  10.0.22631
 OS Platform: Windows
 RID:         win-x64
 Base Path:   C:\Program Files\dotnet\sdk\10.0.101\

.NET workloads installed:
There are no installed workloads to display.
Configured to use workload sets when installing new manifests.
No workload sets are installed. Run "dotnet workload restore" to install a workload set.

Host:
  Version:      10.0.1
  Architecture: x64
  Commit:       fad253f51b

.NET SDKs installed:
  7.0.410 [C:\Program Files\dotnet\sdk]
  8.0.416 [C:\Program Files\dotnet\sdk]
  9.0.308 [C:\Program Files\dotnet\sdk]
  10.0.100-rc.1.25451.107 [C:\Program Files\dotnet\sdk]
  10.0.101 [C:\Program Files\dotnet\sdk]

.NET runtimes installed:
  Microsoft.AspNetCore.App 5.0.17 [C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App]
  Microsoft.AspNetCore.App 6.0.36 [C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App]
  Microsoft.AspNetCore.App 7.0.20 [C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App]
  Microsoft.AspNetCore.App 8.0.22 [C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App]
  Microsoft.AspNetCore.App 9.0.11 [C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App]
  Microsoft.AspNetCore.App 10.0.1 [C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App]
  Microsoft.NETCore.App 5.0.17 [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]
  Microsoft.NETCore.App 6.0.36 [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]
  Microsoft.NETCore.App 7.0.20 [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]
  Microsoft.NETCore.App 8.0.22 [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]
  Microsoft.NETCore.App 9.0.11 [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]
  Microsoft.NETCore.App 10.0.1 [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]
  Microsoft.WindowsDesktop.App 5.0.17 [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]
  Microsoft.WindowsDesktop.App 6.0.36 [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]
  Microsoft.WindowsDesktop.App 7.0.20 [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]
  Microsoft.WindowsDesktop.App 8.0.22 [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]
  Microsoft.WindowsDesktop.App 9.0.11 [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]
  Microsoft.WindowsDesktop.App 10.0.1 [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]

Other architectures found:
  x86   [C:\Program Files (x86)\dotnet]
    registered at [HKLM\SOFTWARE\dotnet\Setup\InstalledVersions\x86\InstallLocation]

Environment variables:
  DOTNET_TieredCompilation                 [0]
  Detected COMPlus_* environment variable(s). Consider transitioning to DOTNET_* equivalent.

global.json file:
  Not found

Learn more:
  https://aka.ms/dotnet/info

Download .NET:
  https://aka.ms/dotnet/download

### Anything else?

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF

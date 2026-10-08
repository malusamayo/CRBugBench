#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Framework/AspNetCoreAnalyzers/src/Analyzers/Mvc/DetectAmbiguousActionRoutes.cs`:

This pull request introduces the defect later reported as "ASP0023 Ambiguous route warning when targeting .NET 8 and using token [action] or [controller] in [Http*] or [Route] attributes". The
problem a user observed, and its root cause:

### Is there an existing issue for this?

- [X] I have searched the existing issues

### Describe the bug

When targeting .NET 8 preview 6 and using token [action] or [controller] in [Http*] or [Route] attributes on a controller method, an ASP0023 warning is emitted which is a new behaviour that wasn't observed in .NET 7.

If you ignore the warnings, the code will run and the endpoints can be called and return the expected responses for their respective verbs.

### Expected Behavior

No warning generated

### Steps To Reproduce

```
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllers();

var app = builder.Build();
app.MapControllers();
app.Run();

[Route("api/[controller]")]
[ApiController]
public class MyController : ControllerBase
{
    [HttpGet("[action]")]
    public IActionResult GetTime() => Ok(DateTime.Now.ToString("HH:mm:ss"));
    
    [HttpGet("[action]")]
    public IActionResult GetDate() => Ok(DateTime.Now.ToString("yyyy-MM-dd"));
}
```

### Exceptions (if any)

No response

### .NET Version

8.0.100-preview.6.23330.14

### Anything else?

```
╰─ dotnet --info                                                                                                                                                                           ─╯
.NET SDK:
 Version:   8.0.100-preview.6.23330.14
 Commit:    ba97796b8f

Runtime Environment:
 OS Name:     Windows
 OS Version:  10.0.22621
 OS Platform: Windows
 RID:         win10-x64
 Base Path:   C:\Program Files\dotnet\sdk\8.0.100-preview.6.23330.14\

.NET workloads installed:
 [wasm-tools]
   Installation Source: SDK 8.0.100-preview.6
   Manifest Version:    8.0.0-preview.6.23329.7/8.0.100-preview.6
   Manifest Path:       C:\Program Files\dotnet\sdk-manifests\8.0.100-preview.6\microsoft.net.workload.mono.toolchain.current\WorkloadManifest.json
   Install Type:              Msi
 [wasm-tools-net6]
   Installation Source: SDK 8.0.100-preview.6
   Manifest Version:    8.0.0-preview.6.23329.7/8.0.100-preview.6
   Manifest Path:       C:\Program Files\dotnet\sdk-manifests\8.0.100-preview.6\microsoft.net.workload.mono.toolchain.net6\WorkloadManifest.json
   Install Type:              Msi

Host:
  Version:      8.0.0-preview.6.23329.7
  Architecture: x64
  Commit:       5340be2ccc

.NET SDKs installed:
  7.0.306 [C:\Program Files\dotnet\sdk]
  8.0.100-preview.6.23330.14 [C:\Program Files\dotnet\sdk]

.NET runtimes installed:
  Microsoft.AspNetCore.App 6.0.20 [C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App]
  Microsoft.AspNetCore.App 7.0.9 [C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App]
  Microsoft.AspNetCore.App 8.0.0-preview.6.23329.11 [C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App]
  Microsoft.NETCore.App 6.0.15 [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]
  Microsoft.NETCore.App 6.0.20 [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]
  Microsoft.NETCore.App 7.0.9 [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]
  Microsoft.NETCore.App 8.0.0-preview.6.23329.7 [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]
  Microsoft.WindowsDesktop.App 6.0.15 [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]
  Microsoft.WindowsDesktop.App 6.0.20 [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]
  Microsoft.WindowsDesktop.App 7.0.9 [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]
  Microsoft.WindowsDesktop.App 8.0.0-preview.6.23329.4 [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]

Other architectures found:
  x86   [C:\Program Files (x86)\dotnet]
    registered at [HKLM\SOFTWARE\dotnet\Setup\InstalledVersions\x86\InstallLocation]

Environment variables:
  Not set

global.json file:
  Not found

Learn more:
  https://aka.ms/dotnet/info

Download .NET:
  https://aka.ms/dotnet/download

```

This same root cause must be fixed before merging.
REVIEW_EOF

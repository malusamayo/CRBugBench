#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Compilers/CSharp/Portable/Lowering/LocalRewriter/LocalRewriter_Call.cs`:

This pull request introduces the defect later reported as "Invalid IL generated for intercepted callsite". The
problem a user observed, and its root cause:

**Version Used**: 

.NET SDK 8.0.100

**Steps to Reproduce**:

1.  `dotnet new console`
2.  Copy & paste attached `Program.cs` (adjust full path to match your system)
3. Add `<InterceptorsPreviewNamespaces>$(InterceptorsPreviewNamespaces);MyInterceptors</InterceptorsPreviewNamespaces` to the .csproj file
4. `dotnet run`

**Expected Behavior**:

Program runs to completion

**Actual Behavior**:

InvalidProgramException. 

The problem is that Roslyn generates invalid IL 
```
    .locals init (valuetype MyEnum V_0)
    IL_0000:  ldc.i4.1
    IL_0001:  stloc.0
    IL_0002:  ldloc.0 <- MyEnum is not assignable to Enum in IL!
    IL_0003:  call       string MyInterceptors.Interceptors::OtherToString(class [System.Runtime]System.Enum)
```


#### Program.cs
```csharp
using System.Runtime.CompilerServices;

var value = MyEnum.Second;
Console.WriteLine(value.ToString());

public enum MyEnum
{
    First,
    Second,
}

namespace MyInterceptors
{
    public static class Interceptors
    {
        [InterceptsLocation(@"C:\repro\Program.cs", line: 4, column: 25)]
        public static string OtherToString(this System.Enum value)
            => "Wrong Value" + value;
    }
}

namespace System.Runtime.CompilerServices
{
    [AttributeUsage(AttributeTargets.Method, AllowMultiple = true)]
    sealed class InterceptsLocationAttribute : Attribute
    {
        public InterceptsLocationAttribute(string filePath, int line, int column)
        {
        }
    }
}
```

This same root cause must be fixed before merging.
REVIEW_EOF

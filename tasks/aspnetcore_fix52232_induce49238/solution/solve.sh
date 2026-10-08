#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Components/Endpoints/src/Rendering/SSRRenderModeBoundary.cs`:

This pull request introduces the defect later reported as "ComputeComponentTypeNameHash does not handle multi-byte type names correctly". The
problem a user observed, and its root cause:

### Is there an existing issue for this?

- [X] I have searched the existing issues

### Describe the bug

👋 I was looking though the use of cryptography in ASP.NET Core, and stumbled on this code block:

https://github.com/dotnet/aspnetcore/blob/46562b1435bf111a7425b40f507b157b42a016a4/src/Components/Endpoints/src/Rendering/SSRRenderModeBoundary.cs#L206-L213

Nothing about the use of cryptography there concerns me too much, but I did want to point out that it does not handle types where the type name requires the use of multibyte characters.

I lack detailed knowledge of how SSR works, so I had a bit of trouble trying to reproduce it in a real app.

### Expected Behavior

_No response_

### Steps To Reproduce

I had a bit of trouble trying to reproduce this using an app, as I am not super familiar with the innards of SSR. However, in isolation it can be reproduced with:

```C#
using System;
using System.Text;
using System.Security.Cryptography;

string hash = ComputeComponentTypeNameHash(typeof(こんにちは));
Console.WriteLine(hash);

static string ComputeComponentTypeNameHash(Type componentType)
{
    if (componentType.FullName is not { } typeName)
    {
        throw new InvalidOperationException($"An invalid component type was used.");
    }

    var typeNameLength = typeName.Length;
    var typeNameBytes = typeNameLength < 1024
        ? stackalloc byte[typeNameLength]
        : new byte[typeNameLength];

    Encoding.UTF8.GetBytes(typeName, typeNameBytes);

    Span<byte> typeNameHashBytes = stackalloc byte[SHA1.HashSizeInBytes];
    SHA1.HashData(typeNameBytes, typeNameHashBytes);

    return Convert.ToHexString(typeNameHashBytes);
}

class こんにちは
{

}
```

### Exceptions (if any)

This will produce a `System.ArgumentException` since the destination buffer is too small.

### .NET Version

_No response_

### Anything else?

Please feel free to close this issue if the type in `ComputeComponentTypeNameHash` is not exposed to developers.

This same root cause must be fixed before merging.
REVIEW_EOF

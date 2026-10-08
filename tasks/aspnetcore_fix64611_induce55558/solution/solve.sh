#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/StaticAssets/src/Development/StaticAssetDevelopmentRuntimeHandler.cs`:

This pull request introduces the defect later reported as "ETag in ResponseHeader is different from staticwebassets.endpoints.json". The
problem a user observed, and its root cause:

### Is there an existing issue for this?

- [x] I have searched the existing issues

### Describe the bug

This my program.cs files
```
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews(options =>
  options.Filters.Add());

var app = builder.Build();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();


app.MapStaticAssets();
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Article}/{action=Index}/{id?}")
    .WithStaticAssets();

app.Run();
```

The problem is that for custom css and js file in wwwroot/css or wwwroot/js the ETag generated in staticwebassets.endpoints.json is not what returned for particular statis files in Response.Header ETag(Strong).

and there each time the file is getting download with 200Ok  instead of 304 Not Modified Status

What am I missing.

staticwebassets.endpoints.json (only the object representing site.css)

![Image](https://github.com/user-attachments/assets/43d9c025-9693-44ae-8921-02364573c1c6)

Response Header
![Image](https://github.com/user-attachments/assets/d8714193-9a04-46d6-bded-f91437f7c200)

### Expected Behavior

_No response_

### Steps To Reproduce

_No response_

### Exceptions (if any)

_No response_

### .NET Version

_No response_

### Anything else?

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF

# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/aspnetcore` repository.

**PR title:** [Blazor] Adds compresion support for all assets in an application (#55558)

**PR description / commit message:**

[Blazor] Adds compresion support for all assets in an application (#55558)

Adds a new MapStaticAssetEndpoints routerware that reads a manifest generated at build / publish time and maps the endpoints defined in the manifest to the files in the application wwwroot folder.

Adds a MatcherPolicy to perform content negotiation based on the Accept-Encoding header. Compressed resources contain a ContentEncoding attribute in their metadata that is used to filter out the compressed asset to serve to the client based on the Accept-Encoding header.

The content encoding has an associated Quality value that represents the 'server preference' for the encoding. We always use the client preference and only rely on the server preference to break ties.

This process is completely driven by de the build and transparent to the runtime, if in the future we add support for zstd, sbr, etc. we don't need to change the runtime.

The logic for serving static files is borrowed from the static files middleware, with simplifications and additions. I've ported the relevant tests to ensure a high degree of compatibility.

The logic is new "routerware" instead of directly baked into the static files middleware because we do not want to pollute that middleware with more complex logic and we are going to be layering fingerprinting on top of this change, which will register more endpoints that will include more custom headers, which is not suitable for the static files middleware.

During development we wrap the endpoints we generate to support changing the files while the app is running (we recompute some of the values on the fly and also register a fallback route that matches file patterns to serve new files added while the app is running).

The build/publish process computes all the required information about the assets that is used to emit the response. The ETag and Last-Modified values are computed using the Base64(SHA256) hash of the content and the LastWrite on the file at build/publish time.

## Working environment

The repository is checked out at `/app/aspnetcore` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.

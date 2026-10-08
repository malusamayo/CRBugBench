#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Components/benchmarkapps/Wasm.Performance/dockerfile`:

This pull request introduces the defect later reported as "Blazor Wasm benchmarks not working". The
problem a user observed, and its root cause:

Source:

https://github.com/dotnet/aspnetcore/tree/main/src/Components/benchmarkapps/Wasm.Performance

Full log:

```
[](http://asp-perf-lin:5001/jobs/2)14:56:42.371 INFO [NodeOptions.report] - Adding chrome for {"browserVersion": "100.0","se:noVncPort": 7900,"browserName": "chrome","platformName": "Linux","se:vncEnabled": true} 1 times
14:56:42.378 INFO [Node.<init>] - Binding additional locator mechanisms: id, name, relative
14:56:42.388 INFO [GridModel.setAvailability] - Switching node 2ed53050-c1b7-40cf-b7fb-6c420ccb4226 (uri: http://172.17.0.1:4444/) from DOWN to UP
14:56:42.389 INFO [LocalDistributor.add] - Added node 2ed53050-c1b7-40cf-b7fb-6c420ccb4226 at http://172.17.0.1:4444./ Health check every 120s
14:56:42.454 INFO [Standalone.execute] - Started Selenium Standalone 4.1.3 (revision 7b1ebf28ef): http://172.17.0.1:4444/
Connected to Selenium
14:56:43.117 INFO [LocalDistributor.newSession] - Session request received by the distributor: 
 [Capabilities {browserName: chrome, goog:chromeOptions: {args: [--headless]}, goog:loggingPrefs: {browser: ALL}}]
[STDERR] Starting ChromeDriver 100.0.4896.60 (6a5d10861ce8de5fce22564658033b43cb7de047-refs/branch-heads/4896@{#875}) on port 37628
[STDERR] Only local connections are allowed.
[STDERR] Please see https://chromedriver.chromium.org/security-considerations for suggestions on keeping ChromeDriver safe.
[STDERR] ChromeDriver was started successfully.
14:56:43.313 INFO [ProtocolHandshake.createSession] - Detected dialect: W3C
14:56:43.327 INFO [LocalDistributor.newSession] - Session created by the distributor. Id: c81f36d6c7b7a21937df7fefc076c2a0, Caps: Capabilities {acceptInsecureCerts: false, browserName: chrome, browserVersion: 100.0.4896.75, chrome: {chromedriverVersion: 100.0.4896.60 (6a5d10861ce8..., userDataDir: /tmp/.com.google.Chrome.BcSBIZ}, goog:chromeOptions: {debuggerAddress: localhost:44035}, goog:loggingPrefs: {browser: ALL}, networkConnectionEnabled: false, pageLoadStrategy: normal, platformName: linux, proxy: Proxy(), se:cdp: ws://172.17.0.1:4444/sessio..., se:cdpVersion: 100.0.4896.75, se:vnc: ws://172.17.0.1:4444/sessio..., se:vncEnabled: true, se:vncLocalAddress: ws://172.17.0.1:7900, setWindowRect: true, strictFileInteractability: false, timeouts: {implicit: 0, pageLoad: 300000, script: 30000}, unhandledPromptBehavior: dismiss and notify, webauthn:extension:credBlob: true, webauthn:extension:largeBlob: true, webauthn:virtualAuthenticators: true}
info: Microsoft.Hosting.Lifetime[14]
      Now listening on: http://127.0.0.1:42381/
info: Microsoft.Hosting.Lifetime[0]
      Application started. Press Ctrl+C to shut down.
info: Microsoft.Hosting.Lifetime[0]
      Hosting environment: Development
info: Microsoft.Hosting.Lifetime[0]
      Content root path: /
Test app listening at http://127.0.0.1:42381./
14:59:44.638 INFO [LocalSessionMap.lambda$new$0] - Deleted session from local session map, Id: c81f36d6c7b7a21937df7fefc076c2a0
[STDERR] Unhandled exception. System.TimeoutException: Timed out after 00:03:00.
[STDERR] Browser state: 
[STDERR] <head>
[STDERR]     <meta charset="utf-8">
[STDERR]     <title>E2EPerformance</title>
[STDERR]     <link href="benchmarks/lib/bootstrap.min.css" rel="stylesheet">
[STDERR]     <link href="benchmarks/lib/minibench/style.css" rel="stylesheet">
[STDERR] </head>
[STDERR] <body style="overflow: scroll;">
[STDERR]     <div class="container" id="display"><div class="d-flex align-items-center"><h2 class="mx-3 flex-grow-1">E2E Performance</h2><label class="ml-auto mr-5"><input type="checkbox" class="mr-2">Verify only</label><button class="btn btn-success ml-auto px-4 run-button" id="runAll" style="display: block;">Run all</button><button class="btn btn-danger ml-auto px-4 stop-button" style="display: none;">Stop</button></div><div class="my-3 py-2 bg-white rounded shadow-sm"><div class="d-flex align-items-baseline px-4"><h5 class="py-2">App Startup</h5><a class="ml-auto run-button" href="" style="display: block;">Run all</a></div><table class="table mb-0 benchmarks"><tbody><tr class="benchmark-idle"><th class="pl-4" scope="row">Time to first UI</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr></tbody></table></div><div class="my-3 py-2 bg-white rounded shadow-sm"><div class="d-flex align-items-baseline px-4"><h5 class="py-2">Rendering list</h5><a class="ml-auto run-button" href="" style="display: block;">Run all</a></div><table class="table mb-0 benchmarks"><tbody><tr class="benchmark-idle"><th class="pl-4" scope="row">Render 10 items</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr><tr class="benchmark-idle"><th class="pl-4" scope="row">Render 100 items</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr><tr class="benchmark-idle"><th class="pl-4" scope="row">Render 1000 items</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr></tbody></table></div><div class="my-3 py-2 bg-white rounded shadow-sm"><div class="d-flex align-items-baseline px-4"><h5 class="py-2">JSON handling</h5><a class="ml-auto run-button" href="" style="display: block;">Run all</a></div><table class="table mb-0 benchmarks"><tbody><tr class="benchmark-idle"><th class="pl-4" scope="row">Serialize 1kb</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr><tr class="benchmark-idle"><th class="pl-4" scope="row">Serialize 340kb</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr><tr class="benchmark-idle"><th class="pl-4" scope="row">Serialize 340kb (Source Generated)</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr><tr class="benchmark-idle"><th class="pl-4" scope="row">Deserialize 1kb</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr><tr class="benchmark-idle"><th class="pl-4" scope="row">Deserialize 340kb</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr><tr class="benchmark-idle"><th class="pl-4" scope="row">Deserialize 340kb (Source Generated)</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr><tr class="benchmark-idle"><th class="pl-4" scope="row">Serialize 340kb (JavaScript)</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr><tr class="benchmark-idle"><th class="pl-4" scope="row">Deserialize 340kb (JavaScript)</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr></tbody></table></div><div class="my-3 py-2 bg-white rounded shadow-sm"><div class="d-flex align-items-baseline px-4"><h5 class="py-2">Nested components</h5><a class="ml-auto run-button" href="" style="display: block;">Run all</a></div><table class="table mb-0 benchmarks"><tbody><tr class="benchmark-idle"><th class="pl-4" scope="row">Render small nested component</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr><tr class="benchmark-idle"><th class="pl-4" scope="row">Render large nested component</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr><tr class="benchmark-idle"><th class="pl-4" scope="row">Render component with edit</th><td></td><td><span></span></td><td class="pr-4" align="right"><a class="run-button" href="">Run</a></td></tr></tbody></table></div><div class="my-3 py-2 bg-white rounded shadow-sm"><div class="d-flex align-items-baseline px-4"><h5 class="py-2">Grid</h5><a class="ml-auto run-button" href="" style="display: b

This same root cause must be fixed before merging.
REVIEW_EOF

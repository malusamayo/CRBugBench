#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `extensions/github-authentication/src/githubServer.ts`:

This pull request introduces the defect later reported as "Trouble logging in to export Profile to gist". The
problem a user observed, and its root cause:

<!-- ⚠️⚠️ Do Not Delete This! bug_report_template ⚠️⚠️ -->
<!-- Please read our Rules of Conduct: https://opensource.microsoft.com/codeofconduct/ -->
<!-- 🕮 Read our guide about submitting issues: https://github.com/microsoft/vscode/wiki/Submitting-Bugs-and-Suggestions -->
<!-- 🔎 Search existing issues to avoid creating duplicates. -->
<!-- 🧪 Test using the latest Insiders build to see if your issue has already been fixed: https://code.visualstudio.com/insiders/ -->
<!-- 💡 Instead of creating your report here, use 'Report Issue' from the 'Help' menu in VS Code to pre-fill useful information. -->
<!-- 🔧 Launch with `code --disable-extensions` to check. -->
Does this issue occur when all extensions are disabled?: Yes/No

<!-- 🪓 If you answered No above, use 'Help: Start Extension Bisect' from Command Palette to try to identify the cause. -->
<!-- 📣 Issues caused by an extension need to be reported directly to the extension publisher. The 'Help > Report Issue' dialog can assist with this. -->
- VS Code Version: 
Version: 1.76.0-insider (user setup)
Commit: c4a609f94329b17d91cd13a4fd113d1abfe5ec1f
Date: 2023-02-03T05:23:17.202Z
Electron: 19.1.9
Chromium: 102.0.5005.194
Node.js: 16.14.2
V8: 10.2.154.23-electron.0
OS: Windows_NT x64 10.0.25281
Sandboxed: Yes
- OS Version: Windows 11

Steps to Reproduce:

1. Export a Profile
2. Brought to browser to grant VS Code auth access, accept it and return to VS Code
3. I'm prompted there was trouble and to try another way
4. I try the other way, but I'm presented the same toast
5. I try another way for a second time, and this time I'm provided a code `To finish authenticating, navigate to GitHub and paste in the above one-time code.`
6. It ultimately succeeded on the third try

I'm logged into other extensions with GitHub, and I didn't see this flow today for other fresh logins (nor have I seen it in the past).

I'm including my GitHub Auth output logs. It looks like I got `[error] FetchError: request to http://localhost:3000/codeExchangeProxyEndpoints/github/login/oauth/access_token failed, reason: connect ECONNREFUSED 127.0.0.1:3000` twice.

[GH-log-feb-3.txt](https://github.com/microsoft/vscode/files/10583135/GH-log-feb-3.txt)

This same root cause must be fixed before merging.
REVIEW_EOF

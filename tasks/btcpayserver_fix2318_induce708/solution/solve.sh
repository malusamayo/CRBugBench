#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `BTCPayServer/Storage/Services/Providers/FileSystemStorage/FileSystemFileProviderService.cs`:

This pull request introduces the defect later reported as "LocalStorage URLs don't contain root path". The
problem a user observed, and its root cause:

<!--
Thank you for reporting a technical issue.

This issue tracker is only for bug reports and problems. 

For general questions please read our documentation docs.btcpayserver.org. You can ask technical questions in discussions https://github.com/btcpayserver/btcpayserver/discussions and general support on our community chat chat.btcpayserver.org

Please fill in as much of the template below as you're able. 
-->

**Describe the bug**
After uploading a file into local storage in server settings a URL is shown which points to `/LocalStorage/...` instead of `/root_paht/LocalStorage/...` and is thus broken. Manually prepending root path fixes the URL which then returns the appropriate file.

**To Reproduce the bug**
Steps to reproduce the reported bug:
1. Setup BTCPayserver with non-empty root path, e.g. `/btcpay`
2. In Server settings -> Files upload any file
3. See the generated Direct URL contains `/LocalStorage/...` instead of `/btcpay/LocalStorage/...`
4. Click indirect URL - it will redirect to Direct URL which is broken
5. Fix the URL by prepending `/btcpay` to path - the request will succeed

**Expected behavior**

Direct URL contains `/btcpay` or whatever root path was set
Indirect URL redirects to URL containing the root path

**Screenshots**

![btcpay-bug](https://user-images.githubusercontent.com/1178779/109295132-84656b80-782e-11eb-816b-c4cea1aab117.png)

**Your BTCPay Environment (please complete the following information):**
- BTCPay Server Version:   1.0.6.7
- Deployment Method:        Debian package
- Browser:                  Firefox

**Logs (if applicable)**

I don't think they are needed

**Setup Parameters**

```
network=mainnet
rootPath=/btcpay
```

The rest should be irrelevant

**Additional context**

Same issue seems to be present in version 1.0.6.4

Cc @MaxHillebrand

This same root cause must be fixed before merging.
REVIEW_EOF

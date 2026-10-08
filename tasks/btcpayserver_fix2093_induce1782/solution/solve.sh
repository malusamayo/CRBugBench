#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `BTCPayServer/Hosting/BTCPayServerServices.cs`:

This pull request introduces the defect later reported as "Node Sync Progress Pop-up Not Showing Up on fresh installation of BTCPayServer using Azure quick-deployment". The
problem a user observed, and its root cause:

**Describe the bug**
I'm having a problem with BTCPayServer. I can replicate the problem by installing a fresh installation of BTCPayServer on an AzureVM. My BTCPay version is _v1.0.6.0 (altcoins)_, and I deployed my server on Azure by following the instructions on the [docs](https://docs.btcpayserver.org/AzureDeployment/) deployment guide (pretty straightforward), just had to click on the Azure Deploy button and fill in the inputs. My BTCPay Setup seems to be ok! The only problem is that it's not showing the node Sync pop-up on the bottom corner, as it used to do all the times I deployed using this method before. Here are the logs I was able to get from my BTCPay instance. You can see the error in the image I attached.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to [Azure Deployment Docs](https://docs.btcpayserver.org/AzureDeployment/)
2. Click on `Deploy to Azure` button
3. Fill in the inputs on Azure portal
4. Browse your fresh installed instance of BTCPayServer
5. The node sync progress pop-up won't be there!

**Expected behavior**
I expected to see the progress of the node sync as usual.

**Screenshots**
<img width="1116" alt="Missing progress pop-up" src="https://user-images.githubusercontent.com/29668752/100829945-8c309200-3430-11eb-8455-56aa741efe91.png">

**Your BTCPay Environment (please complete the following information):**
- BTCPay Server Version: v1.0.6.0 (altcoins)
- Deployment Method: Azure quick-deploy button
- Browser: I have tested on Chrome and Sfari

**Logs (if applicable)**
Basic logs can be found in Server Settings > Logs. More logs https://docs.btcpayserver.org/Troubleshooting/#2-looking-through-the-logs
```
2020-12-02 04:36:17.924 +00:00 [INF] BTC: Explorer url is http://nbxplorer:32838/
2020-12-02 04:36:18.015 +00:00 [INF] BTC: Cookie file is /root/.nbxplorer/Main/.cookie
2020-12-02 04:36:18.034 +00:00 [INF] LTC: Explorer url is http://nbxplorer:32838/
2020-12-02 04:36:18.035 +00:00 [INF] LTC: Cookie file is /root/.nbxplorer/Main/.cookie
2020-12-02 04:36:18.447 +00:00 [INF] Internal Socks HTTP Proxy listening at http://127.0.0.1:42553/
2020-12-02 04:36:18.522 +00:00 [INF] SSH settings detected, testing connection to root@host.docker.internal on port 22 ...
2020-12-02 04:36:18.651 +00:00 [INF] Starting listening NBXplorer (BTC)
2020-12-02 04:36:18.855 +00:00 [INF] Starting listening NBXplorer (LTC)
2020-12-02 04:36:18.906 +00:00 [INF] Start watching invoices
2020-12-02 04:36:19.184 +00:00 [INF] Starting payment request expiration watcher
2020-12-02 04:36:19.657 +00:00 [INF] NBXplorer BTC: NotConnected => Synching
2020-12-02 04:36:19.723 +00:00 [INF] NBXplorer LTC: NotConnected => Synching
2020-12-02 04:36:19.928 +00:00 [INF] SSH connection succeeded
2020-12-02 04:36:20.025 +00:00 [INF] 0 pending payment requests being checked since last run
2020-12-02 04:36:49.351 +00:00 [ERR] An exception was thrown while deserializing the token.
Microsoft.AspNetCore.Antiforgery.AntiforgeryValidationException: The antiforgery token could not be decrypted.
 ---> System.Security.Cryptography.CryptographicException: The key {08a03ff8-9d59-47e3-9e17-083fa005b4ac} was not found in the key ring.
   at Microsoft.AspNetCore.DataProtection.KeyManagement.KeyRingBasedDataProtector.UnprotectCore(Byte[] protectedData, Boolean allowOperationsOnRevokedKeys, UnprotectStatus& status)
   at Microsoft.AspNetCore.DataProtection.KeyManagement.KeyRingBasedDataProtector.DangerousUnprotect(Byte[] protectedData, Boolean ignoreRevocationErrors, Boolean& requiresMigration, Boolean& wasRevoked)
   at Microsoft.AspNetCore.DataProtection.KeyManagement.KeyRingBasedDataProtector.Unprotect(Byte[] protectedData)
   at Microsoft.AspNetCore.Antiforgery.DefaultAntiforgeryTokenSerializer.Deserialize(String serializedToken)
   --- End of inner exception stack trace ---
   at Microsoft.AspNetCore.Antiforgery.DefaultAntiforgeryTokenSerializer.Deserialize(String serializedToken)
   at Microsoft.AspNetCore.Antiforgery.DefaultAntiforgery.GetCookieTokenDoesNotThrow(HttpContext httpContext)
2020-12-02 04:37:03.951 +00:00 [INF] First admin created, enabling checks for new versions
2020-12-02 04:37:03.952 +00:00 [INF] First admin created, disabling subscription (disable-registration is set to true)
2020-12-02 04:37:04.011 +00:00 [INF] BTCPayServer.Services.PoliciesSettings
2020-12-02 04:37:04.027 +00:00 [INF] BTCPayServer.Events.UserRegisteredEvent
2020-12-02 04:37:04.170 +00:00 [INF] A new user just registered admin@xxxxxxxxxxx.org (admin)
2020-12-02 04:38:43.144 +00:00 [INF] User logged in.
```

**Setup Parameters**
If you're reporting a deployment issue run `. btcpay-setup.sh -i` and paste the setup parameters here with your private information removed or obscured.

**Additional context**
-

This same root cause must be fixed before merging.
REVIEW_EOF

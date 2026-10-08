#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Aspire.Cli/Commands/UpdateCommand.cs`:

This pull request introduces the defect later reported as "[CLI] aspire update --self does not install to current CLI location". The
problem a user observed, and its root cause:

### Is there an existing issue for this?

- [x] I have searched the existing issues

### Describe the bug

I've installed the CLI to `/usr/local/bin` with the installer script.

(Debian 12)

``` bash
curl -sSL https://aspire.dev/install.sh -o /tmp/aspire-install.sh
chmod +x /tmp/aspire-install.sh
sudo /tmp/aspire-install.sh --install-path /usr/local/bin
```
> Aspire CLI successfully installed to: /usr/local/bin/aspire

Then when I run `update --self` to switch channels, it insists on installing to my home dir instead of the current location.

``` bash
 $ aspire update --self --quality daily
📦  Current CLI location: /usr/local/bin/aspire
⬆  Updating to quality level: daily
✔  Validating downloaded file...
✔  Download completed successfully
📦  Extracting new CLI...
💾  Backing up current CLI...
🔧  Installing new CLI to /home/vscode/.aspire/bin...
✔  Updated to version: 13.1.0-preview.1.25572.6+d5f8128bc766b40f3e599315907242a43b28e9ab
ℹ  Note: /home/vscode/.aspire/bin is not in your PATH. Add it to use the updated CLI globally.
```

### Expected Behavior

1. Install the new CLI to the current location
2. Probably add some permission error handling because only root can write to `/usr/local/bin`

### Steps To Reproduce

``` bash
curl -sSL https://aspire.dev/install.sh -o /tmp/aspire-install.sh
chmod +x /tmp/aspire-install.sh
sudo /tmp/aspire-install.sh --install-path /usr/local/bin
aspire update --self --quality daily
```

### Exceptions (if any)

_No response_

### .NET Version info

_No response_

### Anything else?

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF

#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `mitmproxy/certs.py`:

This pull request introduces the defect later reported as "AttributeError: 'cryptography.hazmat.bindings._rust.x509.Certificat' object has no attribute '_cert'". The
problem a user observed, and its root cause:

#### Problem Description

Occasionally, while intercepting in wireguard mode with a custom CA set, mitmproxy will throw the following error:

```
error: [07:30:13.105] Addon error: 'cryptography.hazmat.bindings._rust.x509.Certificat' object has no attribute '_cert'
Traceback (most recent call last):
  File "/lib/python3.10/site-packages/mitmproxy/addons/tlsconfig.py", line 418, in quic_start_client
    tls_start.settings.certificate_chain = [
  File "/lib/python3.10/site-packages/mitmproxy/addons/tlsconfig.py", line 419, in <listcomp>
    cert._cert for cert in (*entry.chain_certs, *extra_chain_certs)
AttributeError: 'cryptography.hazmat.bindings._rust.x509.Certificat' object has no attribute '_cert'
```

This error originates in the QUIC interception code (`quic_start_client`).

#### Steps to reproduce the behavior:
1. Create a custom CA
2. Start mitmproxy with `--set confdir=<path to certs> --mode wireguard`
3. Browse random HTTPS sites on the device connected to the Wireguard VPN

#### System Information

Mitmproxy: 11.0.1
Python:    3.10.11
OpenSSL:   OpenSSL 3.3.2 3 Sep 2024
Platform:  macOS-14.6.1-x86_64-i386-64bit

This same root cause must be fixed before merging.
REVIEW_EOF

#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `tools/packaging/packaging.strings.psd1` (around line 14): See https://github.com/PowerShell/PowerShell/issues/15029#issuecomment-800690344 you can't just link the `libssl` and `libcrypto` symlinks to the OpenSSL 1.1.x version and just expect it to work. It does allow the library to load but causes a hard fault in the process as soon as `libmi` tries to access any of the OpenSSL libraries in that. OpenSSL 1.1.x and 1.0.x (what `libmi` that is shipped by PowerShell is linked to) are not API and ABI compatible.

You need to either link it to OpenSSL 1.0.x and document the `compat-openssl10` (other whatever package provides OpenSSL 1.0.x on the distro) requirement for WSMan work or ship a recompiled `libmi` against OpenSSL 1.1.x so it can use a modern OpenSSL version.
REVIEW_EOF

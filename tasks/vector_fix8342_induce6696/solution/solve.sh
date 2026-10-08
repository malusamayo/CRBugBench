#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `distribution/systemd/vector.service`:

This pull request introduces the defect later reported as "Nightly v0.15 breaks the CentOS 7 compatibility?". The
problem a user observed, and its root cause:

<!--
Hi there,

Thank you for opening an issue. Please note that we try to keep the Vector issue tracker reserved for bug reports and feature requests. For general usage questions, please see: https://chat.vector.dev.
-->

### Vector Version

<!---
Run `vector --version` to show the version, and paste the result between the ``` marks below.

If you are not running the latest version of Vector, please try upgrading because your issue may have already been fixed.
-->

```
vector 0.15.0 nightly
```

### Vector Configuration File

<!--
Paste the relevant parts of your `vector.toml` configuration between the ``` marks below.

!! If your config files contain sensitive information please remove it !!
-->

```toml

```

### Debug Output

<!--
Full debug output can be obtained by running Vector with the following:

```
RUST_BACKTRACE=full vector -vvv <rest of commands>
```

Please create a GitHub Gist containing the debug output. Please do _not_ paste the debug output in the issue, since debug output is long.

!! Debug output may contain sensitive information. Please review it before posting publicly. !!
-->


### Expected Behavior

<!--
What should have happened?
-->
When I install the v0.15 nightly, the program works fine expect for the unit file. So I can't use the systemd. I use CentOS7 and the systemd v219. This systemd aren't compatible with the sandboxes. 

I didn't have any problem with the Vector v0.14. Maybe, it's a bug or a dependency should be added?

### Actual Behavior
No dependency specified during installation
<!--
What actually happened?
-->

### Example Data

<!--
Please provide any example data that will help debug the issue, for example:

```
201.69.207.46 - kemmer6752 [07/06/2019:14:53:55 -0400] "PATCH /innovative/interfaces" 301 669
```
-->

### Additional Context

<!--
Is there anything atypical about your situation that we should know? For example: is Vector running in Kubernetes? Are you passing any unusual command line options or environment variables to opt-in to non-default behavior?
-->

### References

<!--
Are there any other GitHub issues (open or closed) or Pull Requests that should be linked here? For example:

- #6017

-->

This same root cause must be fixed before merging.
REVIEW_EOF

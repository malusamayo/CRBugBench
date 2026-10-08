#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/config/watcher.rs`:

This pull request introduces the defect later reported as "--watch-config hot reloading is not working with config namespacing". The
problem a user observed, and its root cause:

### A note for the community

<!-- Please keep this note for the community -->
* Please vote on this issue by adding a 👍 [reaction](https://blog.github.com/2016-03-10-add-reactions-to-pull-requests-issues-and-comments/) to the original issue to help the community and maintainers prioritize this request
* If you are interested in working on this issue or have submitted a pull request, please leave a comment
<!-- Thank you for keeping this note for the community -->


### Problem

Using the automatic-namespacing scenario, and after successfully starting with the command "vector -C /etc/vector -w", if you edit the configuration in the sources, transforms, and sinks directories and find that hot reloading is not working

[https://vector.dev/docs/reference/configuration/#automatic-namespacing](url)

### Configuration

_No response_

### Version

0.38.0

### Debug Output

_No response_

### Example Data

_No response_

### Additional Context

_No response_

### References

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF

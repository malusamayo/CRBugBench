#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `app/common/src/main/java/stirling/software/common/model/ApplicationProperties.java` (around line 379): Wouldn't it be better if

```java
        @JsonIgnore
        public String getBaseTmpDir() {
            if (baseTmpDir != null && !baseTmpDir.isEmpty()) {
                return baseTmpDir;
            }
            String tmp = java.lang.System.getProperty("java.io.tmpdir");
            return new File(tmp, "stirling-pdf").getPath();
        }

        @JsonIgnore
        public String getLibreofficeDir() {
            if (libreofficeDir != null && !libreofficeDir.isEmpty()) {
                return libreofficeDir;
            }
            return new File(getBaseTmpDir(), "libreoffice").getPath();
        }
```

This would eliminate problems with Windows (`\`) and Linux (`/`)
REVIEW_EOF

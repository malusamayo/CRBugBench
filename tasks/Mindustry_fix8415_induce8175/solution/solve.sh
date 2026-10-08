#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `core/src/mindustry/entities/Damage.java`:

This pull request introduces the defect later reported as "[Bug Log] Memory Leak in Pools". The
problem a user observed, and its root cause:

**Version**:   v142.001
**Problem**:  Memory Leak in Pools
![image](https://user-images.githubusercontent.com/15688938/226651567-2934d3c1-c9b7-40ac-bb05-f667c54ee520.png)
**Source**:  `mindustry.entities.Damage.Collided` reference `Teamc`(may be `Building`) but no `reset` to release.
![image](https://user-images.githubusercontent.com/15688938/226653277-2aeb91f3-97f2-40bb-a5f6-e91ab89acf3d.png)

This same root cause must be fixed before merging.
REVIEW_EOF

#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/common/Elsa.DropIns/HostedServices/DropInDirectoryMonitorHostedService.cs`:

This pull request introduces the defect later reported as "Elsa 3.0 DropIns Features does not appear to work". The
problem a user observed, and its root cause:

I cannot seem to get the DropIn feature workring with Elsa 3 (3.0.2 and 3.0.3).  I am using the 'Elsa.Server.Web' project from the main branch since it has the drop-in feature enabled in program.cs..  I am running this from visual studio (not the docker image, 'elsaworkflows/elsa-server-v3:latest') The App_Data/DropIns folder is created; however, when I drop a .dll that has a custom activity in it; I cannot see it in the designer.  I had this working back in November/Decmber timeframe before elsa 3 was released.  I have also tried to copy the .dll from the 'samples\drop-ins\SampleDropIn' sample project and it still does not work.  
I have treid from both teh docker hub images and the Elsa.Server.Web project.

This same root cause must be fixed before merging.
REVIEW_EOF

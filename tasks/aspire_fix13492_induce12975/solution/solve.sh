#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Aspire.Dashboard/Components/Controls/ResourceDetails.razor`:

This pull request introduces the defect later reported as "[AspireE2E] When the mouse hovers over the filter icon of the Aspire 13.1 project , the icon name is invalid". The
problem a user observed, and its root cause:

**REGRESSION INFO**: work well on Aspire templates 13.0.2

**INSTALL STEPS**
1. Clean machine: Windows x64 25h2
1. Install SDK 10.0.100: https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-10.0.100-windows-x64-installer
1. Install Aspire CLI - version: 13.1.0-preview.1.25604.7
`iex "& { $(irm https://aspire.dev/install.ps1) } -Quality dev" `

**REPRO STEPS**

1. Create aspire starter app with following command:
    `aspire new aspire-starter --name AspireStarterApp`
1. Go to the project folder and run the app
   `cd AspireStarterApp/AspireStarterApp.AppHost`
1. Run the Aspire Starter App project using the following command:
 `aspire run`
1. Open the Dashboard link in browser
1. In `Action column,` click `Actions button`, click `view details`
1. Hover the mouse over the filter icon

**ACTUAL**

<img width="924" height="187" alt="Image" src="https://github.com/user-attachments/assets/e70d7e78-7560-4865-bf24-ef4238407ad2" />

**Expected**

<img width="979" height="163" alt="Image" src="https://github.com/user-attachments/assets/72454f61-963a-42dc-9377-59cb495b3a38" />

This same root cause must be fixed before merging.
REVIEW_EOF

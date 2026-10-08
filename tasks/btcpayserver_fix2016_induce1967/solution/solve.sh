#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `BTCPayServer/Views/PaymentRequest/ViewPaymentRequest.cshtml`:

This pull request introduces the defect later reported as "Payment Request user input rounding issue". The
problem a user observed, and its root cause:

**Describe the bug**
User can't input USD value with cents (i.e. less than one dollar). When choosing the whole dollar amount, it uses a rounded value. It shows this remainder in the input field. When trying to pay the final amount it is not possible because it is the wrong amount, and because cents are not allowed. 

**To Reproduce**
Steps to reproduce the behavior:
1. Create Payment Request with user denomination enabled
2. Try to pay less than $1 (not possible)
3. Pay $1
4. See remainder in the input field
5. Pay $4, see remainder in the input field
6. Try to pay remaining $5 (not possible)
7. Try to pay remaining $4.999979879 (not possible)

**Expected behavior**
No rounding issue and cents payments are possible.

**Screenshots**
If applicable, add screenshots to help explain your problem.
![image](https://user-images.githubusercontent.com/39231115/97070456-858f3f00-1595-11eb-9bbe-9e96ed813750.png)

Try to pay the remaining $5:
![image](https://user-images.githubusercontent.com/39231115/97070479-c25b3600-1595-11eb-8df1-33229b4c2c37.png)
![image](https://user-images.githubusercontent.com/39231115/97070515-2978ea80-1596-11eb-8e94-170d7dd5f363.png)


**Your BTCPay Environment (please complete the following information):**
- BTCPay Server Version: v1.0.5.8 Environment: Development Build: Debug
- Deployment Method: Regtest latest master
 - Browser: Chrome

**Additional context**
I think cents were possible previously but I don't remember.

This same root cause must be fixed before merging.
REVIEW_EOF

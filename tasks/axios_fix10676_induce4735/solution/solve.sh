#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/helpers/formDataToJSON.js`:

This pull request introduces the defect later reported as "axios support select multiple has bug". The
problem a user observed, and its root cause:

default 3 select
```
                <select name="select3" size="5" multiple="multiple">
                    <option value="301" selected>301</option>
                    <option value="302" selected>302</option>
                    <option value="303" selected>303</option>
                </select>
```

js code
```
                const {data} = await axios.post('http://localhost:8080/post/querySelectorForm_to_json__RequestBody', document.querySelector('#form1'), {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });
```

F12  run result array in array

<img width="1363" height="671" alt="Image" src="https://github.com/user-attachments/assets/572ad80e-85ec-4b0e-b4b5-94805134616c" />

i want result is ：
["301", "302", "303"]

default axios code has bug ?? 
I don't want to use transformRequest. I just want to use the default code provided by the Axios official documentation：
https://axios-http.com/zh/docs/post_example

```
const {data} = await axios.post('/user', document.querySelector('#my-form'), {
  headers: {
    'Content-Type': 'application/json'
  }
})
```
However, from the results, it seems that it is not very user-friendly for the "select multiple" option.

This same root cause must be fixed before merging.
REVIEW_EOF

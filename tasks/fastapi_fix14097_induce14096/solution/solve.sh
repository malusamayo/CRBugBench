#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `docs/en/docs/css/custom.css`:

This pull request introduces the defect later reported as "Sponsor Badge CSS overflow issue on the docs". The
problem a user observed, and its root cause:

### Discussed in https://github.com/fastapi/fastapi/discussions/12218

<div type='discussions-op-text'>

<sup>Originally posted by **nat236919** September 19, 2024</sup>
### First Check

- [X] I added a very descriptive title here.
- [X] I used the GitHub search to find a similar question and didn't find it.
- [X] I searched the FastAPI documentation, with the integrated search.
- [X] I already searched in Google "How to X in FastAPI" and didn't find any information.
- [X] I already read and followed all the tutorial in the docs and didn't find an answer.
- [X] I already checked if it is not related to FastAPI but to [Pydantic](https://github.com/pydantic/pydantic).
- [X] I already checked if it is not related to FastAPI but to [Swagger UI](https://github.com/swagger-api/swagger-ui).
- [X] I already checked if it is not related to FastAPI but to [ReDoc](https://github.com/Redocly/redoc).

### Commit to Help

- [X] I commit to help with one of those options 👆

### Example Code

```python
announce-wrapper .sponsor-badge {
    display: block;
    position: absolute;
    top: -10px;
    right: 0;
    font-size: 0.5rem;
    color: #999;
    background-color: #666;
    border-radius: 10px;
    padding: 0 10px;
    z-index: 10;
}
```


### Description

![image](https://github.com/user-attachments/assets/0b9cc528-d268-4e2f-b073-0988228ebd55)

Due to its absolute position and overflow setting, the text is trailing down creating an expected scroll. I think we can simply solve the issue by removing **position: absolute;**

### Operating System

Windows

### Operating System Details

_No response_

### FastAPI Version

NA

### Pydantic Version

NA

### Python Version

NA

### Additional Context

_No response_</div>

This same root cause must be fixed before merging.
REVIEW_EOF

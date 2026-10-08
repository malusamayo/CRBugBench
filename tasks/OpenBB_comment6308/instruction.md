# Code Review Task

You are a maintainer reviewing a pull request to the `OpenBB-finance/OpenBB` repository.

**PR title:** [Feature] - LLM mode

**PR description:**

1. **Why**? (1-3 sentences or a bullet point list):

    - The goal of the OpenBB Platform is to be LLM-friendly and easily used and accessed by LLM frameworks such as Magentic.

2. **What**? (1-3 sentences or a bullet point list):

    - Adds the `llm` `output_type` user preference
    - Adds the `docstring_sections` to the Python system settings that control which sections of the docs are added
    - Adds the `docstring_max_length` to the Python system settings that control the context size of the docstrings

3. **Impact** (1-2 sentences or a bullet point list):

    - Minimal impact to users that don't utilize LLMs

4. **Testing Done**:

    - Tested that it does what is expected.

5. **Reviewer notes**:

   - To try it out please use the following approach
   
```
from openbb import obb

obb.user.preferences.output_type="llm"
obb.system.python_settings.docstring_sections=['description', 'examples']
obb.system.python_settings.docstring_max_length=1024

import openbb
openbb.build()
```

## Working environment

The repository is checked out at `/app/OpenBB` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.

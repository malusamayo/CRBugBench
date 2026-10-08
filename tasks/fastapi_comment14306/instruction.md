# Code Review Task

You are a maintainer reviewing a pull request to the `fastapi/fastapi` repository.

**PR title:** 🚸  Improve tracebacks by adding endpoint metadata

**PR description:**

Today, when validation errors occur, error messages don't indicate what endpoint caused the problem, which can make debugging difficult. 

This PR adds endpoint context metadata to validation error messages to show the filepath (clickable in IDEs!) and line number, function name and HTTP method and route where applicable. The endpoint context is extracted once per endpoint and then cached to avoid any additional performance overhead on subsequent requests. Just to double check, I also ran a rough benchmark (100k requests):
```
Baseline (without changes):     0.0006s
Uncached:     					1.3281s (13.28µs per request)
**Cached**:       				0.0060s (0.06µs per request)
```

Endpoint context only appears in the exception's string representation (server logs). It is **not** exposed to clients in HTTP responses. Clients still receive the standard 422 response with validation error details.

## Examples

### ResponseValidationError

**Before:**
```
fastapi.exceptions.ResponseValidationError: 1 validation error:
  {'type': 'missing', 'loc': ('response', 'id'), 'msg': 'Field required', 'input': {'name': 'Widget'}}
```

**After:**
```
fastapi.exceptions.ResponseValidationError: 1 validation error:
  {'type': 'missing', 'loc': ('response', 'id'), 'msg': 'Field required', 'input': {'name': 'Widget'}}

  File "/Users/savannah/work/fastapi/capture_real_examples.py", line 43, in create_item
    POST /items/
```

### RequestValidationError

**Before:**
```
fastapi.exceptions.RequestValidationError: 1 validation error:
  {'type': 'int_parsing', 'loc': ('path', 'user_id'), 'msg': 'Input should be a valid integer, unable to parse string as an integer', 'input': 'invalid'}
```

**After:**
```
fastapi.exceptions.RequestValidationError: 1 validation error:
  {'type': 'int_parsing', 'loc': ('path', 'user_id'), 'msg': 'Input should be a valid integer, unable to parse string as an integer', 'input': 'invalid'}

  File "/Users/savannah/work/fastapi/capture_real_examples.py", line 38, in get_user
    GET /users/{user_id}
```

### WebSocketRequestValidationError

**Before:**
```
fastapi.exceptions.WebSocketRequestValidationError: 1 validation error:
  {'type': 'int_parsing', 'loc': ('path', 'item_id'), 'msg': 'Input should be a valid integer, unable to parse string as an integer', 'input': 'invalid'}
```

**After:**
```
fastapi.exceptions.WebSocketRequestValidationError: 1 validation error:
  {'type': 'int_parsing', 'loc': ('path', 'item_id'), 'msg': 'Input should be a valid integer, unable to parse string as an integer', 'input': 'invalid'}

  File "/Users/savannah/work/fastapi/capture_real_examples.py", line 48, in websocket_endpoint
    WS /ws/{item_id}
```

## Working environment

The repository is checked out at `/app/fastapi` at this PR's **base commit**
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

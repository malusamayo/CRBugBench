#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `mitmproxy/addons/blocklist.py`:

This pull request introduces the defect later reported as "block_list implicitly lowercases attached filter expression". The
problem a user observed, and its root cause:

## Problem Description

I've been recently trying to add a `block_list` rule which implements "if request has header XYZ then return status code 500" behaviour. It didn't work as expected despite of the fact exactly the same filter expression did work in other built-in addons (e.g. `modify_headers`).

I started searching GH issues and stumbled upon #6329. It revealed that `|~hq X-Custom:\\sfoo|500` is effectively treated as `|~hq x-custom:\\sfoo|500` because of `.lower()` call [here](https://github.com/mitmproxy/mitmproxy/blob/v11.0.2/mitmproxy/addons/blocklist.py#L27). I find this controversial because:

- even though HTTP header names should be treated as case-insensitive according to an RFC, header values certainly don't follow that rule
- filter expression are quite rich and current `block_list` behaviour makes certain implementations impossible, e.g. block request when its body contains `FOO`, but not `foo` or when `Cookie` header contains `BAR=1`, but not `bar=1`
- aforementioned ticket resulted in #6493 which globally turned `~u` filter into a case-insensitive regex. That change had far-reaching consequences - right now if you'd like to attach some logic to `/process/ME/please.html` requests, while leaving `/process/me/please.html` unaffected, it's simply not possible using built-in addons

## Steps to reproduce

1. Put the following in `~/.mitmproxy/config.yaml` file:
```yaml
block_list:
  - "|~hq X-Custom:\\sfoo|500"
modify_headers:
  - "|~hq X-Custom:\\sfoo|x-custom-matched|true"
  - "|~u /process/ME/please\\.html$|x-url-matched|true"
flow_detail: 2
```
2. Start `mitmdump` with: `mitmdump --mode reverse:https://httpbingo.org -p 8443` command
3. Request some content via `mitmdump` instance:

### `https://` + HTTP/1.1 + `X-Custom: foo` header

```
# -------------------------------------------------------------
# Expected: 500 + "x-custom-matched: true" response header
# Got: 200 + "x-custom-matched: true"
# -------------------------------------------------------------
$ curl -k https://localhost:8443/headers -SsD - -o /dev/null -H "X-Custom: foo" --http1.1
HTTP/1.1 200 OK
access-control-allow-credentials: true
access-control-allow-origin: *
content-type: application/json; charset=utf-8
date: Mon, 06 Jan 2025 22:31:41 GMT
content-length: 535
server: Fly/d5165e6e2 (2024-12-18)
via: 1.1 fly.io
fly-request-id: 01JGYVXJ3W2ZQ5R0NZ61X7XJ77-arn
x-custom-matched: true
```

### `https://` + HTTP/2 + `X-Custom: foo` header

Everything's the same except HTTP/2. Headers got lowercased by `curl` which accidentally matched to that implicitly lowercased filter expression in `block_list`:

```
# -------------------------------------------------------------
# Expected: 200 w/o custom response header
# Got: 500 w/o response custom header
# -------------------------------------------------------------
$ curl -k https://localhost:8443/headers -SsD - -o /dev/null -H "x-custom: foo" --http1.1
HTTP/1.1 500 Internal Server Error
Server: mitmproxy 11.0.2
content-length: 0
```

### `https://` + HTTP/1.1 + `x-custom: foo` header

```
# -------------------------------------------------------------
# Expected: 200 w/o custom response header
# Got: 500 w/o response custom header
# -------------------------------------------------------------
$ curl -k https://localhost:8443/headers -SsD - -o /dev/null -H "x-custom: foo" --http1.1
HTTP/1.1 500 Internal Server Error
Server: mitmproxy 11.0.2
content-length: 0
```

### `http://` + HTTP/1.1 + `X-Custom: foo` header

```
# -------------------------------------------------------------
# Expected: 500 + "x-custom-matched: true" response header
# Got: 200 + "x-custom-matched: true"
# -------------------------------------------------------------
$ curl http://localhost:8443/headers -SsD - -o /dev/null -H "X-Custom: foo" --http1.1
HTTP/1.1 200 OK
access-control-allow-credentials: true
access-control-allow-origin: *
content-type: application/json; charset=utf-8
date: Mon, 06 Jan 2025 22:41:49 GMT
content-length: 535
server: Fly/d5165e6e2 (2024-12-18)
via: 1.1 fly.io
fly-request-id: 01JGYWG3V3ASVBKB7VDRGNMD6H-arn
x-custom-matched: true
```

### `http://` + HTTP/2 + `X-Custom: foo` header

As per `mitmdump`'s log message h2c is not supported, so the result is exactly the same as via HTTP/1.1

```
HTTP/2 cleartext connections (h2c upgrade requests) are currently not supported.
```

```
# -------------------------------------------------------------
# Expected: 500 + "x-custom-matched: true" response header
# Got: 200 + "x-custom-matched: true"
# -------------------------------------------------------------
$ curl http://localhost:8443/headers -SsD - -o /dev/null -H "X-Custom: foo" --http2
HTTP/1.1 200 OK
access-control-allow-credentials: true
access-control-allow-origin: *
content-type: application/json; charset=utf-8
date: Mon, 06 Jan 2025 22:42:13 GMT
content-length: 535
server: Fly/d5165e6e2 (2024-12-18)
via: 1.1 fly.io
fly-request-id: 01JGYWGW4Q4T1C9B8S7JGVC93V-arn
x-custom-matched: true
```

### Case-insensitive `~u` example

```
# -------------------------------------------------------------
# Expected: "x-url-matched: true" header
# Got: "x-url-matched: true" header
# -------------------------------------------------------------
$ curl -k https://localhost:8443/process/ME/please.html -SsD -
HTTP/2 404
access-control-allow-credentials: true
access-control-allow-origin: *
content-type: text/plain; charset=utf-8
x-content-type-options: nosniff
date: Mon, 06 Jan 2025 22:44:59 GMT
content-length: 19
server: Fly/d5165e6e2 (2024-12-18)
via: 2 fly.io
fly-request-id: 01JGYWNXMAXNK7WB1MZ1318106-arn
x-url-matched: true

404 page not found

# -------------------------------------------------------------
# Expected: NO custom header
# Got: "x-url-matched: true" header
# -------------------------------------------------------------
$ curl -k https://localhost:8443/process/me/please.html -SsD -
HTTP/2 404
access-control-allow-credentials: true
access-control-allow-origin: *
content-type: text/plain; charset=utf-8
x-content-type-options: nosniff
date: Mon, 06 Jan 2025 22:45:05 GMT
content-length: 19
server: Fly/d5165e6e2 (2024-12-18)
via: 2 fly.io
fly-request-id: 01JGYWP39TM9DKFR5X6Q9K5AFV-arn
x-url-matched: true

404 page not found
```

## Expected state

1. `block_list` filter expressions must not be silently lowercased, but rather treated as-is
3. Don't treat `~u` as case-insensitive (or add an option to switch to case-**sensitive** matching)

## Noteworthy facts

1. A switch from HTTP/1.1 to HTTP/2 results in a totally different response (`200` vs `500`)
2. A custom addon can be used as a fallback to circumvent these issues, but it sort of defeats the purpose of built-in addons
3. `mitmdump` output: https://gist.github.com/jwadolowski/c525d4b36d973b97cfb857414f1d7d78

## System Information

```
$ mitmproxy --version
Mitmproxy: 11.0.2 binary
Python:    3.12.7
OpenSSL:   OpenSSL 3.4.0 22 Oct 2024
Platform:  macOS-15.2-arm64-arm-64bit
```

PS. I've been using `mitmproxy` for years and find it extremely useful to debug HTTP flows.

This same root cause must be fixed before merging.
REVIEW_EOF

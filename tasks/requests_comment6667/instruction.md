# Code Review Task

You are a maintainer reviewing a pull request to the `psf/requests` repository.

**PR title:** Avoid reloading root certificates to improve concurrent performance

**PR description:**

## Reproducing the problem

Let's consider the following script. It runs a bunch of concurrent requests against a URL, both with certificate verification enabled and disabled, and outputs the time it takes to do it in both cases.

```py
from time import time
from threading import Thread
import requests
import urllib3

urllib3.disable_warnings()

def do_request(verify):
    requests.get('https://example.com', verify=verify)

def measure(verify):
    threads = [Thread(target=do_request, args=(verify,)) for _ in range(30)]

    start = time()
    for t in threads: t.start()
    for t in threads: t.join()
    end = time()

    print(end - start)

measure(verify=True)
measure(verify=False)
```

What's the time difference between the two? It turns out it is highly dependent on your local configuration. On my local machine, with a relatively modern config (Python 3.12 + OpenSSL 3.0.2), the times are `~1.2s` for `verify=True` and `~0.5s` for `verify=False`.

It's a >100% difference, but we initially blamed it on cert verification taking some time. However, we observed even larger differences (>500%) in some environments, and decided to find out what was going on.

## Problem description

Our main use case for requests is running lots of requests concurrently, and we spent some time bisecting this oddity to see if there was room for a performance optimization.

The issue is a bit more clear if you profile the concurrent executions. When verifying certs, these are the top 3 function calls by time spent in them:

```
ncalls  tottime  percall  cumtime  percall filename:lineno(function)
30/1    0.681    0.023    0.002    0.002 {method 'load_verify_locations' of '_ssl._SSLContext' objects}
30/1    0.181    0.006    0.002    0.002 {method 'connect' of '_socket.socket' objects}
60/2    0.180    0.003    1.323    0.662 {method 'read' of '_ssl._SSLSocket' objects}
```

Conversely, this is how the top 3 looks like without cert verification:

```
ncalls  tottime  percall  cumtime  percall filename:lineno(function)
30/1    0.233    0.008    0.001    0.001 {method 'do_handshake' of '_ssl._SSLSocket' objects}
30/1    0.106    0.004    0.002    0.002 {method 'connect' of '_socket.socket' objects}
60/2    0.063    0.001    0.505    0.253 {method 'read' of '_ssl._SSLSocket' objects}
```

In the first case, a full 0.68 seconds are spent in the `load_verify_locations()` function of the `ssl` module, which configures a `SSLContext` object to use a set of CA certificates for validation. Inside it, there is a C FFI call to OpenSSL's `SSL_CTX_load_verify_locations()` which [is known](https://github.com/python/cpython/issues/95031) to be [quite slow](https://github.com/openssl/openssl/issues/16871). This happens once per request (hence the `30` on the left).

We believe that, in some cases, there is even some blocking going on, either because each FFI call locks up the GIL or because of some thread safety mechanisms in OpenSSL itself. We also think that this is more or less pronounced depending on internal changes between OpenSSL's versions, hence the variability between environments.

When cert validation isn't needed, these calls are skipped which speeds up concurrent performance dramatically.

## Submitted solution

It isn't possible to skip loading root CA certificates entirely, but it isn't necessary to do it on every request. More specifically, a call to `load_verify_locations()` happens when:

- A new `urllib3.connectionpool.HTTPSConnectionPool` is created.

- On connection, by urllib3's `ssl_wrap_socket()`, when the connection's `ca_certs` or `ca_cert_dir` attributes are set (see [the relevant code](https://github.com/urllib3/urllib3/blob/9929d3c4e03b71ba485148a8390cd9411981f40f/src/urllib3/util/ssl_.py#L438)).

The first case doesn't need to be addressed anymore after the latest addition of `_get_connection()`. Since it now passes  down `pool_kwargs`, this allows urllib3 to use a cached pool with the same settings every time, instead of creating one per request.

The second one is addressed in this PR. If a verified connection is requested, `_urllib3_request_context()` already makes it so that a connection pool using a `SSLContext` with all relevant certificates loaded is always used. Hence, there is no need to trigger a call to `load_verify_locations()` again.

You can test against https://invalid.badssl.com to check that `verify=True` and `verify=False` still behave as expected and are now equally fast.

I'd like to mention that there have been a few changes in Requests since I started drafting this, and I'm not sure that setting `conn.ca_certs` or `conn.ca_certs = cert_loc` in `cert_verify()` is even still needed, since I think that the logic could be moved to `_urllib3_request_context()` and benefit from using a cached context in those cases too.

## Working environment

The repository is checked out at `/app/requests` at this PR's **base commit**
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

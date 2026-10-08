#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `netbox/utilities/views.py`:

This pull request introduces the defect later reported as "Error 500 when supplying wrong Authorization token". The
problem a user observed, and its root cause:

### NetBox Edition

NetBox Community

### NetBox Version

v4.5.0

### Python Version

3.13

### Steps to Reproduce

Configure logging: https://docs.djangoproject.com/en/6.0/topics/logging/#id3
(not required to reproduce, only to see stack trace)

```
curl -i -H 'Authorization: Bearer hello.world' https://demo.netbox.dev/media/foobar
```

### Expected Behavior

Some 4xx error, maybe 401 or generic 400.

### Observed Behavior

```
HTTP/1.1 500 Internal Server Error
...
<pre class="block"><strong>&lt;class &#x27;rest_framework.exceptions.AuthenticationFailed&#x27;&gt;</strong><br />
Invalid v1 token

Python version: 3.12.3
NetBox version: 4.5.0
Plugins: 
  netbox_demo: 0.5.0
</pre>
...
```

`journalctl -u netbox.service` shows:
```
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]: Internal Server Error: /media/foobar
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]: Traceback (most recent call last):
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:   File "/opt/netbox/netbox/netbox/middleware.py", line 128, in __call__
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:     username = request.META[self.header]
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:                ~~~~~~~~~~~~^^^^^^^^^^^^^
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]: KeyError: 'HTTP_REMOTE_USER'
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]: During handling of the above exception, another exception occurred:
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]: Traceback (most recent call last):
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:   File "/opt/netbox/netbox/netbox/api/authentication.py", line 63, in authenticate
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:     token = qs.get(version=version, plaintext=plaintext)
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:   File "/opt/netbox-4.5.0/venv/lib/python3.13/site-packages/django/db/models/query.py", line 635, in get
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:     raise self.model.DoesNotExist(
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:         "%s matching query does not exist." % self.model._meta.object_name
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:     )
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]: users.models.tokens.Token.DoesNotExist: Token matching query does not exist.
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]: During handling of the above exception, another exception occurred:
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]: Traceback (most recent call last):
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:   File "/opt/netbox-4.5.0/venv/lib/python3.13/site-packages/django/core/handlers/exception.py", line 55, in inner
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:     response = get_response(request)
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:   File "/opt/netbox-4.5.0/venv/lib/python3.13/site-packages/django/core/handlers/base.py", line 197, in _get_response
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:     response = wrapped_callback(request, *callback_args, **callback_kwargs)
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:   File "/opt/netbox-4.5.0/venv/lib/python3.13/site-packages/django/views/generic/base.py", line 105, in view
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:     return self.dispatch(request, *args, **kwargs)
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:            ~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:   File "/opt/netbox/netbox/utilities/views.py", line 53, in dispatch
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:     auth_info = authenticator.authenticate(request)
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:   File "/opt/netbox/netbox/netbox/api/authentication.py", line 71, in authenticate
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]:     raise exceptions.AuthenticationFailed(f"Invalid v{version} token")
Jan 15 18:24:12 netbox-stg1 gunicorn[3021440]: rest_framework.exceptions.AuthenticationFailed: Invalid v1 token
```

This same root cause must be fixed before merging.
REVIEW_EOF

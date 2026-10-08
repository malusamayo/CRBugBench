#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/ansible/modules/crypto/openssl_certificate.py`:

This pull request introduces the defect later reported as "openssl_certificate: has_expired=no does nothing". The
problem a user observed, and its root cause:

<!--- Verify first that your issue is not already reported on GitHub -->
<!--- Also test if the latest release and devel branch are affected too -->
<!--- Complete *all* sections as described, this form is processed automatically -->

##### SUMMARY
Setting the `has_expired` argument of the `openssl_certificate` module to a false value has no effect.

##### ISSUE TYPE
- Bug Report

##### COMPONENT NAME
openssl_certificate

##### ANSIBLE VERSION
<!--- Paste verbatim output from "ansible --version" between quotes -->
```paste below
ansible 2.7.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/home/[redacted]/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.12 (default, Nov 12 2018, 14:36:49) [GCC 5.4.0 20160609]
```

##### CONFIGURATION
<!--- Paste verbatim output from "ansible-config dump --only-changed" between quotes -->
```paste below

```

##### OS / ENVIRONMENT
<!--- Provide all relevant information below, e.g. target OS versions, network device firmware, etc. -->
I encountered this on Ubuntu 16.04.

##### STEPS TO REPRODUCE
<!--- Describe exactly how to reproduce the problem, using a minimal test-case -->

<!--- Paste example playbooks or commands between quotes below -->

First, create an expired certificate:

```
$ openssl req -x509 -new -nodes -subj /CN=Foobar -out /tmp/test.crt -keyout /dev/null -days -1
[...]
$ openssl verify -trusted /tmp/test.crt /tmp/test.crt
/tmp/test.crt: CN = Foobar
error 10 at 0 depth lookup:certificate has expired
OK
```

Then, run Ansible like this:

```
$ ansible localhost -m openssl_certificate -a 'provider=assertonly path=/tmp/test.crt has_expired=no'
```

<!--- HINT: You can paste gist.github.com links for larger files -->

##### EXPECTED RESULTS
<!--- Describe what you expected to happen when running the steps above -->
The module should fail, as the certificate has expired.

##### ACTUAL RESULTS
<!--- Describe what actually happened. If possible run with extra verbosity (-vvvv) -->

The module succeeds:

<!--- Paste verbatim command output between quotes -->
```paste below
 [WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

localhost | SUCCESS => {
    "changed": false, 
    "csr": null, 
    "filename": "/tmp/test.crt", 
    "privatekey": null
}
```

This same root cause must be fixed before merging.
REVIEW_EOF

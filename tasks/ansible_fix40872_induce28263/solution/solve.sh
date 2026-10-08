#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/ansible/modules/crypto/openssl_certificate.py`:

This pull request introduces the defect later reported as "openssl_certificate: TypeError: unorderable types: str() >= bytes". The
problem a user observed, and its root cause:

<!---
Verify first that your issue/request is not already reported on GitHub.
THIS FORM WILL BE READ BY A MACHINE, COMPLETE ALL SECTIONS AS DESCRIBED.
Also test if the latest release, and devel branch are affected too.
ALWAYS add information AFTER (OUTSIDE) these html comments.
Otherwise it may end up being automatically closed by our bot. -->

##### SUMMARY
<!--- Explain the problem briefly -->
The exception `TypeError: unorderable types: str() >= bytes()` is raised when checking for `valid_in` using Python 3.

##### ISSUE TYPE
 - Bug Report

##### COMPONENT NAME
<!--- Insert, BELOW THIS COMMENT, the name of the module, plugin, task or feature.
Do not include extra details here, e.g. "vyos_command" not "the network module vyos_command" or the full path-->
openssl_certificate

##### ANSIBLE VERSION
<!--- Paste, BELOW THIS COMMENT, verbatim output from "ansible --version" between quotes below -->
```
ansible 2.5.3
  config file = /home/me/repos/ansible/ansible.cfg
  configured module search path = ['/home/me/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.5/dist-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 3.5.3 (default, Jan 19 2017, 14:11:04) [GCC 6.3.0 20170118]
```

##### CONFIGURATION
<!--- If using Ansible 2.4 or above, paste, BELOW THIS COMMENT, the results of "ansible-config dump --only-changed"
Otherwise, mention any settings you have changed/added/removed in ansible.cfg
(or using the ANSIBLE_* environment variables).-->

##### OS / ENVIRONMENT
<!--- Mention, BELOW THIS COMMENT, the OS you are running Ansible from, and the OS you are
managing, or say "N/A" for anything that is not platform-specific.
Also mention the specific version of what you are trying to control,
e.g. if this is a network bug the version of firmware on the network device.-->
```
Linux ifu-0263 4.9.0-6-amd64 #1 SMP Debian 4.9.82-1+deb9u3 (2018-03-02) x86_64 GNU/Linux
No LSB modules are available.
Distributor ID:	Debian
Description:	Debian GNU/Linux 9.4 (stretch)
Release:	9.4
Codename:	stretch
```
Installation from pip

##### STEPS TO REPRODUCE
<!--- For bugs, show exactly how to reproduce the problem, using a minimal test-case.
For new features, show how the feature would be used. -->

<!--- Paste example playbooks or commands between quotes below -->
```yaml
ansible localhost -m openssl_certificate -a 'provider=assertonly path=path_to_any_cert valid_in=1'
```

<!--- You can also paste gist.github.com links for larger files -->

##### EXPECTED RESULTS
<!--- What did you expect to happen when running the steps above? -->
Python 2.7.9 / ansible 2.4.3.0 output:
```
localhost | SUCCESS => {
    "changed": false, 
    "csr": null, 
    "filename": "path_to_any_cert", 
    "privatekey": null
}
```
##### ACTUAL RESULTS
<!--- What actually happened? If possible run with extra verbosity (-vvvv) -->

<!--- Paste verbatim command output between quotes below -->
```
The full traceback is:
Traceback (most recent call last):
  File "/tmp/ansible_4f9cmasi/ansible_module_openssl_certificate.py", line 901, in <module>
    main()
  File "/tmp/ansible_4f9cmasi/ansible_module_openssl_certificate.py", line 880, in main
    certificate.generate(module)
  File "/tmp/ansible_4f9cmasi/ansible_module_openssl_certificate.py", line 703, in generate
    self.assertonly()
  File "/tmp/ansible_4f9cmasi/ansible_module_openssl_certificate.py", line 698, in assertonly
    f_name()
  File "/tmp/ansible_4f9cmasi/ansible_module_openssl_certificate.py", line 684, in _validate_valid_in
    if not (valid_in_date >= self.cert.get_notBefore() and valid_in_date <= self.cert.get_notAfter()):
TypeError: unorderable types: str() >= bytes()

localhost | FAILED! => {
    "changed": false,
    "module_stderr": "Traceback (most recent call last):\n  File \"/tmp/ansible_4f9cmasi/ansible_module_openssl_certificate.py\", line 901, in <module>\n    main()\n  File \"/tmp/ansible_4f9cmasi/ansible_module_openssl_certificate.py\", line 880, in main\n    certificate.generate(module)\n  File \"/tmp/ansible_4f9cmasi/ansible_module_openssl_certificate.py\", line 703, in generate\n    self.assertonly()\n  File \"/tmp/ansible_4f9cmasi/ansible_module_openssl_certificate.py\", line 698, in assertonly\n    f_name()\n  File \"/tmp/ansible_4f9cmasi/ansible_module_openssl_certificate.py\", line 684, in _validate_valid_in\n    if not (valid_in_date >= self.cert.get_notBefore() and valid_in_date <= self.cert.get_notAfter()):\nTypeError: unorderable types: str() >= bytes()\n",
    "module_stdout": "",
    "msg": "MODULE FAILURE",
    "rc": 1
}

```

This same root cause must be fixed before merging.
REVIEW_EOF

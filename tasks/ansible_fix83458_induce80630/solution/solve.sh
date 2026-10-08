#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/ansible/modules/service_facts.py`:

This pull request introduces the defect later reported as "service_facts module on OpenBSD does not support '=' within service variables (too many values to unpack (expected 2))". The
problem a user observed, and its root cause:

### Summary

The ansible.builtin.service_facts crashes if a rcctl variable contains '='

Fix seems easy, add ", 1" to the split function call in get_info() to only split on the first =.
(lib/ansible/modules/service_facts.py line 380 in current git)

### Issue Type

Bug Report

### Component Name

service_facts

### Ansible Version

```console
$ ansible --version
ansible [core 2.16.3]
  config file = /home/phil/Documents/Home/infrastructure/ansible/ansible.cfg
  configured module search path = ['/home/phil/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/phil/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.12.3 (main, Apr 10 2024, 05:33:47) [GCC 13.2.0] (/usr/bin/python3)
  jinja version = 3.1.2
  libyaml = True
```


### Configuration

```console
$ ansible-config dump --only-changed -t all
ANSIBLE_COW_SELECTION(env: ANSIBLE_COW_SELECTION) = random
CONFIG_FILE() = None
```


### OS / Environment

Target is OpenBSD 7.5
Host is Ubuntu 24.04

### Steps to Reproduce

Actual case that triggered this. Any '=' sign within the value of a rcctl variable will probably do it, flags is most likely.

On OpenBSD machine:  
$ rcctl set dkimproxy_out flags --conf_file=/etc/dkimproxy_out.conf --user=_dkimproxy --group=_dkimproxy

On ansible:
$ ansible -m service_facts <openbsd host>


### Expected Results

host-02 | SUCCESS => {
    "ansible_facts": {
        "services": {
......(trimmed many services)
            "dkimproxy_out": {
                "class": "daemon",
                "execdir": "",
                "flags": "--conf_file=/etc/dkimproxy_out.conf --user=_dkimproxy --group=_dkimproxy",
                "logger": "",
                "name": "dkimproxy_out",
                "rogue": false,
                "rtable": "0",
                "source": "rcctl",
                "state": "stopped",
                "status": "enabled",
                "timeout": "30",
                "user": "root"
            },
......

### Actual Results

```console
host-02 | FAILED! => {
    "changed": false,
    "module_stderr": "Shared connection to host-02.pjh.id.au closed.\r\n",
    "module_stdout": "\r\nTraceback (most recent call last):\r\n  File \"/home/phil/.ansible/tmp/ansible-tmp-1718604987.2725172-957680-107655387113561/AnsiballZ_service_facts.py\", line 107, in <module>\r\n    _ansiballz_main()\r\n  File \"/home/phil/.ansible/tmp/ansible-tmp-1718604987.2725172-957680-107655387113561/AnsiballZ_service_facts.py\", line 99, in _ansiballz_main\r\n    invoke_module(zipped_mod, temp_path, ANSIBALLZ_PARAMS)\r\n  File \"/home/phil/.ansible/tmp/ansible-tmp-1718604987.2725172-957680-107655387113561/AnsiballZ_service_facts.py\", line 47, in invoke_module\r\n    runpy.run_module(mod_name='ansible.modules.service_facts', init_globals=dict(_module_fqn='ansible.modules.service_facts', _modlib_path=modlib_path),\r\n  File \"/usr/local/lib/python3.10/runpy.py\", line 224, in run_module\r\n    return _run_module_code(code, init_globals, run_name, mod_spec)\r\n  File \"/usr/local/lib/python3.10/runpy.py\", line 96, in _run_module_code\r\n    _run_code(code, mod_globals, init_globals,\r\n  File \"/usr/local/lib/python3.10/runpy.py\", line 86, in _run_code\r\n    exec(code, run_globals)\r\n  File \"/tmp/ansible_service_facts_payload_w2496z4s/ansible_service_facts_payload.zip/ansible/modules/service_facts.py\", line 435, in <module>\r\n  File \"/tmp/ansible_service_facts_payload_w2496z4s/ansible_service_facts_payload.zip/ansible/modules/service_facts.py\", line 424, in main\r\n  File \"/tmp/ansible_service_facts_payload_w2496z4s/ansible_service_facts_payload.zip/ansible/modules/service_facts.py\", line 389, in gather_services\r\n  File \"/tmp/ansible_service_facts_payload_w2496z4s/ansible_service_facts_payload.zip/ansible/modules/service_facts.py\", line 376, in get_info\r\nValueError: too many values to unpack (expected 2)\r\n",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 1
}
```


### Code of Conduct

- [X] I agree to follow the Ansible Code of Conduct

This same root cause must be fixed before merging.
REVIEW_EOF

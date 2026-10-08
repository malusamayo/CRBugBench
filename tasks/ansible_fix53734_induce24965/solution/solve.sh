#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/ansible/modules/packaging/language/maven_artifact.py`:

This pull request introduces the defect later reported as "Infinite recursion in `maven_artifact` if `dest` is one-segment non-existent path". The
problem a user observed, and its root cause:

##### SUMMARY
`maven_artifact` has infinite recursion in `split_pre_existing_dir` if only one segment simple one-segment relative path passed to is doesn't exists yet.

##### ISSUE TYPE
- Bug Report

##### COMPONENT NAME
maven_artifact

##### ANSIBLE VERSION
```
ansible 2.7.8
  config file = /home/gross/.ansible.cfg
  configured module search path = ['/home/gross/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.7/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.7.2 (default, Jan 10 2019, 23:51:51) [GCC 8.2.1 20181127]
```

##### CONFIGURATION
```
ANSIBLE_PIPELINING(/home/gross/.ansible.cfg) = True
ANSIBLE_SSH_ARGS(/home/gross/.ansible.cfg) = -o ControlMaster=auto -o ControlPersist=60s -o PreferredAuthentications=publickey
CACHE_PLUGIN(/home/gross/.ansible.cfg) = jsonfile
CACHE_PLUGIN_CONNECTION(/home/gross/.ansible.cfg) = ~/.ansible/facts-cache
CACHE_PLUGIN_TIMEOUT(/home/gross/.ansible.cfg) = 28800
DEFAULT_GATHERING(/home/gross/.ansible.cfg) = smart
DEFAULT_GATHER_SUBSET(/home/gross/.ansible.cfg) = network
DEFAULT_HOST_LIST(/home/gross/.ansible.cfg) = ['/home/gross/repo/ansible-roles/servers-dev']
DEFAULT_KEEP_REMOTE_FILES(env: ANSIBLE_KEEP_REMOTE_FILES) = True
DEFAULT_MODULE_ARGS(/home/gross/.ansible.cfg) = id
DEFAULT_MODULE_NAME(/home/gross/.ansible.cfg) = shell
DEFAULT_REMOTE_USER(/home/gross/.ansible.cfg) = root
DEFAULT_ROLES_PATH(/home/gross/.ansible.cfg) = ['/home/gross/.ansible/roles', '/home/gross/repo/ansible-roles', '/usr/share/ansible/roles', '/etc/ansible/roles']
DEFAULT_VAULT_PASSWORD_FILE(/home/gross/.ansible.cfg) = /home/gross/repo/ansible-roles/.vault-pass
RETRY_FILES_ENABLED(/home/gross/.ansible.cfg) = False
```

##### OS / ENVIRONMENT
Arch Linux, python 3.7.2

##### STEPS TO REPRODUCE
Run `ansible localhost -m maven_artifact -a "group_id=junit artifact_id=junit dest=jars/"`

##### EXPECTED RESULTS
Expected `./jars/junit-latest.jar` file present.

##### ACTUAL RESULTS
Task fails because of infinite recursion.

```
ansible 2.7.8
  config file = /home/gross/.ansible.cfg
  configured module search path = ['/home/gross/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.7/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.7.2 (default, Jan 10 2019, 23:51:51) [GCC 8.2.1 20181127]
Using /home/gross/.ansible.cfg as config file
setting up inventory plugins
/home/gross/repo/ansible-roles/servers-dev did not meet host_list requirements, check plugin documentation if this is unexpected
/home/gross/repo/ansible-roles/servers-dev did not meet script requirements, check plugin documentation if this is unexpected
Parsed /home/gross/repo/ansible-roles/servers-dev inventory source with ini plugin
Loading callback plugin minimal of type stdout, v2.0 from /usr/lib/python3.7/site-packages/ansible/plugins/callback/minimal.py
META: ran handlers
Trying secret FileVaultSecret(filename='/home/gross/repo/ansible-roles/.vault-pass') for vault_id=default
<127.0.0.1> ESTABLISH LOCAL CONNECTION FOR USER: gross
<127.0.0.1> EXEC /bin/sh -c 'echo ~gross && sleep 0'
<127.0.0.1> EXEC /bin/sh -c '( umask 77 && mkdir -p "` echo /home/gross/.ansible/tmp/ansible-tmp-1552432773.254213-46037517912558 `" && echo ansible-tmp-1552432773.254213-46037517912558="` echo /home/gross/.ansible/tmp/ansible-tmp-1552432773.254213-46037517912558 `" ) && sleep 0'                                                                                                                                         
Using module file /usr/lib/python3.7/site-packages/ansible/modules/packaging/language/maven_artifact.py
<127.0.0.1> PUT /home/gross/.ansible/tmp/ansible-local-299683ype32js/tmpcpeq2wgp TO /home/gross/.ansible/tmp/ansible-tmp-1552432773.254213-46037517912558/AnsiballZ_maven_artifact.py                                                                                                 
<127.0.0.1> EXEC /bin/sh -c 'chmod u+x /home/gross/.ansible/tmp/ansible-tmp-1552432773.254213-46037517912558/ /home/gross/.ansible/tmp/ansible-tmp-1552432773.254213-46037517912558/AnsiballZ_maven_artifact.py && sleep 0'                                                           
<127.0.0.1> EXEC /bin/sh -c '/usr/bin/python /home/gross/.ansible/tmp/ansible-tmp-1552432773.254213-46037517912558/AnsiballZ_maven_artifact.py && sleep 0'                                                                                                                            
localhost | FAILED! => {
    "changed": false,
    "module_stderr": "/home/gross/.ansible/tmp/ansible-tmp-1552432773.254213-46037517912558/AnsiballZ_maven_artifact.py:67: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses\n  import imp\nTraceback (most recent call last):\n  File \"/home/gross/.ansible/tmp/ansible-tmp-1552432773.254213-46037517912558/AnsiballZ_maven_artifact.py\", line 261, in <module>\n    _ansiballz_main()\n  File \"/home/gross/.ansible/tmp/ansible-tmp-1552432773.254213-46037517912558/AnsiballZ_maven_artifact.py\", line 251, in _ansiballz_main\n    invoke_module(zipped_mod, temp_path, ANSIBALLZ_PARAMS)\n  File \"/home/gross/.ansible/tmp/ansible-tmp-1552432773.254213-46037517912558/AnsiballZ_maven_artifact.py\", line 119, in invoke_module\n    imp.load_module('__main__', mod, module, MOD_DESC)\n  File \"/usr/lib/python3.7/imp.py\", line 234, in load_module\n    return load_source(name, filename, file)\n  File \"/usr/lib/python3.7/imp.py\", line 169, in load_source\n    module = _exec(spec, sys.modules[name])\n  File \"<frozen importlib._bootstrap>\", line 630, in _exec\n  File \"<frozen importlib._bootstrap_external>\", line 728, in exec_module\n  File \"<frozen importlib._bootstrap>\", line 219, in _call_with_frames_removed\n  File \"/tmp/ansible_maven_artifact_payload_yn1nxte8/__main__.py\", line 552, in <module>\n  File \"/tmp/ansible_maven_artifact_payload_yn1nxte8/__main__.py\", line 507, in main\n  File \"/tmp/ansible_maven_artifact_payload_yn1nxte8/__main__.py\", line 190, in split_pre_existing_dir\n  File \"/tmp/ansible_maven_artifact_payload_yn1nxte8/__main__.py\", line 190, in split_pre_existing_dir\n  File \"/tmp/ansible_maven_artifact_payload_yn1nxte8/__main__.py\", line 190, in split_pre_existing_dir\n  [Previous line repeated 983 more times]\n  File \"/tmp/ansible_maven_artifact_payload_yn1nxte8/__main__.py\", line 187, in split_pre_existing_dir\n  File \"/usr/lib/python3.7/posixpath.py\", line 108, in split\n    sep = _get_sep(p)\n  File \"/usr/lib/python3.7/posixpath.py\", line 42, in _get_sep\n    if isinstance(path, bytes):\nRecursionError: maximum recursion depth exceeded while calling a Python object\n",
    "module_stdout": "",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 1
}
```

This same root cause must be fixed before merging.
REVIEW_EOF

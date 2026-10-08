#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/ansible/plugins/inventory/openstack.py`:

This pull request introduces the defect later reported as "OpenStack dynamic inventory host gets variables from a group to which it does not belongs.". The
problem a user observed, and its root cause:

<!---
Verify first that your issue/request is not already reported on GitHub.
THIS FORM WILL BE READ BY A MACHINE, COMPLETE ALL SECTIONS AS DESCRIBED.
Also test if the latest release, and devel branch are affected too.
ALWAYS add information AFTER (OUTSIDE) these html comments.
Otherwise it may end up being automatically closed by our bot. -->

##### SUMMARY
<!--- Explain the problem briefly -->
During inventory generation by dynamic inventory plugin host gets variables from all groups not only from groups it belongs.

For example I have two openstack instances (FirstServer, SecondServer)

The FirstServer belongs to "linux" group and SecondServer belongs to "windows" group.

group_vars directory have linux.yml and window.yml file for specific variables for groups. 

During ansible-inventory --list (and --export) run I have found that all variables are merged and I have variables from windows group for linux host and visa versa.

The first server have metadata key "groups" with value "stand, linux". The second server have metadata key "groups" with value "stand, windows". So, I have two groups linux and windows.

I have created example project to demonstrate the issue:

https://github.com/ITD27M01/ansible-openstack-bug


The output for "ansible-inventory --list" is: https://github.com/ITD27M01/ansible-openstack-bug/blob/master/openstack-inventory.json#L126
##### ISSUE TYPE
 - Bug Report

##### COMPONENT NAME
<!--- Insert, BELOW THIS COMMENT, the name of the module, plugin, task or feature.
Do not include extra details here, e.g. "vyos_command" not "the network module vyos_command" or the full path-->
`contrib/inventory/openstack_inventory.py`
##### ANSIBLE VERSION
<!--- Paste, BELOW THIS COMMENT, verbatim output from "ansible --version" between quotes below -->
```
ansible 2.5.5
  config file = /Users/igor.tiunov/Sources/ansible-openstack-bug/ansible.cfg
  configured module search path = [u'/Users/igor.tiunov/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python2.7/site-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 2.7.14 (default, Mar  9 2018, 23:57:12) [GCC 4.2.1 Compatible Apple LLVM 9.0.0 (clang-900.0.39.2)]
```

##### CONFIGURATION
<!--- If using Ansible 2.4 or above, paste, BELOW THIS COMMENT, the results of "ansible-config dump --only-changed"
Otherwise, mention any settings you have changed/added/removed in ansible.cfg
(or using the ANSIBLE_* environment variables).-->
```
DEFAULT_HOST_LIST(/Users/igor.tiunov/Sources/ansible-openstack-bug/ansible.cfg) = [u'/Users/igor.tiunov/Sources/ansible-openstack-bug/openstack.yml']
DEFAULT_VAULT_PASSWORD_FILE(env: ANSIBLE_VAULT_PASSWORD_FILE) = /Users/igor.tiunov/tmp/.vault
INVENTORY_ENABLED(/Users/igor.tiunov/Sources/ansible-openstack-bug/ansible.cfg) = ['openstack']
```
##### OS / ENVIRONMENT
<!--- Mention, BELOW THIS COMMENT, the OS you are running Ansible from, and the OS you are
managing, or say "N/A" for anything that is not platform-specific.
Also mention the specific version of what you are trying to control,
e.g. if this is a network bug the version of firmware on the network device.-->
Max OSX and rhel/windows instances on openstack
##### STEPS TO REPRODUCE
<!--- For bugs, show exactly how to reproduce the problem, using a minimal test-case.
For new features, show how the feature would be used. -->

1. Create openstack instances with groups metadata.
2. Create group_vars directory with groups related files and variables,
3. Use openstack inventory plugin for dynamic inventory
4. Read the ansible-inventory --list ouput or ansible-inventory --list --export

<!--- Paste example playbooks or commands between quotes below -->
```yaml
---
- name: Try to ping linux hosts
  hosts: linux
  gather_facts: no
  tasks:
    - ping:
...
```

<!--- You can also paste gist.github.com links for larger files -->

##### EXPECTED RESULTS
<!--- What did you expect to happen when running the steps above? -->
Hosts have variables only from their groups.

##### ACTUAL RESULTS
<!--- What actually happened? If possible run with extra verbosity (-vvvv) -->
Host gets variables from a group to which it does not belong.

This same root cause must be fixed before merging.
REVIEW_EOF

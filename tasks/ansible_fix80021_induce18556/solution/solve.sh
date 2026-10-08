#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `test/lib/ansible_test/_internal/target.py`:

This pull request introduces the defect later reported as "ansible-test network-integration doesn't support network prefixes including underscore". The
problem a user observed, and its root cause:

### Summary

When using ansible-test network-integration command, no matching target is found if the target-prefixes.network file is referencing a target containing an underscore.

### Issue Type

Bug Report

### Component Name

ansible-test

### Ansible Version

```console
ansible --version
ansible [core 2.13.5.post0] (stable-2.13 b44cb7aa99) last updated 2022/10/23 22:23:42 (GMT +200)
  config file = None
  configured module search path = ['/home/warkdev/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/warkdev/ansible/lib/ansible
  ansible collection location = /home/warkdev/.ansible/collections:/usr/share/ansible/collections
  executable location = /home/warkdev/ansible/bin/ansible
  python version = 3.9.2 (default, Feb 28 2021, 17:03:44) [GCC 10.2.1 20210110]
  jinja version = 3.1.2
  libyaml = True
```


### Configuration

```console
# if using a version older than ansible-core 2.12 you should omit the '-t all'
$ ansible-config dump --only-changed -t all
```


### OS / Environment

Linux ansible-dev 5.10.0-19-amd64 #1 SMP Debian 5.10.149-2 (2022-10-21) x86_64 GNU/Linux

### Steps to Reproduce

- Create a simple collection with a very simple integration test case.
- Add a target, as a_b_facts to test the corresponding module.
- Add a dummy network inventory (won't be used).
- Add the following target-prefixes.network file:

```
a_b
```

Try to run the following command:

```
ansible-test network-integration --inventory inventory.networking a_b_.*
```

Notice that the target isn't detected as a network target since the code is expecting only "a" as prefix for a network target.

The suspicious line is located here: https://github.com/ansible/ansible/blob/devel/test/lib/ansible_test/_internal/target.py#L627

### Expected Results

Matching test starting by network prefix a_b should be running

### Actual Results

```console
ansible-test network-integration --inventory inventory.networking a_b_.* -vvv
RLIMIT_NOFILE: (1024, 1048576)
Falling back to tests in "tests/integration/targets/" because "roles/test/" was not found.
FATAL: Target pattern not matched: a_b_.*
```


### Code of Conduct

- [X] I agree to follow the Ansible Code of Conduct

This same root cause must be fixed before merging.
REVIEW_EOF

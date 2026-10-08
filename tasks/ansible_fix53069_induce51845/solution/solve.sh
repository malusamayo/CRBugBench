#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/ansible/modules/network/ios/ios_user.py`:

This pull request introduces the defect later reported as "[Cisco IOS][ios_user] Cannot delete sshkey". The
problem a user observed, and its root cause:

<!--- Verify first that your issue is not already reported on GitHub -->
<!--- Also test if the latest release and devel branch are affected too -->
<!--- Complete *all* sections as described, this form is processed automatically -->

##### SUMMARY
<!--- Explain the problem briefly below -->

After running this task with ansible-playbook, user delete correctly, however the sshkey didn't delete.
```
  - name: remove user
    ios_user:
      name: linnil1
      state: absent
```

##### ISSUE TYPE
- Bug Report

##### COMPONENT NAME
<!--- Write the short name of the module, plugin, task or feature below, use your best guess if unsure -->
ios_user


##### ANSIBLE VERSION
<!--- Paste verbatim output from "ansible --version" between quotes -->
```paste below
ansible 2.8.0.dev0
  config file = /app/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /ansible/lib/ansible
  executable location = /usr/local/bin/ansible
  python version = 3.7.2 (default, Feb  6 2019, 03:40:10) [GCC 6.3.0 20170516]
```

##### CONFIGURATION
<!--- Paste verbatim output from "ansible-config dump --only-changed" between quotes -->
```paste below
```

##### OS / ENVIRONMENT
<!--- Provide all relevant information below, e.g. target OS versions, network device firmware, etc. -->
Docker: python:3.7-slim

##### STEPS TO REPRODUCE
<!--- Describe exactly how to reproduce the problem, using a minimal test-case -->
<!--- Paste example playbooks or commands between quotes below -->

`show run` give me this result, which have three lines.
```
ip ssh pubkey-chain
  username linnil1
   key-hash ssh-rsa 0123 linnil1@intern-lab-1
```
Then, in https://github.com/ansible/ansible/blob/devel/lib/ansible/modules/network/ios/ios_user.py#L360, 
it uses `show run | include username` instead, which only output `  username linnil1` that cause the module don't  know if I have publickey settings. 

Related [issue](https://github.com/ansible/ansible/pull/51845) about the changes of this filter.
```yaml

```

<!--- HINT: You can paste gist.github.com links for larger files -->

##### EXPECTED RESULTS
<!--- Describe what you expected to happen when running the steps above -->
After remove flag in https://github.com/ansible/ansible/blob/devel/lib/ansible/modules/network/ios/ios_user.py#L360, it correctly remove publickey.

##### ACTUAL RESULTS
<!--- Describe what actually happened. If possible run with extra verbosity (-vvvv) -->

<!--- Paste verbatim command output between quotes -->
```paste below

```

This same root cause must be fixed before merging.
REVIEW_EOF

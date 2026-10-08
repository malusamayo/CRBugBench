#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/ansible/module_utils/facts/system/pkg_mgr.py`:

This pull request introduces the defect later reported as "Ansible 2.8.0 failing to install yum packages on Amazon Linux". The
problem a user observed, and its root cause:

<!--- Verify first that your issue is not already reported on GitHub -->
<!--- Also test if the latest release and devel branch are affected too -->
<!--- Complete *all* sections as described, this form is processed automatically -->

##### SUMMARY
We've been using Ansible 2.7.x to setup our AWS EC2 instances for the past several years, but this morning the process broke when Ansible 2.8.0 was released.  It appears as if it is trying to use dfn to install yum packages.

##### ISSUE TYPE
- Bug Report

##### COMPONENT NAME
<!--- Write the short name of the module, plugin, task or feature below, use your best guess if unsure -->
module_utils/basic.py

##### ANSIBLE VERSION
<!--- Paste verbatim output from "ansible --version" between quotes -->
```paste below
ansible 2.8.0
  config file = /opt/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python2.7/site-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 2.7.16 (default, Mar 18 2019, 18:38:44) [GCC 4.8.5 20150623 (Red Hat 4.8.5-28)]
```

##### CONFIGURATION
<!--- Paste verbatim output from "ansible-config dump --only-changed" between quotes -->
```paste below
DEFAULT_HOST_LIST(/opt/ansible/ansible.cfg) = [u'/opt/ansible/inventory']
DEFAULT_LOG_PATH(/opt/ansible/ansible.cfg) = /var/log/ansible.log
```

##### OS / ENVIRONMENT
<!--- Provide all relevant information below, e.g. target OS versions, network device firmware, etc. -->
- **AWS EC2 Instance Type:** t3.medium
- **uname:** Linux ip-10-203-36-86 4.14.109-80.92.amzn1.x86_64 #1 SMP Mon Apr 1 23:07:39 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

##### STEPS TO REPRODUCE
<!--- Describe exactly how to reproduce the problem, using a minimal test-case -->
1. install the latest Ansible (v2.8.0) from pip: `/usr/local/bin/pip install ansible`
1. execute the playbook below: `/usr/local/bin/ansible-playbook /opt/ansible/playbook.yml`
1. notice that it fails to install with a "dnf install -y python2-dnf" command instead of the expected "yum install" command

<!--- Paste example playbooks or commands between quotes below -->
```yaml
---
- hosts: localhost
  connection: local

  tasks:
    - name: install package
      yum:
        name: htop
        state: present
```
<!--- HINT: You can paste gist.github.com links for larger files -->

##### EXPECTED RESULTS
<!--- Describe what you expected to happen when running the steps above -->
I expected that my package would be installed, as it was with previous versions of Ansible.

##### ACTUAL RESULTS
<!--- Describe what actually happened. If possible run with extra verbosity (-vvvv) -->

<!--- Paste verbatim command output between quotes -->
```paste below
# /usr/local/bin/ansible-playbook /opt/ansible/playbook.yml -vvv
ansible-playbook 2.8.0
  config file = /opt/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python2.7/site-packages/ansible
  executable location = /usr/local/bin/ansible-playbook
  python version = 2.7.16 (default, Mar 18 2019, 18:38:44) [GCC 4.8.5 20150623 (Red Hat 4.8.5-28)]
Using /opt/ansible/ansible.cfg as config file
host_list declined parsing /opt/ansible/inventory as it did not pass it's verify_file() method
script declined parsing /opt/ansible/inventory as it did not pass it's verify_file() method
auto declined parsing /opt/ansible/inventory as it did not pass it's verify_file() method
Parsed /opt/ansible/inventory inventory source with ini plugin

PLAYBOOK: playbook.yml ********************************************************************************************************************************************************************************************
1 plays in /opt/ansible/playbook.yml

PLAY [localhost] **************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
task path: /opt/ansible/playbook.yml:2
<localhost> ESTABLISH LOCAL CONNECTION FOR USER: root
<localhost> EXEC /bin/sh -c 'echo ~root && sleep 0'
<localhost> EXEC /bin/sh -c '( umask 77 && mkdir -p "` echo /root/.ansible/tmp/ansible-tmp-1558101989.07-38174213049053 `" && echo ansible-tmp-1558101989.07-38174213049053="` echo /root/.ansible/tmp/ansible-tmp-1558101989.07-38174213049053 `" ) && sleep 0'
<localhost> Attempting python interpreter discovery
<localhost> EXEC /bin/sh -c 'echo PLATFORM; uname; echo FOUND; command -v '"'"'/usr/bin/python'"'"'; command -v '"'"'python3.7'"'"'; command -v '"'"'python3.6'"'"'; command -v '"'"'python3.5'"'"'; command -v '"'"'python2.7'"'"'; command -v '"'"'python2.6'"'"'; command -v '"'"'/usr/libexec/platform-python'"'"'; command -v '"'"'/usr/bin/python3'"'"'; command -v '"'"'python'"'"'; echo ENDFOUND && sleep 0'
<localhost> EXEC /bin/sh -c '/usr/bin/python && sleep 0'
<localhost> Python interpreter discovery fallback (unsupported Linux distribution: amzn)
Using module file /usr/local/lib/python2.7/site-packages/ansible/modules/system/setup.py
<localhost> PUT /root/.ansible/tmp/ansible-local-18472gFieVf/tmpi2E4PK TO /root/.ansible/tmp/ansible-tmp-1558101989.07-38174213049053/AnsiballZ_setup.py
<localhost> EXEC /bin/sh -c 'chmod u+x /root/.ansible/tmp/ansible-tmp-1558101989.07-38174213049053/ /root/.ansible/tmp/ansible-tmp-1558101989.07-38174213049053/AnsiballZ_setup.py && sleep 0'
<localhost> EXEC /bin/sh -c '/usr/bin/python /root/.ansible/tmp/ansible-tmp-1558101989.07-38174213049053/AnsiballZ_setup.py && sleep 0'
ok: [localhost] => {
    "ansible_facts": {
        "ansible_all_ipv4_addresses": [
            "10.203.36.86"
        ],
        "ansible_all_ipv6_addresses": [
            "fe80::83f:64ff:fefc:83e0"
        ],
        "ansible_apparmor": {
            "status": "disabled"
        },
        "ansible_architecture": "x86_64",
        "ansible_bios_date": "10/16/2017",
        "ansible_bios_version": "1.0",
        "ansible_cmdline": {
            "KEYTABLE": "us",
            "LANG": "en_US.UTF-8",
            "console": "ttyS0",
            "nvme_core.io_timeout": "4294967295",
            "root": "LABEL=/",
            "selinux": "0"
        },
        "ansible_date_time": {
            "date": "2019-05-17",
            "day": "17",
            "epoch": "1558101989",
            "hour": "14",
            "iso8601": "2019-05-17T14:06:29Z",
            "iso8601_basic": "20190517T140629875936",
            "iso8601_basic_short": "20190517T140629",
            "iso8601_micro": "2019-05-17T14:06:29.876004Z",
            "minute": "06",
            "month": "05",
            "second": "29",
            "time": "14:06:29",
            "tz": "UTC",
            "tz_offset": "+0000",
            "weekday": "Friday",
            "weekday_number": "5",
            "weeknumber": "19",
            "year": "2019"
        },
        "ansible_default_ipv4": {
            "address": "10.203.36.86",
            "alias": "eth0",
            "broadcast": "10.203.47.255",
            "gateway": "10.203.32.1",
            "interface": "eth0",
            "macaddress": "0a:3f:64:fc:83:e0",
            "mtu": 9001,
            "netmask": "255.255.240.0",
            "network": "10.203.32.0",
            "type": "ether"
        },
        "ansible_default_ipv6": {},
        "ansible_device_links": {
            "ids": {
                "nvme0n1": [
                    "nvme-Amazon_Elastic_Block_Store_vol07c32b36c3def793e-ns-1"


This same root cause must be fixed before merging.
REVIEW_EOF

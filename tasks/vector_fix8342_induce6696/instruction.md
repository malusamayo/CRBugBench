# Code Review Task

You are a maintainer reviewing a pull request to the `vectordotdev/vector` repository.

**PR title:** enhancement(security): Harden SystemD service (#6696)

**PR description / commit message:**

enhancement(security): Harden SystemD service (#6696)

* enhancement(security): Harden SystemD service

This takes a first pass at hardening the service file we ship with Vector.
Depending on a user's need, they could harden it further by, for example,
disabling network binding if they aren't using a source that requires it or the
file system if they don't need to use a component that needs to read or write
to it.  My aim here was to provide a broad enough set that it should cover any
vector configuration.

Output of `systemd-analyze security vector`:

```
root@72314b979f5b:/# systemd-analyze security vector
  NAME                                                        DESCRIPTION                                                                   EXPOSURE
- PrivateNetwork=                                             Service has access to the host's network                                           0.5
+ User=/DynamicUser=                                          Service runs under a static non-root user identity
+ CapabilityBoundingSet=~CAP_SET(UID|GID|PCAP)                Service cannot change UID/GID identities/capabilities
+ CapabilityBoundingSet=~CAP_SYS_ADMIN                        Service has no administrator privileges
+ CapabilityBoundingSet=~CAP_SYS_PTRACE                       Service has no ptrace() debugging abilities
- RestrictAddressFamilies=~AF_(INET|INET6)                    Service may allocate Internet sockets                                              0.3
+ RestrictNamespaces=~CLONE_NEWUSER                           Service cannot create user namespaces
+ RestrictAddressFamilies=~…                                  Service cannot allocate exotic sockets
+ CapabilityBoundingSet=~CAP_(CHOWN|FSETID|SETFCAP)           Service cannot change file ownership/access mode/capabilities
+ CapabilityBoundingSet=~CAP_(DAC_*|FOWNER|IPC_OWNER)         Service cannot override UNIX file/IPC permission checks
+ CapabilityBoundingSet=~CAP_NET_ADMIN                        Service has no network configuration privileges
+ CapabilityBoundingSet=~CAP_RAWIO                            Service has no raw I/O access
+ CapabilityBoundingSet=~CAP_SYS_MODULE                       Service cannot load kernel modules
+ CapabilityBoundingSet=~CAP_SYS_TIME                         Service processes cannot change the system clock
+ DeviceAllow=                                                Service has a minimal device ACL
- IPAddressDeny=                                              Service does not define an IP address whitelist                                    0.2
+ KeyringMode=                                                Service doesn't share key material with other services
+ NoNewPrivileges=                                            Service processes cannot acquire new privileges
+ NotifyAccess=                                               Service child processes cannot alter service state
+ PrivateDevices=                                             Service has no access to hardware devices
+ PrivateMounts=                                              Service cannot install system mounts
+ PrivateTmp=                                                 Service has no access to other software's temporary files
- PrivateUsers=                                               Service has access to other users                                                  0.2
+ ProtectControlGroups=                                       Service cannot modify the control group file system
+ ProtectHome=                                                Service has no access to home directories
+ ProtectKernelModules=                                       Service cannot load or read kernel modules
+ ProtectKernelTunables=                                      Service cannot alter kernel tunables (/proc/sys, …)
+ ProtectSystem=                                              Service has strict read-only access to the OS file hierarchy
+ RestrictAddressFamilies=~AF_PACKET                          Service cannot allocate packet sockets
+ SystemCallArchitectures=                                    Service may execute system calls only with native ABI
+ SystemCallFilter=~@clock                                    System call whitelist defined for service, and @clock is not included
- SystemCallFilter=~@debug                                    System call whitelist defined for service, and @debug is included                  0.2
+ SystemCallFilter=~@module                                   System call whitelist defined for service, and @module is not included
+ SystemCallFilter=~@mount                                    System call whitelist defined for service, and @mount is not included
+ SystemCallFilter=~@raw-io                                   System call whitelist defined for service, and @raw-io is not included
+ SystemCallFilter=~@reboot                                   System call whitelist defined for service, and @reboot is not included
+ SystemCallFilter=~@swap                                     System call whitelist defined for service, and @swap is not included
+ SystemCallFilter=~@privileged                               System call whitelist defined for service, and @privileged is not included
+ SystemCallFilter=~@resources                                System call whitelist defined for service, and @resources is not included
- AmbientCapabilities=                                        Service process receives ambient capabilities                                      0.1
+ CapabilityBoundingSet=~CAP_AUDIT_*                          Service has no audit subsystem access
+ CapabilityBoundingSet=~CAP_KILL                             Service cannot send UNIX signals to arbitrary processes
+ CapabilityBoundingSet=~CAP_MKNOD                            Service cannot create device nodes
- CapabilityBoundingSet=~CAP_NET_(BIND_SERVICE|BROADCAST|RAW) Service has elevated networking privileges                                         0.1
+ CapabilityBoundingSet=~CAP_SYSLOG                           Service has no access to kernel logging
+ CapabilityBoundingSet=~CAP_SYS_(NICE|RESOURCE)              Service has no privileges to change resource use parameters
+ RestrictNamespaces=~CLONE_NEWCGROUP                         Service cannot create cgroup namespaces
+ RestrictNamespaces=~CLONE_NEWIPC                            Service cannot create IPC namespaces
+ RestrictNamespaces=~CLONE_NEWNET                            Service cannot create network namespaces
+ RestrictNamespaces=~CLONE_NEWNS                             Service cannot create file system namespaces
+ RestrictNamespaces=~CLONE_NEWPID                            Service cannot create process namespaces
+ RestrictRealtime=                                           Service realtime scheduling access is restricted
+ SystemCallFilter=~@cpu-emulation                            System call whitelist defined for service, and @cpu-emulation is not included
+ SystemCallFilter=~@obsolete                                 System call whitelist defined for service, and @obsolete is not included
+ RestrictAddressFamilies=~AF_NETLINK                         Service cannot allocate netlink sockets
- RootDirectory=/RootImage=                                   Service runs within the host's root directory                                      0.1
+ SupplementaryGroups=                                        Service has no supplementary groups
+ CapabilityBoundingSet=~CAP_MAC_*                            Service cannot adjust SMACK MAC
+ CapabilityBoundingSet=~CAP_SYS_BOOT                         Service cannot issue reboot()
+ Delegate=                                                   Service does not maintain its own delegated control group subtree
+ LockPersonality=                                            Service cannot change ABI personality
+ MemoryDenyWriteExecute=                                     Service cannot create writable executable memory mappings
+ RemoveIPC=                                                  Service user cannot leave SysV IPC objects around
+ RestrictNamespaces=~CLONE_NEWUTS                            Service cannot create hostname namespaces
+ UMask=                                                      Files created by service are accessible only by service's own user by default
+ CapabilityBoundingSet=~CAP_LINUX_IMMUTABLE                  Service cannot mark files immutable
+ CapabilityBoundingSet=~CAP_IPC_LOCK                         Service cannot lock memory into RAM
+ CapabilityBoundingSet=~CAP_SYS_CHROOT                       Service cannot issue chroot()
+ CapabilityBoundingSet=~CAP_BLOCK_SUSPEND                    Service cannot establish wake locks
+ CapabilityBoundingSet=~CAP_LEASE                            Service cannot create file leases
+ CapabilityBoundingSet=~CAP_SYS_PACCT                        Service cannot use acct()
+ CapabilityBoundingSet=~CAP_SYS_TTY_CONFIG                   Service cannot issue vhangup()
+ CapabilityBoundingSet=~CAP_WAKE_ALARM                       Service cannot program timers that wake up the system
- RestrictAddressFamilies=~AF_UNIX                            Service may allocate local sockets                                                 0.1
```

Signed-off-by: Jesse Szwedko <jesse@szwedko.me>

* Swap out specific groups with @system-service

Signed-off-by: Jesse Szwedko <jesse@szwedko.me>

## Working environment

The repository is checked out at `/app/vector` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.

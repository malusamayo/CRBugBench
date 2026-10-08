#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/uu/install/src/install.rs`:

This pull request introduces the defect later reported as "Other users can access and write to files as `install` copies them.". The
problem a user observed, and its root cause:

Here are the steps to reproduce.

First create a file only accessible by the current user:
```
$ install -m 700 /dev/null file
$ echo hello > file
$ stat --format=%A file
-rwx------
```

Then install it somewhere with the same mode:
```
$ strace -e trace=file,read,write,ioctl,copy_file_range,splice uu-install -m 700 file /tmp
[...]
openat(AT_FDCWD, "file", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/tmp/file", O_WRONLY|O_CREAT|O_EXCL|O_CLOEXEC, 0666) = 4
splice(3, NULL, 6, NULL, 131072, 0)     = 6
splice(5, NULL, 4, NULL, 6, 0)          = 6
splice(3, NULL, 6, NULL, 131072, 0)     = 0
chmod("/tmp/file", 0700)                = 0
```

Depending on the umask, other users will be able to read and/or write to the file until it is finished copying and `chmod` is called.

If the process is interrupted and/or `chmod` fails, then the file will be installed with permissions that allow others to read and/or write to the file. Here is an example:

```
$ umask 0
$ truncate -s 5G input
$ timeout 1 uu-install -m 700 input /tmp
$ stat --format=%A /tmp/input
-rw-rw-rw-
$ rm /tmp/input
$ timeout 1 install -m 700 input /tmp
$ stat --format=%A /tmp/input
-rw-------
```

This same root cause must be fixed before merging.
REVIEW_EOF

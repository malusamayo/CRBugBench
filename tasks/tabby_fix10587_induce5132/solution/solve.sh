#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `tabby-terminal/src/features/zmodem.ts`:

This pull request introduces the defect later reported as "ubuntu 24.04 Zmodem receive file error and corrupt". The
problem a user observed, and its root cause:

client: ubuntu 24.04
server: centos 7.9

when i receive file form server,found error at 100% progress,and fie corrupt

```
sz mongodb-org-server_4.4.17_amd64.deb
 ZMODEM  Session started            
------------------------            
 Received  mongodb-org-server_4.4.17_amd64.deb            
 Error  PROTOCOL: Only thing after ZFIN should be “OO” (79,79), not: 27,91,51,55,59,52,48,109,91,27,91,51,50,59,52,48,109,114,111,111,116,27,91,51,55,59,52,48,109,64,104,107,48,48,49,32,27,91,51,53,59,52,48,109,126,27,91,48,109,93,35,32 

sudo dpkg -i mongodb-org-server_4.4.17_amd64.deb
Selecting previously unselected package mongodb-org-server.
(Reading database ... 192480 files and directories currently installed.)
Preparing to unpack mongodb-org-server_4.4.17_amd64.deb ...
Unpacking mongodb-org-server (4.4.17) ...
dpkg-deb (subprocess): decompressing archive 'mongodb-org-server_4.4.17_amd64.deb' (size=20754624) member 'data.tar': lzma error: compressed data is corrupt
dpkg-deb: error: <decompress> subprocess returned error exit status 2
dpkg: error processing archive mongodb-org-server_4.4.17_amd64.deb (--install):
 cannot copy extracted data for './usr/bin/mongod' to '/usr/bin/mongod.dpkg-new': unexpected end of file or stream
```

This same root cause must be fixed before merging.
REVIEW_EOF

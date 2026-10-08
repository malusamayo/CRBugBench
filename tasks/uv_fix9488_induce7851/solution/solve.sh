#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/uv-settings/src/lib.rs`:

This pull request introduces the defect later reported as "Global config file ignored on Windows". The
problem a user observed, and its root cause:

<!--
Thank you for taking the time to report an issue! We're glad to have you involved with uv.

If you're filing a bug report, please consider including the following information:

* A minimal code snippet that reproduces the bug.
* The command you invoked (e.g., `uv pip sync requirements.txt`), ideally including the `--verbose` flag.
* The current uv platform.
* The current uv version (`uv --version`).
-->

UV does not read the configuration file in `%SYSTEMDRIVE%\ProgramData\uv\uv.toml` unless the working directory happens to be `%SYSTEMDRIVE%\`.

### Root Cause

- The `SYSTEMDRIVE` environment variable consists only of a drive letter followed by a colon. There is no trailing backslash. E.g. `C:` `D:`
- The final path is assembled by UV as follows: 
  ```rust
  let candidate = PathBuf::from(system_drive).join("ProgramData\\uv\\uv.toml");
  ```
- `candidate` now contains a path like this: `C:ProgramData\uv\uv.toml`
- Since there is no backslash between `C:` and `ProgramData`, this path is [specified](https://learn.microsoft.com/en-us/dotnet/standard/io/file-path-formats) to be 
  > A *relative* path from the current directory of the C: drive.

  rather than an absolute path. UV thus only recognizes the config file if the CWD is the root of the system drive.
- Inserting the missing backslash resolves the problem

### Steps to reproduce:

1. Create file `%SYSTEMDRIVE%\ProgramData\uv\uv.toml`. For demonstration purposes, insert an invalid option 

```toml
doesnotexist = true
```

2. Run UV from the drive root to observe parse error (as expected)

```cmd
cd %SYSTEMDRIVE%\
uv cache prune
```
`error: Failed to parse: C:ProgramData\uv\uv.toml`

3. Run UV from any other directory on the same drive. Observe that no parse error was thrown since the global config file was not loaded at all (bug)

```cmd
cd %SYSTEMDRIVE%\Users
uv cache prune
```
`Pruning cache at ...`

### Note

Be aware that windows keeps track of working directories _per system drive_. Changing to another drive such as `D:/foo` might not reproduce the bug

### Version Information

* UV version 0.5.4

This same root cause must be fixed before merging.
REVIEW_EOF

# Code Review Task

You are a maintainer reviewing a pull request to the `rustdesk/rustdesk` repository.

**PR title:** feat(macos): initial privacy mode support [a simple try]

**PR description:**

## Summary
Add privacy mode functionality for macOS platform, allowing remote desktop sessions to hide the screen content from local users.

**Note to Reviewers:** As an amateur developer, this is my initial and minimal viable implementation (a simple try) to address the missing privacy mode on macOS. 

## Changes

### Core Implementation (src/platform/macos.mm)
- Implement screen blackout using CGDisplayGammaTable API
- Implement input blocking using CGEventTap to intercept keyboard/mouse
- Store and restore original gamma values for proper cleanup

### Privacy Mode Integration (src/privacy_mode.rs, src/privacy_mode/macos.rs)
- Add macOS privacy mode implementation with PrivacyMode trait
- Register macOS privacy mode in PRIVACY_MODE_CREATOR
- Set DEFAULT_PRIVACY_MODE_IMPL for macOS platform
- Implement get_supported_privacy_mode_impl() for macOS

### Connection Handling (src/server/connection.rs)
- Add supported_privacy_mode_impl to platform_additions for macOS
- Enable privacy mode toggle in client UI when connecting via LAN IP

### Localization (src/lang/*.rs)
- Add "privacy_mode_impl_macos_tip" translation for en/cn/tw

## Safety & Security
- Implements Drop trait to ensure cleanup on normal exit
- macOS system automatically restores gamma table on process termination
- CGEventTap is automatically released when process terminates
- Tested with SIGKILL to verify crash recovery

## Testing
- Verified privacy mode toggle works via both ID and LAN IP connection
- Verified screen recovery after process crash (kill -9)
- Verified input restoration after process termination

### Environment
* **OS**: macOS 26.2
* **Hardware**: MacBook Pro (Apple Silicon)
* **Monitors Verified**:
    * Internal Liquid Retina display
    * Apple Studio Display
    * Additional external monitor

## Working environment

The repository is checked out at `/app/rustdesk` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.

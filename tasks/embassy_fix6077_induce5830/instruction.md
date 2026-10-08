# Code Review Task

You are a maintainer reviewing a pull request to the `embassy-rs/embassy` repository.

**PR title:** fix(nrf): fix GRTC time driver for nRF54L/LM series

**PR description / commit message:**

fix(nrf): fix GRTC time driver for nRF54L/LM series

- Use per-domain SYSCOUNTER/interrupt registers indexed by DOMAIN_IDX
  instead of hardcoded 0 (FLPR domain) and 1 (NS domain).  On the
  secure app core (nrf54lm20-app-s), SYSCOUNTER, INTENSET/INTENCLR,
  and the GRTC interrupt are all domain 2 (GRTC_2).
- Configure TIMEOUT and WAKETIME registers for the GRTC sleep/wake
  mechanism.  Per the product spec, TIMEOUT > WAKETIME + guard_time
  (min 1 LFCLK cycle) is required.  Set TIMEOUT=5, WAKETIME=4.
- Set MODE.AUTOEN = CPU_ACTIVE to keep the SYSCOUNTER running while
  any local CPU is active.
- Clear stale EVENTS_COMPARE before writing CC in set_alarm.

Signed-off-by: Haobo Gu <haobogu@outlook.com>

## Working environment

The repository is checked out at `/app/embassy` at this PR's **base commit**
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

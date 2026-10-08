# Code Review Task

You are a maintainer reviewing a pull request to the `uutils/coreutils` repository.

**PR title:** sort: immediately compare whole lines if they parse as numbers

**PR description / commit message:**

sort: immediately compare whole lines if they parse as numbers

 Numeric sort can be relatively slow on inputs that are wholly or
 mostly numbers. This is more clear when comparing with the speed of
 GeneralNumeric.

 This change parses whole lines as f64 and stores that info in
 `LineData`. This is faster than doing the parsing two lines at
 a time in `compare_by()`.

 # Benchmarks

 `shuf -i 1-1000000 -n 1000000 > /tmp/shuffled.txt`

 % hyperfine --warmup 3 \
     '/tmp/gnu-sort -n /tmp/shuffled.txt'
     '/tmp/before_coreutils sort -n /tmp/shuffled.txt'
     '/tmp/after_coreutils sort -n /tmp/shuffled.txt'
 Benchmark 1: /tmp/gnu-sort -n /tmp/shuffled.txt
   Time (mean ± σ):     198.2 ms ±   5.8 ms    [User: 884.6 ms, System: 22.0 ms]
   Range (min … max):   187.3 ms … 207.4 ms    15 runs

 Benchmark 2: /tmp/before_coreutils sort -n /tmp/shuffled.txt
   Time (mean ± σ):     361.3 ms ±   8.7 ms    [User: 1898.7 ms, System: 18.9 ms]
   Range (min … max):   350.4 ms … 375.3 ms    10 runs

 Benchmark 3: /tmp/after_coreutils sort -n /tmp/shuffled.txt
   Time (mean ± σ):     175.1 ms ±   6.7 ms    [User: 536.8 ms, System: 21.6 ms]
   Range (min … max):   169.3 ms … 197.0 ms    16 runs

 Summary
   /tmp/after_coreutils sort -n /tmp/shuffled.txt ran
     1.13 ± 0.05 times faster than /tmp/gnu-sort -n /tmp/shuffled.txt
     2.06 ± 0.09 times faster than /tmp/before_coreutils sort -n /tmp/shuffled.txt

Signed-off-by: Mohammad AlSaleh <CE.Mohammad.AlSaleh@gmail.com>

## Working environment

The repository is checked out at `/app/coreutils` at this PR's **base commit**
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

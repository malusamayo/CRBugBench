#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/uu/sort/src/sort.rs`:

This pull request introduces the defect later reported as "sort: numeric sort (-n) incorrectly parses '+' as a number sign". The
problem a user observed, and its root cause:

# sort: numeric sort (-n) incorrectly parses '+' as a number sign

## Component

sort

## Description

When using numeric sort (`-n`), uutils incorrectly recognizes the `+` sign as part of a number. This causes `+1`, `+2`, `+10` to be sorted numerically instead of lexicographically.

In [uutils sort](https://github.com/uutils/coreutils/blob/3a07ffc5a9bd4c283e75afa548ba1f1957bad242/src/uu/sort/src/sort.rs#L476-L482), the numeric comparison uses `f64::parse()`.

```rust
if settings.mode == SortMode::Numeric {
    // ...
    line_num_float = s.parse::<f64>().ok()
    // ...
}
```

Rust's `parse::<f64>()` accepts both `+` and `-` as valid number signs, so `+1` is parsed as `1.0` and sorted numerically.

However, according to the [GNU sort documentation](https://www.gnu.org/software/coreutils/manual/html_node/sort-invocation.html):

> Neither a leading '+' nor exponential notation is recognized. To compare such strings numerically, use the --general-numeric-sort (-g) option.

In [GNU sort](https://github.com/coreutils/coreutils/blob/9a1bd362d287f4e744c46fcb3be3b2b3ad1fe3f9/gl/lib/strnumcmp-in.h#L28), only `-` is defined as a negation sign:

```c
#define NEGATION_SIGN   '-'
```

The `numcompare` function only checks for `NEGATION_SIGN` when parsing numeric strings, so `+1` is treated as a non-numeric string and sorted lexicographically.

## Test / Reproduction Steps

```bash
# GNU sort - lexicographical order ('+' not recognized as number)
$ printf '+1\n+10\n+2\n' | sort -n
+1
+10
+2

# uutils sort - numerical order ('+' incorrectly recognized)
$ printf '+1\n+10\n+2\n' | coreutils sort -n
+1
+2
+10
```

## Impact

Numeric sort output differs from GNU sort when input contains numbers with leading `+` signs.

## Recommendations

Modify `NumInfo::parse` to not recognize `+` as a valid sign character for `-n` mode, matching GNU behavior.

This same root cause must be fixed before merging.
REVIEW_EOF

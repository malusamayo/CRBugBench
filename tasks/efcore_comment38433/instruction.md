# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/efcore` repository.

**PR title:** Honor explicit store type when discovering Dictionary<string,object>

**PR description:**

Fixes ##26903

Most of the changes here are due to making pubternal types public so then can be used by providers.

- `Dictionary<string,object>` with an explicit column type (e.g. `[Column(TypeName="jsonb")]`) was detected as a property bag, throwing the "shared-type entity type" error.
- Root cause: the member classifier treats any type with no type mapping as a navigation to a property-bag entity type; `Dictionary<string,object>` has no mapping, `Dictionary<string,string>` does.
- Fix: RelationalMemberClassifier honors an explicit `[Column(TypeName)]` so the member is discovered as a scalar property instead of a property bag.
- Providers that map the type (e.g. Npgsql -> jsonb) now work; others report the clear "cannot be mapped, use a value converter" error.
- IMemberClassifier, MemberClassifier and RelationalMemberClassifier are now public (moved out of *.Internal) so providers don't have to depend on internal code.

Promotes IMemberClassifier/MemberClassifier from Microsoft.EntityFrameworkCore.Metadata.Internal to Microsoft.EntityFrameworkCore.Metadata, with a new public MemberClassifierDependencies parameter object (following the standard EF service-dependencies pattern) and real public XML docs. RelationalMemberClassifier moves to the same public namespace, dropping the EF1001 suppressions that were only needed while the base type was internal.

Scope is the core property-bag misdetection plus the API publicization; producing a JSON mapping for Dictionary<string,object> remains the provider's responsibility.

Tests in RelationalModelValidatorTest (inherited by SqlServerModelValidatorTest) cover: the member becoming a scalar property (not a navigation) with the column type set; full validation reporting the clear PropertyNotMapped error; the value-converter end-to-end path; and that a [Column] with only a name (no TypeName) is still a property bag. Public API baselines regenerated.

## Working environment

The repository is checked out at `/app/efcore` at this PR's **base commit**
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

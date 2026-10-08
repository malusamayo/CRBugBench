# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/efcore` repository.

**PR title:** Add runtime migration creation and application

**PR description:**

## Summary

Implements #37342: Allow creating and applying migrations at runtime without recompiling.

This adds support for creating and applying migrations at runtime using Roslyn compilation, enabling scenarios like .NET Aspire and containerized applications where recompilation isn't possible.

### CLI Usage

```bash
# Standard update (existing behavior)
dotnet ef database update [migration]

# Create and apply a new migration in one step
dotnet ef database update MigrationName --add [--output-dir <DIR>] [--namespace <NS>] [--json]
```

The `-o/--output-dir`, `-n/--namespace`, and `--json` options require `--add` to be specified.

### PowerShell Usage

```powershell
# Standard update (existing behavior)
Update-Database [-Migration <migration>]

# Create and apply a new migration in one step
Update-Database -Migration MigrationName -Add [-OutputDir <DIR>] [-Namespace <NS>]
```

### Architecture

| Component | Purpose |
|-----------|---------|
| `IMigrationCompiler` / `CSharpMigrationCompiler` | Internal: Roslyn-based compilation of scaffolded migrations |
| `IMigrationsAssembly.AddMigrations(Assembly)` | Registers dynamically compiled migrations |
| `MigrationsOperations.AddAndApplyMigration()` | Orchestrates scaffold → compile → register → apply workflow |

### Design Decisions

- **Extends existing services**: Uses `IMigrationsScaffolder` for scaffolding and `IMigrator` for applying, adding only the new `IMigrationCompiler` service
- **AddMigrations(Assembly)**: Extended `IMigrationsAssembly` interface to accept additional assemblies containing runtime-compiled migrations
- **Always persists to disk**: Like `AddMigration`, files are always saved to enable source control and future recompilation
- **No pending changes behavior**: If no model changes are detected, applies any existing pending migrations without creating a new one
- **Internal compiler API**: `IMigrationCompiler` and `CSharpMigrationCompiler` are in the `.Internal` namespace as they require design work for public API
- **Error handling with cleanup**: If compilation or migration application fails, saved migration files are cleaned up to prevent orphans
- **Thread safety**: `MigrationsAssembly` uses locking to protect against race conditions when adding migrations concurrently

### Workflow

```
User runs: dotnet ef database update InitialCreate --add
    │
    ▼
MigrationsOperations.AddAndApplyMigration()
    │
    ├─► Check for pending model changes
    │       └─► If none: apply existing migrations, return
    │
    ├─► IMigrationsScaffolder.ScaffoldMigration() - Generate code
    │
    ├─► try {
    │       ├─► IMigrationsScaffolder.Save() - Write files to disk
    │       ├─► IMigrationCompiler.CompileMigration() - Roslyn compile
    │       ├─► IMigrationsAssembly.AddMigrations() - Register migration
    │       └─► IMigrator.Migrate() - Apply to database
    │   } catch {
    │       └─► Clean up saved files on failure
    │   }
    │
    └─► Return migration files
```

### Robustness Features

1. **Exception handling with cleanup**: `AddAndApplyMigration` wraps the save-compile-register-apply chain in try-catch, deleting saved files on failure to prevent orphans
2. **Context disposal on validation failure**: `PrepareForMigration` ensures the DbContext is disposed if validation or service building fails
3. **Thread-safe migration registration**: `MigrationsAssembly` uses locking to protect shared state (migrations dictionary, model snapshot, additional assemblies list)

### Limitations

- Requires dynamic code generation (incompatible with NativeAOT) - marked with `[RequiresDynamicCode]`
- C# only (no VB.NET/F# support)

## Test plan

- [x] Unit tests for `CSharpMigrationCompiler`
- [x] Unit tests for `MigrationsOperations.AddAndApplyMigration`
- [x] Integration tests in `RuntimeMigrationTestBase` (SQLite and SQL Server implementations)
- [x] Tests for validation (empty name, invalid characters)
- [x] Tests for RemoveMigration with dynamically created migrations
- [x] All existing EFCore.Design.Tests pass
- [x] All existing EFCore.Relational.Tests pass

Fixes #37342

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

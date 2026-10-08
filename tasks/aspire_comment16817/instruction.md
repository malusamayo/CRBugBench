# Code Review Task

You are a maintainer reviewing a pull request to the `microsoft/aspire` repository.

**PR title:** feat(cli): co-locate bundle with CLI binary for packager-managed installs

**PR description:**

## The change

This PR introduces two on-disk layout modes for the CLI + bundle, selected by the `.aspire-install.json` sidecar's `source` field.

- **Sibling layout** — for `dotnet-tool` / `winget` / `brew`. CLI binary and bundle (`versions/<id>/`) live as siblings inside the same packager-owned directory. This is the new shape packager-managed installs needed.
- **Script layout** — for `script` / `pr`. CLI binary lives in `bin/`, bundle lives in the parent of `bin/`. Same as today; no behavior change for these routes.

Before this PR, `BundleService.ComputeDefaultExtractDir` always placed the extracted bundle in the **parent** of the binary's directory. That works for script layout — the binary at `<prefix>/bin/aspire` lands the bundle at `<prefix>/versions/<id>/`.

For packager-managed routes (`winget`, `brew`, `dotnet-tool`) the binary sits directly in the packager-owned directory, not under a `bin/` sub-folder. Parent-of-binary means the bundle leaks **outside** that directory — uninstalling or upgrading the package leaves orphaned bundle files behind.

`BundleService.ComputeDefaultExtractDir` now reads the `.aspire-install.json` sidecar and, for `winget`/`brew`/`dotnet-tool`, returns `binaryDir` (beside the binary) instead of its parent. The packager-owned directory therefore contains both the binary and the bundle; a package remove cleans everything up.

Supporting mechanics:
- Each route writes `.aspire-install.json` (containing `{"source":"<route-name>"}`) at install time; shared per-RID archives ship sidecar-free.
- An MSBuild guard (`_AssertNoSidecarInArchiveStaging`) fails the build if any per-RID archive stages a sidecar.
- `aspire setup` uses a universal, route-independent path; route-aware layout applies to auto-extract-on-init only.
- `docs/specs/install-routes.md` documents the full contract.

### Before / after

**dotnet-tool** (`dotnet tool install -g Aspire.Cli`):

```
# Before — bundle leaks to parent of packager directory
~/.dotnet/tools/.store/aspire.cli/<version>/.../tools/<tfm>/<rid>/
  aspire                         <- binary (packager-owned dir)
~/.dotnet/tools/.store/aspire.cli/<version>/.../tools/<tfm>/
  versions/<id>/                 <- bundle leaked outside packager dir (wrong)

# After — sibling layout: bundle co-locates with binary
~/.dotnet/tools/.store/aspire.cli/<version>/.../tools/<tfm>/<rid>/
  aspire                          <- binary
  .aspire-install.json            <- {"source":"dotnet-tool"}
  versions/<id>/                  <- bundle inside packager-owned dir (correct)
```

## Why the sidecar

The correct bundle target depends on which packager owns the install — different packagers place the binary in different path shapes. Path-shape detection is fragile: the same per-RID archive feeds `brew`, `winget`, and the PR script, so shape alone is insufficient to identify the install origin.

A sidecar written by the installing route is a single source-of-truth label that survives path changes and is owned by the route that wrote it. A single `source` field is sufficient for layout selection.

## How it works

**Authorship** — one writer per route, at install time:

| Route | Sidecar writer |
|---|---|
| `brew` | `postflight` block in `eng/homebrew/aspire.rb.template` |
| `winget` | `WingetFirstRunProbe` — reads WinGet ARP registry entry on first run, stamps sidecar |
| `script` | `eng/scripts/get-aspire-cli.{sh,ps1}` after archive extraction |
| `pr` | `eng/scripts/get-aspire-cli-pr.{sh,ps1}` after archive extraction |
| `dotnet-tool` | Embedded by `Aspire.Cli.csproj` in the RID-specific nupkg (route-exclusive) |

**Readership**: `BundleService.ComputeDefaultExtractDir` is the single consumer — a pure function of the `source` value; no path-shape detection.

**Producer-side guards**: `_AssertNoSidecarInArchiveStaging` (MSBuild, build-time) prevents sidecar from entering any per-RID archive. `verify-cli-archive.ps1` asserts sidecar absent from the archive; `verify-cli-tool-nupkg.ps1` asserts sidecar present in the RID nupkg and absent from the pointer nupkg. Both run in the AzDO pipeline against signed artifacts.

## New on-disk layout

**winget** (portable install, Windows):

```
%LOCALAPPDATA%\Microsoft\WinGet\Packages  Microsoft.Aspire_<hash>
    aspire.exe
    .aspire-install.json          <- {"source":"winget"}
    versions\<id>\                <- sibling layout: bundle inside packager dir
      <bundle payload>
```

**dotnet-tool** (global tool install):

```
~/.dotnet/tools/.store/aspire.cli/<version>/aspire.cli/<version>/tools/<tfm>/<rid>/
  aspire
  .aspire-install.json            <- {"source":"dotnet-tool"}
  versions/<id>/                  <- sibling layout: bundle inside packager dir
    <bundle payload>
```

**dogfood PR script** (`script`/`pr` stays parent-of-binary):

```
~/.aspire/dogfood/pr-<n>/
  bin/
    aspire
    .aspire-install.json          <- {"source":"pr"}
  versions/<id>/                  <- script layout: bundle at parent-of-bin
    <bundle payload>
```

## Out of scope

`aspire update --self`, channel scoping, and `aspire toolchain prune` land in a later PR. They will consume the `source` field from the sidecar established here.

## Working environment

The repository is checked out at `/app/aspire` at this PR's **base commit**
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

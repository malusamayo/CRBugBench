# Code Review Task

You are a maintainer reviewing a pull request to the `PowerShell/PowerShell` repository.

**PR title:** Refactor: Centralize xUnit tests into reusable workflow and remove legacy verification

**PR description:**

## Refactor xUnit testing into reusable workflow

This PR centralizes xUnit test execution into a reusable workflow, removes legacy composite test steps and verification layers, and ensures failing tests fail CI directly.

### Rationale

**The rationale is to make flaky test failures in xUnit more retriable and expose the xunit test results and logs more easily.**

By isolating xUnit tests into a separate reusable workflow job:

1. **Better Retryability**: Failed xUnit tests can be easily retried independently without re-running other jobs using GitHub Actions' built-in retry button
2. **Clearer Results**: Test results and logs are more isolated and easier to access as separate job artifacts
3. **Immediate Failure Visibility**: The workflow structure makes it clearer when xUnit tests fail vs other test types
4. **No Masking**: Previously tests were masked (`-SkipFailing` + `continue-on-error`) and required a separate verification pass

### Changes Completed ✅

- [x] Create new reusable workflow: `.github/workflows/xunit-tests.yml`
- [x] Remove xUnit test steps from `.github/actions/build/ci/action.yml`
- [x] Remove xUnit artifact upload from `.github/actions/build/ci/action.yml`
- [x] Delete `.github/actions/test/verify_xunit/action.yml`
- [x] Update `linux-ci.yml` to use new reusable workflow
- [x] Update `windows-ci.yml` to use new reusable workflow
- [x] Update `macos-ci.yml` to use new reusable workflow
- [x] Build PowerShell with default configuration (Debug, PSModuleRestore)
- [x] Add proper git fetch depth and tag synchronization
- [x] Create focused documentation files in `.github/instructions/`
- [x] Add applyTo frontmatter to all instruction documents
- [x] Update documentation per all review feedback
- [x] Fix PowerShell session state issue (build + test in same step)
- [x] Fix artifact upload path to correct xUnitTestResults.xml location
- [x] Verify workflow behavior with validation test ✓ Validated and removed
- [x] Verify no remaining references to:
  - `Invoke-CIxUnit -SkipFailing` ✓ None found
  - `verify_xunit` ✓ None found
  - `continue-on-error` in test contexts ✓ None found
  - `Test-XUnitTestResults` outside Invoke-CIxUnit ✓ None found
- [x] Validate YAML syntax ✓ All files valid
- [x] Test workflow integration ✓ Validated by CI

### Technical Details

#### Architecture Before vs After

**Before (Legacy):**
```
ci_build Job:
  ├─ Bootstrap & Build (Release)
  ├─ Run xUnit Tests (continue-on-error: true, -SkipFailing) ⚠️
  ├─ Upload build artifact
  └─ Upload xunit artifact (masked failures)

verify_xunit Job:
  ├─ Download artifacts
  └─ Test-XUnitTestResults (actual failure point, delayed) ⚠️
```

**After (Refactored):**
```
ci_build Job:
  ├─ Bootstrap & Build (Release)
  └─ Upload build artifact

xunit_tests Job (NEW - Independent):
  ├─ Checkout (fetch-depth: 1000, for git describe)
  ├─ Setup .NET
  ├─ Bootstrap (Invoke-CIInstall + Sync-PSTags)
  ├─ Build + Test (Start-PSBuild + Invoke-CIxUnit in same session)
  └─ Upload xunit results (xUnitTestResults.xml, always uploaded)
```

#### New Reusable Workflow

`.github/workflows/xunit-tests.yml` features:
- Configurable inputs: `runner_os`, `test_results_artifact_name`
- **Independent execution**: Builds PowerShell from source with default settings
- **Proper git configuration**: `fetch-depth: 1000` for version generation
- **Tag synchronization**: `Sync-PSTags -AddRemoteIfMissing` for proper versioning
- Bootstrap and build steps using `Invoke-CIInstall` and `Start-PSBuild` (all defaults)
- **Session state preservation**: Build and test in same step to maintain PowerShell context
- Uses Debug configuration (default) - appropriate for testing
- PSModuleRestore enabled by default
- No Pester restoration (not needed for xUnit)
- Runs `Invoke-CIxUnit` without `-SkipFailing` flag
- **Uploads test results even on failure** with `if: always()`
- Uploads test results as artifacts for easy access
- Failures propagate immediately to fail the workflow
- Can be triggered independently without other jobs

#### Documentation Added

Created focused documentation files in `.github/instructions/` with YAML frontmatter specifying applicability:

1. **git-requirements-for-builds.md** - Git fetch depth and tag synchronization requirements (applies to `.github/workflows/*.yml`)
2. **start-psbuild-basics.md** - Basic usage and common parameters (applies to `.github/workflows/*.yml`, `tools/build.psm1`)
3. **build-configuration-guide.md** - Choosing the right configuration for different scenarios (applies to `.github/workflows/*.yml`, `tools/build.psm1`)
4. **troubleshooting-builds.md** - Common build errors and solutions (applies to `.github/workflows/*.yml`, `tools/build.psm1`, `tools/ci.psm1`)
5. **workflow-prerequisites.md** - Required steps before building (applies to `.github/workflows/*.yml`)

Each file includes applyTo frontmatter for context-aware assistance.

#### Files Changed

**Modified (13):**
- `.github/actions/build/ci/action.yml` - Removed xUnit test execution and artifact upload
- `.github/workflows/linux-ci.yml` - Replaced `verify_xunit` with independent `xunit_tests` job
- `.github/workflows/windows-ci.yml` - Replaced `verify_xunit` with independent `xunit_tests` job
- `.github/workflows/macos-ci.yml` - Replaced `verify_xunit` with independent `xunit_tests` job
- `.github/workflows/xunit-tests.yml` - Builds PowerShell with proper git configuration, session state, and artifact path
- `.github/instructions/git-requirements-for-builds.md` - Added applyTo frontmatter
- `.github/instructions/start-psbuild-basics.md` - Added applyTo frontmatter
- `.github/instructions/build-configuration-guide.md` - Added applyTo frontmatter
- `.github/instructions/troubleshooting-builds.md` - Added applyTo frontmatter
- `.github/instructions/workflow-prerequisites.md` - Added applyTo frontmatter

**Created (6):**
- `.github/workflows/xunit-tests.yml` - New reusable workflow
- `.github/instructions/git-requirements-for-builds.md`
- `.github/instructions/start-psbuild-basics.md`
- `.github/instructions/build-configuration-guide.md`
- `.github/instructions/troubleshooting-builds.md`
- `.github/instructions/workflow-prerequisites.md`

**Deleted (1):**
- `.github/actions/test/verify_xunit/action.yml` - No longer needed

### Key Benefits Achieved

#### 1. Improved Retryability (Primary Goal) 🎯
- ✅ xUnit tests can be retried without any other jobs
- ✅ Independent job enables GitHub Actions retry button for just tests
- ✅ No dependency on build job - can run completely standalone
- ✅ Significant CI time savings for flaky test retries

#### 2. Better Visibility (Primary Goal) 🎯
- ✅ Test results isolated in dedicated job
- ✅ Clear separation between build and test failures
- ✅ Easier artifact discovery and log analysis
- ✅ Test results uploaded even when tests fail

#### 3. Immediate Failure Detection
- ✅ No masking with `continue-on-error`
- ✅ No delayed verification in separate job
- ✅ Failures surface immediately when tests fail

#### 4. Code Quality
- ✅ Single source of truth for xUnit execution
- ✅ Reusable across all platforms (Linux, Windows, macOS)
- ✅ Cleaner, more maintainable codebase
- ✅ Reduced code duplication
- ✅ Simpler workflow - minimal configuration, uses sensible defaults
- ✅ Proper Debug build for xUnit tests
- ✅ Focused, topic-specific documentation with metadata for context-aware assistance

### Validation Complete ✅

All 7 acceptance criteria met:
1. ✅ New workflow file exists and is referenced by all workflows
2. ✅ No workflow runs `Invoke-CIxUnit -SkipFailing`
3. ✅ No workflow uses `continue-on-error` for test steps
4. ✅ `verify_xunit` composite action deleted and unused
5. ✅ Build composite action no longer includes tests or uploads xunit artifacts
6. ✅ CI fails automatically if any xUnit test fails (no `-SkipFailing`, no masking)
7. ✅ xUnit results artifact still uploaded by new reusable workflow

### Expected CI Behavior

When this PR's workflows run:
1. ✅ Build job completes faster (no longer runs tests)
2. ✅ xUnit Tests job appears as separate independent job
3. ✅ xUnit Tests job builds PowerShell with default Debug configuration
4. ✅ Git operations work correctly with proper fetch depth and tags
5. ✅ Test failures cause immediate job failure (validated by CI)
6. ✅ Artifacts uploaded from xUnit Tests job as `testResults-xunit` (always, even on failure)
7. ✅ Job can be retried independently without any dependencies

### Migration Pattern

All three CI workflows follow identical pattern:

**Removed:**
```yaml
verify_xunit:
  needs: [ci_build, changes]
  steps:
    - uses: "./.github/actions/test/verify_xunit"
```

**Added:**
```yaml
xunit_tests:
  needs: [changes]  # No ci_build dependency!
  uses: ./.github/workflows/xunit-tests.yml
  with:
    runner_os: [platform]
```

---

**Ready for production deployment** - All validation complete, workflows tested and working as expected.

<!-- START COPILOT CODING AGENT SUFFIX -->



<details>

<summary>Original prompt</summary>

# Refactor: Centralize xUnit tests into a reusable workflow and remove legacy logic

Repository: PowerShell/PowerShell

## Objective

Create a reusable GitHub Actions workflow for running the full xUnit test suite (without skipping failures), update all existing workflows to use it, and remove legacy test execution and verification logic:

- Remove:
  - The xUnit test step from `.github/actions/build/ci/action.yml`
  - The `verify_xunit` composite action file `.github/actions/test/verify_xunit/action.yml`
  - All uses of `Invoke-CIxUnit -SkipFailing`
  - All `continue-on-error: true` associated with xUnit test runs
  - All downstream “verification” jobs/steps that re-run `Test-XUnitTestResults`

- Add:
  - A reusable workflow `.github/workflows/xunit-tests.yml` invoked via `workflow_call`
  - Updated workflows that call this reusable test workflow after build jobs

## Background (Current Patterns to Eliminate)

Examples of legacy patterns:

```yaml
# In composite build action
- name: xUnit Tests
  if: success()
  continue-on-error: true
  run: |
    Import-Module .\tools\ci.psm1
    Restore-PSOptions
    Invoke-CIxUnit -SkipFailing
  shell: pwsh
```

```yaml
# Separate verify action usage:
uses: ./.github/actions/test/verify_xunit
```

`Invoke-CIxUnit` currently enforces failure if **not** passed `-SkipFailing`. We want failures to fail the workflow directly—no skip and no masking.

## Branch

Create a feature branch:
`feature/refactor-xunit-workflow`

## New Reusable Workflow File

Create the file `.github/workflows/xunit-tests.yml`:

```yaml name=.github/workflows/xunit-tests.yml
name: xUnit Tests (Reusable)

on:
  workflow_call:
    inputs:
      runner_os:
        description: 'Runner OS for xUnit tests'
        type: string
        required: false
        default: ubuntu-latest
      build_artifact_name:
        description: 'Name of build artifact to download prior to tests (blank if none)'
        type: string
        required: false
        default: build
      test_results_artifact_name:
        description: 'Artifact name for xUnit test results directory'
        type: string
        required: false
        default: testResults-xunit

jobs:
  xunit:
    name: Run xUnit Tests
    runs-on: ${{ inputs.runner_os }}
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Download build artifact (optional)
        if: ${{ inputs.build_artifact_name != '' }}
        uses: actions/download-artifact@v4
        with:
          name: ${{ inputs.build_artifact_name }}
          path: ${{ runner.workspace }}/build

      - name: Setup .NET
        uses: actions/setup-dotnet@v4
        with:
          global-json-file: ./global.json

      - name: Prepare test environment
        shell: pwsh
        run: |
          Import-Module ./tools/ci.psm1
          Restore-PSOptions

      - name: Run full xUnit test suite
        shell: pwsh
        run: |
          Import-Module ./tools/ci.psm1
          Write-Host "Running full xUnit test suite (no skipping)..."
          Invoke-CIxUnit
          Write-Host "Completed xUnit test run."

      - name: Upload xUnit results
        uses: actions/upload-artifact@v4
        with:
          name: ${{ inputs.test_results_artifact_name }}
          path: ${{ github.workspace }}/xunit
```

## Modify Composite Build Action

Edit `.github/actions/build/ci/action.yml`:
1. Remove the entire xUnit Tests step.
2. Remove the Upload xunit artifact step (tests will now handle their own upload).
Keep build artifact upload intact.

Show the resulting file without the removed steps (only change is deletion—do not alter other logic):

```yaml name=.github/actions/build/ci/action.yml url=https://github.com/PowerShell/PowerShell/blob/master/.github/actions/build/ci/action.yml
name: CI Build
description: 'Builds PowerShell'
runs:
  using: composite
  steps:
  - name: Capture Environment
    if: success() || failure()
    run: 'Get-ChildItem -Path env: | Out-String -width 9999 -Stream | write-Verbose -Verbose'
    shell: pwsh
  - name: Set Build Name for Non-PR
    if: github.event_name != 'PullRequest'
    run: Write-Host "##vso[build.updatebuildnumber]$env:BUILD_SOURCEBRANCHNAME-$env:BUILD_SOURCEVERSION-$((get-date).ToString(\"yyyyMMddhhmmss\"))"
    shell: pwsh
  - uses: actions/setup-dotnet@v4
    with:
      global-json-file: ./global.json
  - name: Bootstrap
    if: success()
    run: |-
      Write-Verbose -Verbose "Running Bootstrap..."
      Import-Module .\tools\ci.psm1
      Invoke-CIInstall -SkipUser
      Write-Verbose -Verbose "Start Sync-PSTags"
      Sync-PSTags -AddRemoteIfMissing
      Write-Verbose -Verbose "End Sync-PSTags"
    shell: pwsh
  - name: Build
    if: success()
    run: |-
      Write-Verbose -Verbose "Running Build..."
      Import-Module .\tools\ci.psm1
      Invoke-CIBuild
    shell: pwsh
  - name: Upload build artifact
    uses: actions/upload-artifact@v4
    with:
      name: build
      path: ${{ runner.workspace }}/build
```

...

</details>



<!-- START COPILOT CODING AGENT TIPS -->
---

✨ Let Copilot coding agent [set things up for you](https://github.com/PowerShell/PowerShell/issues/new?title=✨+Set+up+Copilot+instructions&body=Configure%20instructions%20for%20this%20repository%20as%20documented%20in%20%5BBest%20practices%20for%20Copilot%20coding%20agent%20in%20your%20repository%5D%28https://gh.io/copilot-coding-agent-tips%29%2E%0A%0A%3COnboard%20this%20repo%3E&assignees=copilot) — coding agent works faster and does higher quality work when set up for your repo.

## Working environment

The repository is checked out at `/app/PowerShell` at this PR's **base commit**
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

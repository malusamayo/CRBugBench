# Code Review Task

You are a maintainer reviewing a pull request to the `bitwarden/server` repository.

**PR title:** [AC-1344] Provider users unable to bulk restore vault items for client organizations

**PR description:**

## Type of change

```
- [X] Bug fix
- [ ] New feature development
- [ ] Tech debt (refactoring, code cleanup, dependency upgrades, etc)
- [ ] Build/deploy pipeline (DevOps)
- [ ] Other
```

## Objective
Bulk restoring items in the web vault is not working for Provider users because the existing API endpoint only allows that action for Organization members.


## Code changes

This PR is related to [this clients PR](https://github.com/bitwarden/clients/pull/5259).

- **src/Api/Vault/Controllers/CiphersController.cs:** Changed output model to `ListResponseModel<CipherMiniResponseModel>` and moved logic to `CipherService`. Added new endpoint `PutRestoreManyAdmin`
- **src/Api/Vault/Models/Request/CipherRequestModel.cs:** Added `OrganizationId` field to `CipherBulkRestoreRequestModel`
- **src/Core/Vault/Repositories/ICipherRepository.cs:** Added method `RestoreByIdsOrganizationIdAsync` to restore certain ciphers for an organization
- **src/Core/Vault/Services/ICipherService.cs:** Added parameters `organizationId` and `orgAdmin` to `RestoreManyAsync` and updated output to `ICollection<CipherOrganizationDetails>`
- **src/Core/Vault/Services/Implementations/CipherService.cs:** If an `organizationId` value is passed and `orgAdmin == true` then `CipherRepository.RestoreByIdsOrganizationIdAsync` is used otherwise its `CipherRepository.RestoreAsync`
- **src/Infrastructure.Dapper/Vault/Repositories/CipherRepository.cs:** Added method to restore certain ciphers for an Organization
- **src/Infrastructure.EntityFramework/Vault/Repositories/CipherRepository.cs:** Added method to restore certain ciphers for an Organization
- **src/Sql/Sql.sqlproj:** Added file `Cipher_RestoreByIdsOrganizationId.sql`
- **src/Sql/Vault/dbo/Stored Procedures/Cipher/Cipher_RestoreByIdsOrganizationId.sql:** Stored procedure to bulk restore ciphers that belong to an organization
- **test/Core.Test/Vault/Services/CipherServiceTests.cs:** Fixed existing unit test
- **util/Migrator/DbScripts/2023-04-21_00_CipherRestoreByIdsOrganizationId.sql:** SQL migration

## Before you submit

- Please check for formatting errors (`dotnet format --verify-no-changes`) (required)
- If making database changes - make sure you also update Entity Framework queries and/or migrations
- Please add **unit tests** where it makes sense to do so (encouraged but not required)
- If this change requires a **documentation update** - notify the documentation team
- If this change has particular **deployment requirements** - notify the DevOps team

## Working environment

The repository is checked out at `/app/server` at this PR's **base commit**
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

# Code Review Task

You are a maintainer reviewing a pull request to the `microsoft/aspire` repository.

**PR title:** Update external NuGet dependencies to latest versions

**PR description:**

## Summary

Updates 38 external NuGet dependencies to their latest versions and enhances the dependency-update skill with lessons learned from the bulk update process.

### Package Updates

| Package | Old | New |
|---------|-----|-----|
| Confluent.Kafka | 2.12.0 | 2.13.0 |
| Google.Protobuf | 3.33.0 | 3.33.5 |
| Grpc.AspNetCore | 2.71.0 | 2.76.0 |
| Grpc.Net.ClientFactory | 2.71.0 | 2.76.0 |
| Grpc.Tools | 2.72.0 | 2.78.0 |
| Hex1b / McpServer / Tool | 0.78.0 | 0.90.0 |
| Humanizer.Core | 2.14.1 | 3.0.1 |
| JsonPatch.Net | 3.3.0 | 5.0.0 |
| KubernetesClient | 18.0.5 | 18.0.13 |
| Markdig | 0.43.0 | 0.45.0 |
| Microsoft.Data.SqlClient | 6.1.2 | 6.1.4 |
| Microsoft.DevTunnels.Connections | 1.3.6 | 1.3.12 |
| Microsoft.FluentUI.AspNetCore.Components(\*) | 4.13.2 | 4.14.0 |
| ModelContextProtocol(\*) | 0.4.0-preview.3 | 0.8.0-preview.1 |
| MongoDB.Driver | 3.5.0 | 3.6.0 |
| MongoDB.Driver.Core.Extensions.DiagnosticSources | 2.1.0 | 3.0.0 |
| MySqlConnector.DependencyInjection | 2.4.0 | 2.5.0 |
| NATS.Net | 2.6.11 | 2.7.2 |
| Npgsql.DependencyInjection | 10.0.0 | 10.0.1 |
| Npgsql.OpenTelemetry | 10.0.0 | 10.0.1 |
| OpenAI | 2.7.0 | 2.8.0 |
| OpenTelemetry.Exporter.Console | 1.14.0 | 1.15.0 |
| OpenTelemetry.Exporter.InMemory | 1.14.0 | 1.15.0 |
| OpenTelemetry.Instrumentation.GrpcNetClient | 1.14.0-beta.1 | 1.15.0-beta.1 |
| Oracle.ManagedDataAccess.OpenTelemetry | 23.26.0 | 23.26.100 |
| Polly.Core / Extensions | 8.6.4 | 8.6.5 |
| Pomelo.EntityFrameworkCore.MySql | 8.0.3 | 9.0.0 |
| Qdrant.Client | 1.15.1 | 1.16.1 |
| RabbitMQ.Client | 7.1.2 | 7.2.0 |
| Spectre.Console | 0.52.1-preview.0.5 | 0.54.1-alpha.0.37 |
| StackExchange.Redis | 2.9.32 | 2.11.0 |
| StreamJsonRpc | 2.22.23 | 2.24.84 |
| System.IO.Hashing | 9.0.10 | 10.0.3 |

### Not Updated
- **Microsoft.AI.Foundry.Local** ΓÇö held at 0.3.0 due to NU1603 (broken transitive dep metadata in Microsoft.ML.OnnxRuntime.Foundry)

### Other Changes
- Moved \Microsoft.Extensions.Caching.Memory\ from the TFM-conditional section to the common section to resolve the transitive pinning conflict introduced by Pomelo 9.0.0
- Enhanced \.github/skills/dependency-update/SKILL.md\ with bulk update workflow, transitive pinning guidance, and Windows Azure CLI fallback

### Mirrored Packages
The following packages were mirrored to internal feeds via the dotnet-migrate-package pipeline:
- OpenTelemetry.Instrumentation.GrpcNetClient 1.15.0-beta.1
- Spectre.Console 0.54.1-alpha.0.37
- ModelContextProtocol 0.8.0-preview.1
- ModelContextProtocol.AspNetCore 0.8.0-preview.1

### Follow-up Issues

The following issues were logged to track problems discovered during this upgrade that need to be addressed separately:

- #14553 — **Update JsonPatch.Net and JsonSchema.Net together** (Milestone: 13.2): JsonPatch.Net 5.0.0 is incompatible with the currently pinned JsonSchema.Net 7.4.0 due to a JsonPointer value type change. Both packages need a coordinated update with test utility code changes.
- #14554 — **Migrate Pomelo MySqlConnector logging away from obsolete API** (Milestone: Backlog): `MySqlConnectorLogManager.Provider` is obsolete but there is no non-obsolete alternative for wiring MySqlConnector's internal log categories when using Pomelo without `MySqlDataSource`. Currently suppressed with `#pragma`.

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

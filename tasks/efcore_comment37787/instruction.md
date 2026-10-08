# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/efcore` repository.

**PR title:** Fix in-memory corruption of nested owned entities after SaveChanges when navigation is replaced

**PR description:**

Fixes #38095

When a JSON-mapped owned entity navigation is replaced with a new instance that shares nested child references (e.g., via C# record `with` expression), nested owned entities become `null` in memory after `SaveChanges`, despite being correctly persisted to the database.

```csharp
product.Metadata = product.Metadata with { Color = "red" };
await context.SaveChangesAsync();
// product.Metadata.Weight is now null — throws NullReferenceException
```

### Root cause

During the replace-and-save cycle, three things go wrong:

1. The old owned entity tree is cascade-deleted, which marks shared child entities as `Deleted`
2. `EntityGraphAttacher.PaintAction` only processes `Detached` entities, so shared children stuck in `Deleted` state are skipped when the new parent graph is attached
3. `StateManager.CascadeDelete` re-cascades the old parent's deletion to the shared children, and `DeleteFixup` resolves the replacement principal via the identity map and nulls its navigation — corrupting the in-memory graph

### Fix

- **`EntityGraphAttacher.PaintAction`/`PaintActionAsync`**: Allow `Deleted` entities to be re-attached during graph traversal when the source entry has a `SharedIdentityEntry` (indicating the graph is being traversed from a replacement parent)
- **`StateManager.CascadeDelete`**: Early-return when the entry has a `SharedIdentityEntry`, skipping cascade from old entries that have already been replaced
- **`JsonUpdateTestBase`**: Add regression test `Replace_json_reference_root_preserves_nested_owned_entities_in_memory`
- **Provider test overrides**: Add test overrides with SQL baselines in `JsonUpdateJsonTypeSqlServerTest` and `JsonUpdateSqliteTest`

<!-- START COPILOT ORIGINAL PROMPT -->



<details>

<summary>Original prompt</summary>

> 
> ----
> 
> *This section details on the original issue you should resolve*
> 
> <issue_title>In-Memory Corruption of Nested Owned Entities After SaveChanges with Record 'with' Expression</issue_title>
> <issue_description>### Bug description
> 
> When using C# record's `with` expression on an owned entity stored as JSON, EF Core corrupts the in-memory representation of nested owned entities after calling `SaveChanges()`. The nested properties become `null` in memory, causing `NullReferenceException` when accessed, even though the data is correctly persisted to the database.
> 
> ## Steps to Reproduce
> 
> 1. Create an entity with an owned entity (C# record) stored as JSON that contains nested owned entities
> 2. Add the entity to the context and call `SaveChanges()` (first save)
> 3. Use the `with` expression to create a modified copy of the owned entity
> 4. Call `SaveChanges()` again (second save)
> 5. Access nested properties of the owned entity
> 
> ## Expected Behavior
> 
> The in-memory entity graph should remain intact after `SaveChanges()`. All nested properties of the owned entity should be accessible with their correct values.
> 
> In my reproduction code, `product.Metadata.Weight.Value` should remain `5` after the second `SaveChanges()`.
> 
> ## Actual Behavior
> 
> After the second `SaveChanges()`, nested owned entities become `null` in memory. Accessing `product.Metadata.Weight.Value` throws `NullReferenceException` because `Weight` is now `null`.
> 
> **Important**: The data IS correctly persisted to the database. This is purely an in-memory corruption of the tracked entity.
> 
> ### Your code
> Full reproduction code including failing test can be found here: https://github.com/gustavlarson/efcore-record-bug
> 
> ```csharp
> using Microsoft.EntityFrameworkCore;
> 
> // Entity model
> public class Product
> {
>     public int Id { get; set; }
>     public required string Name { get; set; }
>     public ProductMetadata? Metadata { get; set; }
> }
> 
> public record ProductMetadata
> {
>     public Weight? Weight { get; init; }
>     public string? Color { get; init; }
> }
> 
> public record Weight
> {
>     public int Value { get; init; }
>     public string Unit { get; init; }
> }
> 
> // DbContext configuration
> public class TestDbContext : DbContext
> {
>     public TestDbContext(DbContextOptions<TestDbContext> options) : base(options) { }
>     
>     public DbSet<Product> Products => Set<Product>();
>     
>     protected override void OnModelCreating(ModelBuilder modelBuilder)
>     {
>         modelBuilder.Entity<Product>(entity =>
>         {
>             entity.HasKey(e => e.Id);
>             entity.Property(e => e.Name).IsRequired().HasMaxLength(200);
>             entity.OwnsOne(e => e.Metadata, metadata =>
>             {
>                 metadata.ToJson();  // Key: stored as JSON
>                 metadata.OwnsOne(e => e.Weight);
>             });
>         });
>     }
> }
> 
> // Reproduction
> var product = new Product 
> { 
>     Name = "Test Product", 
>     Metadata = new() 
>     { 
>         Weight = new() { Value = 5 } 
>     }
> };
> 
> context.Products.Add(product);
> await context.SaveChangesAsync();  // First save - works fine
> 
> // Use 'with' expression to create modified copy
> product.Metadata = product.Metadata with { Color = product.Metadata.Color };
> 
> // At this point, product.Metadata.Weight.Value is still 5
> Console.WriteLine($"Before SaveChanges: {product.Metadata.Weight.Value}"); // Prints: 5
> 
> await context.SaveChangesAsync();  // Second save - triggers bug
> 
> // BUG: Weight is now null!
> Console.WriteLine($"After SaveChanges: {product.Metadata.Weight.Value}"); // NullReferenceException!
> ```
> 
> ### Stack traces
> 
> ```text
> 
> ```
> 
> ### Verbose output
> 
> ```text
> 
> ```
> 
> ### EF Core version
> 
> 10.0.2
> 
> ### Database provider
> 
> _No response_
> 
> ### Target framework
> 
> .NET 10
> 
> ### Operating system
> 
> Windows 11
> 
> ### IDE
> 
> _No response_</issue_description>
> 
> ## Comments on the Issue (you are @copilot in this section)
> 
> <comments>
> </comments>
> 


</details>



<!-- START COPILOT CODING AGENT SUFFIX -->

- Fixes dotnet/efcore#37581

<!-- START COPILOT CODING AGENT TIPS -->
---

💡 You can make Copilot smarter by setting up custom instructions, customizing its development environment and configuring Model Context Protocol (MCP) servers. Learn more [Copilot coding agent tips](https://gh.io/copilot-coding-agent-tips) in the docs.

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

#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/EFCore/ChangeTracking/Internal/InternalEntityEntry.cs`:

This pull request introduces the defect later reported as "DetectChanges can result in "the property has a temporary value" error on save". The
problem a user observed, and its root cause:

With nested entity types, calling DetectChanges can result in "the property has a temporary value" error on save, referring to the innermost entity type.

### Steps to reproduce

1. Create a console application, with the following code in a file Model.cs:

```C#
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace ConsoleApp.SQLite
{
    public class MyContext : DbContext
    {
        public DbSet<FirstLevel> FirstLevels { get; set; }
        public DbSet<SecondLevel> SecondLevels { get; set; }
        public DbSet<ThirdLevel> ThirdLevels { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlite("Data Source=mydb");
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<FirstLevel>().HasData(new FirstLevel { Id = 1 });
        }
    }

    public class FirstLevel
    {
        public int Id { get; set; }
        public IList<SecondLevel> SecondLevels { get; set; }
    }

    public class SecondLevel
    {
        public int Id { get; set; }
        public int FirstLevelId { get; set; }
        public FirstLevel FirstLevel { get; set; }
        public IList<ThirdLevel> ThirdLevels { get; set; }
    }

    public class ThirdLevel
    {
        public int Id { get; set; }
        public int SecondLevelId { get; set; }
        public SecondLevel SecondLevel { get; set; }
    }
}

```

2. Create the following code in a file Program.cs:

```C#
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;

namespace ConsoleApp.SQLite
{
    public class Program
    {
        public static void Main()
        {
            using (var db = new MyContext())
            {
                // Get data
                var outputs = db.FirstLevels
                    .Include(o => o.SecondLevels)
                    .ThenInclude(s => s.ThirdLevels)
                    .SingleOrDefault(c => c.Id == 1);

                // Replace with new data
                AddData(outputs);

                // Do a detect changes (e.g. maybe we want to retrieve an entity via db.Entry())
                db.ChangeTracker.DetectChanges();

                // Replace the data again
                AddData(outputs);

                // Save
                db.SaveChanges();
            }
        }

        private static void AddData(FirstLevel first)
        {
            first.SecondLevels = new List<SecondLevel>
            {
                new SecondLevel
                {
                    ThirdLevels = new List<ThirdLevel> { new ThirdLevel(), new ThirdLevel() }
                },
                new SecondLevel
                {
                    ThirdLevels = new List<ThirdLevel> { new ThirdLevel(), new ThirdLevel() }
                }
            };
        }
    }
}
```

3. Create the database and run the program:

```
dotnet ef migrations add InitialCreate
dotnet ef database update
dotnet run
```

The program execution fails with the error:

```
Unhandled Exception: System.InvalidOperationException: The property 'SecondLevelId' on entity type 'ThirdLevel' has a temporary value. Either set a permanent value explicitly or ensure that the database is configured to generate values for this property.
   at Microsoft.EntityFrameworkCore.Update.Internal.CommandBatchPreparer.Validate(ModificationCommand modificationCommand)
   at Microsoft.EntityFrameworkCore.Update.Internal.CommandBatchPreparer.BatchCommands(IReadOnlyList`1 entries)+MoveNext()
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.Execute(DbContext _, ValueTuple`2 parameters)
   at Microsoft.EntityFrameworkCore.Storage.Internal.NoopExecutionStrategy.Execute[TState,TResult](TState state, Func`3 operation, Func`3 verifySucceeded)
   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.Execute(IEnumerable`1 commandBatches, IRelationalConnection connection)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChanges(IReadOnlyList`1 entriesToSave)
   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChanges(Boolean acceptAllChangesOnSuccess)
   at Microsoft.EntityFrameworkCore.DbContext.SaveChanges(Boolean acceptAllChangesOnSuccess)
   at ConsoleApp.SQLite.Program.Main() in C:...\Program.cs:line 29
```

Note that the save is successful if the code is changed in any of these ways:

* Remove the DetectChanges line
* Remove the second call to AddData
* Replace the lists of ThirdLevels with empty lists
* Move the DetectChanges line to before the first call to AddData, or after the second call to AddData

We can work around this problem in our "real" code, but I'm curious as to why it's happening so we know the workaround is sufficient. In our case we need to set a particular entity (that has been retrieved from a cache) to state Unchanged by accessing db.Entry(entity).State, which triggers a call to DetectChanges.

### Further technical details
EF Core version: 2.2.4
.NET SDK: 2.2.104
Database Provider: Microsoft.EntityFrameworkCore.Sqlite (though in our "real" code we use SqlServer)
Operating system: Windows 10 Enterprise
IDE: Visual Studio 15.9.7

This same root cause must be fixed before merging.
REVIEW_EOF

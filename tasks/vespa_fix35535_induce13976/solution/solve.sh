#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `searchcore/src/vespa/searchcore/proton/server/documentretriever.cpp`:

This pull request introduces the defect later reported as "Proton crashes when accessing a document with a `position` type field using `DocumentAccess`". The
problem a user observed, and its root cause:

**Describe the bug**
When using `DocumentAccess` to access a document containing a field of type `position`, proton receives a SIGSEGV signal and terminates.

```
1766455235.950559       vespa.vp-net    400     searchnode      stderr  warning *** SIGSEGV received at time=1766455235 on cpu 7 ***
1766455235.970083       vespa.vp-net    400     searchnode      stderr  warning PC: @           0x5fcfe8  (unknown)  proton::DocumentRetriever::populate()
1766455235.970145       vespa.vp-net    400     searchnode      stderr  warning     @     0xe3c0b7ace604        464  absl::lts_20250127::AbslFailureSignalHandler()
1766455235.970155       vespa.vp-net    400     searchnode      stderr  warning     @     0xe3c0b8ca08f8       4928  (unknown)
1766455235.970162       vespa.vp-net    400     searchnode      stderr  warning     @           0x5fd87c        320  proton::DocumentRetriever::getPartialDocument()
1766455235.970168       vespa.vp-net    400     searchnode      stderr  warning     @           0x618814        176  proton::CommitAndWaitDocumentRetriever::getPartialDocument()
1766455235.970174       vespa.vp-net    400     searchnode      stderr  warning     @           0x6222c8         64  proton::PersistenceEngine::get()
1766455235.970179       vespa.vp-net    400     searchnode      stderr  warning     @     0xe3c0b6095a80        240  storage::ProviderErrorWrapper::get()
1766455235.970184       vespa.vp-net    400     searchnode      stderr  warning     @     0xe3c0b6098878        288  storage::SimpleMessageHandler::handleGet()
1766455235.970189       vespa.vp-net    400     searchnode      stderr  warning     @     0xe3c0b608f610        208  storage::PersistenceHandler::handleCommandSplitByType()
1766455235.970195       vespa.vp-net    400     searchnode      stderr  warning     @     0xe3c0b608fa20        160  storage::PersistenceHandler::processMessage()
1766455235.970200       vespa.vp-net    400     searchnode      stderr  warning     @     0xe3c0b6090140        176  storage::PersistenceHandler::processLockedMessage()
1766455235.970205       vespa.vp-net    400     searchnode      stderr  warning     @     0xe3c0b6090d7c        144  storage::PersistenceThread::run()
1766455235.970210       vespa.vp-net    400     searchnode      stderr  warning     @     0xe3c0b61cfcdc        208  storage::framework::defaultimplementation::ThreadImpl::run()
1766455235.970216       vespa.vp-net    400     searchnode      stderr  warning     @     0xe3c0a8ef9d2c         32  (unknown)
1766455235.970221       vespa.vp-net    400     searchnode      stderr  warning     @     0xe3c0b7b14c84         32  mallocThreadProxy
1766455235.970226       vespa.vp-net    400     searchnode      stderr  warning     @     0xe3c0a906c8b8         80  start_thread
```

**To Reproduce**
Steps to Reproduce:
1. Define a schema with a field of type `position`.
2. Feed a document defined by that schema.
3. In a searcher, access a document of that schema using `DocumentAccess`.
4. Proton terminates with a SIGSEGV.

**Expected behavior**
The document should be accessed normally.

**Environment (please complete the following information):**
 - OS: Ubuntu 22.04
 - Infrastructure: self-hosted 

**Vespa version**
8.620.35

**Additional context**
Here is the schema definition I used.

```
schema item {
    document item {
        field id type string {
            indexing: attribute | summary
        }
        field location type position {
            indexing: attribute | summary
        }
    }
}
```

And this is how I access it in the searcher.
```java
// ...
    @Inject
    public TestSearcher(DocumentAccess documentAccess) {
        this.session = documentAccess.createSyncSession(new SyncParameters.Builder().build());
    }

    @Override
    public Result search(Query query, Execution execution) {

        var doc = session.get(new DocumentId("id:item:item::1")); // crash if id:item:item::1 exists

        return execution.search(query);
    }
// ...
```

And one interesting point is that it's fine as long as there's a field indexed with `index` in the schema definition.
```
schema item {
    document item {
        field id type string {
            indexing: attribute | summary
        }

        field location type position {
            indexing: attribute | summary
        }

        # Adding this field makes it work
        field dummy type string {
            indexing: index | summary
        }
    }
}
```

This same root cause must be fixed before merging.
REVIEW_EOF

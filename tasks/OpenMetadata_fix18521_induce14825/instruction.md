# Code Review Task

You are a maintainer reviewing a pull request to the `open-metadata/OpenMetadata` repository.

**PR title:** Fixes  #5448: Implement initial Iceberg Connector using PyIceberg (#14825)

**PR description / commit message:**

Fixes  #5448: Implement initial Iceberg Connector using PyIceberg (#14825)

* Create the iceberg connection schema

* Link the IcebergConnection configuration with the forms on the UI

* Add the pyiceberg dependency on the ingestion package

* Create the get_connection and test_connection functions

* First iteration on the iceberg ingestion logic

* Add A more comprehensive implementation of the Iceberg Source

* Add UnitTests

* Update icebergConnection definition

* Update the iceberg souce code based on new schema

* Updated icebergConnecgtion schema for simplicity and to be able to configure Converters

* Updated setup dependencies to be more flexible

* Updated get_owner_ref logic

* Fix formatting

* Changed the icebergConnection json schema structure to enable the ClassConverters

* Add the IcebergCatalog and IcebergFileSystem ClassConverters

* Refactor the code to take into account the new jsonSchema structure

* Fix formatting

* Add Documentation for the Iceberg Connector

* Fix Menu order for Iceberg

* ui: add Iceberg service icon and constant

* Fix DynamoDb Catalog issue due to how PyIceberg instantes it

* Changed uri title to URI

* Fix ClassConverter for Iceberg

* Fix GetSecretValue for password types

* Fix formatting

* Fix formatting

* Add Iceberg Connector Images for the docs

* Add pylint disable for Hacky super() call

* Add Iceberg.md for the UI docs

* Fix pylint complaint

* Fix pylint complaint

* Fix UnitTests

* fix type error and unit tests

* update pipeline type checks

* Fix Sonar Cloud complaints

---------

Co-authored-by: Sachin Chaurasiya <sachinchaurasiyachotey87@gmail.com>

## Working environment

The repository is checked out at `/app/OpenMetadata` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.

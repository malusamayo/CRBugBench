# Code Review Task

You are a maintainer reviewing a pull request to the `ankitects/anki` repository.

**PR title:** Add apkg import/export on backend (#1743)

**PR description / commit message:**

Add apkg import/export on backend (#1743)

* Add apkg export on backend

* Filter out missing media-paths at write time

* Make TagMatcher::new() infallible

* Gather export data instead of copying directly

* Revert changes to rslib/src/tags/

* Reuse filename_is_safe/check_filename_safe()

* Accept func to produce MediaIter in export_apkg()

* Only store file folder once in MediaIter

* Use temporary tables for gathering

export_apkg() now accepts a search instead of a deck id. Decks are
gathered according to the matched notes' cards.

* Use schedule_as_new() to reset cards

* ExportData → ExchangeData

* Ignore ascii case when filtering system tags

* search_notes_cards_into_table →

search_cards_of_notes_into_table

* Start on apkg importing on backend

* Fix due dates in days for apkg export

* Refactor import-export/package

- Move media and meta code into appropriate modules.
- Normalize/check for normalization when deserializing media entries.

* Add SafeMediaEntry for deserialized MediaEntries

* Prepare media based on checksums

- Ensure all existing media files are hashed.
- Hash incoming files during preparation to detect conflicts.
- Uniquify names of conflicting files with hash (not notetype id).
- Mark media files as used while importing notes.
- Finally copy used media.

* Handle encoding in `replace_media_refs()`

* Add trait to keep down cow boilerplate

* Add notetypes immediately instaed of preparing

* Move target_col into Context

* Add notes immediately instaed of preparing

* Note id, not guid of conflicting notes

* Add import_decks()

* decks_configs → deck_configs

* Add import_deck_configs()

* Add import_cards(), import_revlog()

* Use dyn instead of generic for media_fn

Otherwise, would have to pass None with type annotation in the default
case.

* Fix signature of import_apkg()

* Fix search_cards_of_notes_into_table()

* Test new functions in text.rs

* Add roundtrip test for apkg (stub)

* Keep source id of imported cards (or skip)

* Keep source ids of imported revlog (or skip)

* Try to keep source ids of imported notes

* Make adding notetype with id undoable

* Wrap apkg import in transaction

* Keep source ids of imported deck configs (or skip)

* Handle card due dates and original due/did

* Fix importing cards/revlog

Card ids are manually uniquified.

* Factor out card importing

* Refactor card and revlog importing

* Factor out card importing

Also handle missing parents .

* Factor out note importing

* Factor out media importing

* Maybe upgrade scheduler of apkg

* Fix parent deck gathering

* Unconditionally import static media

* Fix deck importing edge cases

Test those edge cases, and add some global test helpers.

* Test note importing

* Let import_apkg() take a progress func

* Expand roundtrip apkg test

* Use fat pointer to avoid propogating generics

* Fix progress_fn type

* Expose apkg export/import on backend

* Return note log when importing apkg

* Fix archived collection name on apkg import

* Add CollectionOpWithBackendProgress

* Fix wrong Interrupted Exception being checked

* Add ClosedCollectionOp

* Add note ids to log and strip HTML

* Update progress when checking incoming media too

* Conditionally enable new importing in GUI

* Fix all_checksums() for media import

Entries of deleted files are nulled, not removed.

* Make apkg exporting on backend abortable

* Return number of notes imported from apkg

* Fix exception printing for QueryOp as well

* Add QueryOpWithBackendProgress

Also support backend exporting progress.

* Expose new apkg and colpkg exporting

* Open transaction in insert_data()

Was slowing down exporting by several orders of magnitude.

* Handle zstd-compressed apkg

* Add legacy arg to ExportAnkiPackage

Currently not exposed on the frontend

* Remove unused import in proto file

* Add symlink for typechecking of import_export_pb2

* Avoid kwargs in pb message creation, so typechecking is not lost

Protobuf's behaviour is rather subtle and I had to dig through the docs
to figure it out: set a field on a submessage to automatically assign 
the submessage to the parent, or call SetInParent() to persist a default
version of the field you specified.

* Avoid re-exporting protobuf msgs we only use internally

* Stop after one test failure

mypy often fails much faster than pylint

* Avoid an extra allocation when extracting media checksums

* Update progress after prepare_media() finishes

Otherwise the bulk of the import ends up being shown as "Checked: 0"
in the progress window.

* Show progress of note imports

Note import is the slowest part, so showing progress here makes the UI
feel more responsive.

* Reset filtered decks at import time

Before this change, filtered decks exported with scheduling remained
filtered on import, and maybe_remove_from_filtered_deck() moved cards
into them as their home deck, leading to errors during review.

We may still want to provide a way to preserve filtered decks on import,
but to do that we'll need to ensure we don't rewrite the home decks of
cards, and we'll need to ensure the home decks are included as part of
the import (or give an error if they're not).

https://github.com/ankitects/anki/pull/1743/files#r839346423

* Fix a corner-case where due dates were shifted by a day

This issue existed in the old Python code as well. We need to include
the user's UTC offset in the exported file, or days_elapsed falls back
on the v1 cutoff calculation, which may be a day earlier or later than
the v2 calculation.

* Log conflicting note in remapped nt case

* take_fields() → into_fields()

* Alias `[u8; 20]` with `Sha1Hash`

* Truncate logged fields

* Rework apkg note import tests

- Use macros for more helpful errors.
- Split monolith into unit tests.
- Fix some unknown error with the previous test along the way.
(Was failing after 969484de4388d225c9f17d94534b3ba0094c3568.)

* Fix sorting of imported decks

Also adjust the test, so it fails without the patch. It was only passing
before, because the parent deck happened to come before the
inconsistently capitalised child alphabetically. But we want all parent
decks to be imported before their child decks, so their children can
adopt their capitalisation.

* target[_id]s → existing_card[_id]s

* export_collection_extracting_media() → ...

export_into_collection_file()

* target_already_exists→card_ordinal_already_exists

* Add search_cards_of_notes_into_table.sql

* Imrove type of apkg export selector/limit

* Remove redundant call to mod_schema()

* Parent tooltips to mw

* Fix a crash when truncating note text

String::truncate() is a bit of a footgun, and I've hit this before
too :-)

* Remove ExportLimit in favour of separate classes

* Remove OpWithBackendProgress and ClosedCollectionOp

Backend progress logic is now in ProgressManager. QueryOp can be used
for running on closed collection.

Also fix aborting of colpkg exports, which slipped through in #1817.

* Tidy up import log

* Avoid QDialog.exec()

* Default to excluding scheuling for deck list deck

* Use IncrementalProgress in whole import_export code

* Compare checksums when importing colpkgs

* Avoid registering changes if hashes are not needed

* ImportProgress::Collection → ImportProgress::File

* Make downgrading apkgs depend on meta version

* Generalise IncrementableProgress

And use it in entire import_export code instead.

* Fix type complexity lint

* Take count_map for IncrementableProgress::get_inner

* Replace import/export env with Shift click

* Accept all args from update() for backend progress

* Pass fields of ProgressUpdate explicitly

* Move update_interval into IncrementableProgress

* Outsource incrementing into Incrementor

* Mutate ProgressUpdate in progress_update callback

* Switch import/export legacy toggle to profile setting

Shift would have been nice, but the existing shortcuts complicate things.
If the user triggers an import with ctrl+shift+i, shift is unlikely to
have been released by the time our code runs, meaning the user accidentally
triggers the new code. We could potentially wait a while before bringing
up the dialog, but then we're forced to guess at how long it will take the
user to release the key.

One alternative would be to use alt instead of shift, but then we need to
trigger our shortcut when that key is pressed as well, and it could
potentially cause a conflict with an add-on that already uses that
combination.

* Show extension in export dialog

* Continue to provide separate options for schema 11+18 colpkg export

* Default to colpkg export when using File>Export

* Improve appearance of combo boxes when switching between apkg/colpkg

+ Deal with long deck names

* Convert newlines to spaces when showing fields from import

Ensures each imported note appears on a separate line

* Don't separate total note count from the other summary lines

This may come down to personal preference, but I feel the other counts
are equally as important, and separating them feels like it makes it
a bit easier to ignore them.

* Fix 'deck not normal' error when importing a filtered deck for the 2nd time

* Fix [Identical] being shown on first import

* Revert "Continue to provide separate options for schema 11+18 colpkg export"

This reverts commit 8f0b2c175f4794d642823b60414d142a12768441.

Will use a different approach

* Move legacy support into a separate exporter option; add to apkg export

* Adjust 'too new' message to also apply to .apkg import case

* Show a better message when attempting to import new apkg into old code

Previously the user could end seeing a message like:

UnicodeDecodeError: 'utf-8' codec can't decode byte 0xb5 in position 1: invalid start byte

Unfortunately we can't retroactively fix this for older clients.

* Hide legacy support option in older exporting screen

* Reflect change from paths to fnames in type & name

* Make imported decks normal at once

Then skip special casing in update_deck(). Also skip updating
description if new one is empty.

Co-authored-by: Damien Elmes <gpg@ankiweb.net>

## Working environment

The repository is checked out at `/app/anki` at this PR's **base commit**
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

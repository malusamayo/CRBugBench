# Code Review Task

You are a maintainer reviewing a pull request to the `servo/servo` repository.

**PR title:** WebIDL: Use `ArrayBuffer` instead of raw `JSObject` in bindings (#31202)

**PR description / commit message:**

WebIDL: Use `ArrayBuffer` instead of raw `JSObject` in bindings (#31202)

* WebIDL: Use ArrayBuffer instead of raw JSObject in bindings

Signed-off-by: Bentaimia Haddadi <haddadi.taym@gmail.com>

* Convert GPUBufferMapInfo mapping to Arc<Mutex>

* Remove #[allow(unsafe_code)] from GPUBuffer

* Add doc comments

* Implement trace for Arc<Mutex<Vec<T>>>

Signed-off-by: Bentaimia Haddadi <haddadi.taym@gmail.com>

* Use #[no_trace] for GPUBufferMapInfo.mapping

* Make create_new_external_array_buffer generic

Signed-off-by: Bentaimia Haddadi <haddadi.taym@gmail.com>

* Address review comments

* Remove HeapTypedArray::new and avoid cloning Arc

Signed-off-by: Bentaimia Haddadi <haddadi.taym@gmail.com>

* Use expect for GetMappedRange and ReadAsArrayBuffer

Signed-off-by: Bentaimia Haddadi <haddadi.taym@gmail.com>

* Use doc comments for FileReaderSyncMethods

Signed-off-by: Bentaimia Haddadi <haddadi.taym@gmail.com>

* Return for Error::JsFailed GetMappedRange and ReadAsArrayBuffer

Signed-off-by: Bentaimia Haddadi <haddadi.taym@gmail.com>

* Fix detached_internal implementation and comments

Signed-off-by: Bentaimia Haddadi <haddadi.taym@gmail.com>

* format code

Signed-off-by: Bentaimia Haddadi <haddadi.taym@gmail.com>

* Update expectations

---------

Signed-off-by: Bentaimia Haddadi <haddadi.taym@gmail.com>
Co-authored-by: sagudev <16504129+sagudev@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/servo` at this PR's **base commit**
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

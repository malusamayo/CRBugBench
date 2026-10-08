# Code Review Task

You are a maintainer reviewing a pull request to the `bevyengine/bevy` repository.

**PR title:** Introduce MovingPtr as a safer alternative to moving typed values by raw pointer (#20877)

**PR description / commit message:**

Introduce MovingPtr as a safer alternative to moving typed values by raw pointer (#20877)

# Objective
Make moving potentially large values, like those seen in #20571 and
those seen by #20772, safer and easier to review.

## Solution
Introduce `MovingPtr<'a, T>` as a wrapper around `NonNull<T>`. This
type:

 - Wraps a pointer and is thus cheap to pass through to functions.
- Acts like a `Box<T>` that does not own the allocation it points to. It
will drop the value it points to when it's dropped, but will not
deallocate when it's dropped.
- Acts like a `OwningPtr` in that it owns the values it points to and
has an associated lifetime, but it has a concrete type.
 - As it owns the value, it does not implement `Clone` or `Copy`.
- Does not support arbitrary pointer arithmetic other than to get
`MovingPtr`s of the value's fields.
- Does not support casting to types other than `ManuallyDrop<T>` and
`MaybeUninit<T>`.
- Has methods that consume the `MovingPtr` that copies the value into a
target pointer or reads it onto the stack.
- Provide unsafe functions for partially moving values of members out
and returns a `MovingPtr<'a, MaybeUninit<T>>` in its stead.
- Optionally supports unaligned pointers like `OwningPtr` for use cases
like #20593.
- Provides `From` impl for converting to `OwningPtr` to type erasure
without loss of the lifetime or alignment requirements.
- Provides a `TryFrom` impl to attempt to convert an unaligned instance
into a aligned one. Can be combined with `DebugCheckedUnwrap` to assert
that the conversion is sound.
- The `deconstruct_moving_ptr` provides a less error-prone way of
decomposing a `MovingPtr` into separate `MovingPtr` for its fields.

This design is loosely based on the outptr proposal for [in-place
construction](https://github.com/rust-lang/lang-team/issues/336#issuecomment-3049593105),
but currently eschews the requirements for a derive macro.

## Testing
CI, new doc tests pass.

---------

Co-authored-by: Alice Cecile <alice.i.cecile@gmail.com>
Co-authored-by: Giacomo Stevanato <giaco.stevanato@gmail.com>
Co-authored-by: Chris Russell <8494645+chescock@users.noreply.github.com>
Co-authored-by: Sandor <alexaegis@pm.me>

## Working environment

The repository is checked out at `/app/bevy` at this PR's **base commit**
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

# Code Review Task

You are a maintainer reviewing a pull request to the `bevyengine/bevy` repository.

**PR title:** Multiple Asset Sources (#9885)

**PR description / commit message:**

Multiple Asset Sources (#9885)

This adds support for **Multiple Asset Sources**. You can now register a
named `AssetSource`, which you can load assets from like you normally
would:

```rust
let shader: Handle<Shader> = asset_server.load("custom_source://path/to/shader.wgsl");
```

Notice that `AssetPath` now supports `some_source://` syntax. This can
now be accessed through the `asset_path.source()` accessor.

Asset source names _are not required_. If one is not specified, the
default asset source will be used:

```rust
let shader: Handle<Shader> = asset_server.load("path/to/shader.wgsl");
```

The behavior of the default asset source has not changed. Ex: the
`assets` folder is still the default.

As referenced in #9714

## Why?

**Multiple Asset Sources** enables a number of often-asked-for
scenarios:

* **Loading some assets from other locations on disk**: you could create
a `config` asset source that reads from the OS-default config folder
(not implemented in this PR)
* **Loading some assets from a remote server**: you could register a new
`remote` asset source that reads some assets from a remote http server
(not implemented in this PR)
* **Improved "Binary Embedded" Assets**: we can use this system for
"embedded-in-binary assets", which allows us to replace the old
`load_internal_asset!` approach, which couldn't support asset
processing, didn't support hot-reloading _well_, and didn't make
embedded assets accessible to the `AssetServer` (implemented in this pr)

## Adding New Asset Sources

An `AssetSource` is "just" a collection of `AssetReader`, `AssetWriter`,
and `AssetWatcher` entries. You can configure new asset sources like
this:

```rust
app.register_asset_source(
    "other",
    AssetSource::build()
        .with_reader(|| Box::new(FileAssetReader::new("other")))
    )
)
```

Note that `AssetSource` construction _must_ be repeatable, which is why
a closure is accepted.
`AssetSourceBuilder` supports `with_reader`, `with_writer`,
`with_watcher`, `with_processed_reader`, `with_processed_writer`, and
`with_processed_watcher`.

Note that the "asset source" system replaces the old "asset providers"
system.

## Processing Multiple Sources

The `AssetProcessor` now supports multiple asset sources! Processed
assets can refer to assets in other sources and everything "just works".
Each `AssetSource` defines an unprocessed and processed `AssetReader` /
`AssetWriter`.

Currently this is all or nothing for a given `AssetSource`. A given
source is either processed or it is not. Later we might want to add
support for "lazy asset processing", where an `AssetSource` (such as a
remote server) can be configured to only process assets that are
directly referenced by local assets (in order to save local disk space
and avoid doing extra work).

## A new `AssetSource`: `embedded`

One of the big features motivating **Multiple Asset Sources** was
improving our "embedded-in-binary" asset loading. To prove out the
**Multiple Asset Sources** implementation, I chose to build a new
`embedded` `AssetSource`, which replaces the old `load_interal_asset!`
system.

The old `load_internal_asset!` approach had a number of issues:

* The `AssetServer` was not aware of (or capable of loading) internal
assets.
* Because internal assets weren't visible to the `AssetServer`, they
could not be processed (or used by assets that are processed). This
would prevent things "preprocessing shaders that depend on built in Bevy
shaders", which is something we desperately need to start doing.
* Each "internal asset" needed a UUID to be defined in-code to reference
it. This was very manual and toilsome.

The new `embedded` `AssetSource` enables the following pattern:

```rust
// Called in `crates/bevy_pbr/src/render/mesh.rs`
embedded_asset!(app, "mesh.wgsl");

// later in the app
let shader: Handle<Shader> = asset_server.load("embedded://bevy_pbr/render/mesh.wgsl");
```

Notice that this always treats the crate name as the "root path", and it
trims out the `src` path for brevity. This is generally predictable, but
if you need to debug you can use the new `embedded_path!` macro to get a
`PathBuf` that matches the one used by `embedded_asset`.

You can also reference embedded assets in arbitrary assets, such as WGSL
shaders:

```rust
#import "embedded://bevy_pbr/render/mesh.wgsl"
```

This also makes `embedded` assets go through the "normal" asset
lifecycle. They are only loaded when they are actually used!

We are also discussing implicitly converting asset paths to/from shader
modules, so in the future (not in this PR) you might be able to load it
like this:

```rust
#import bevy_pbr::render::mesh::Vertex
```

Compare that to the old system!

```rust
pub const MESH_SHADER_HANDLE: Handle<Shader> = Handle::weak_from_u128(3252377289100772450);

load_internal_asset!(app, MESH_SHADER_HANDLE, "mesh.wgsl", Shader::from_wgsl);

// The mesh asset is the _only_ accessible via MESH_SHADER_HANDLE and _cannot_ be loaded via the AssetServer.
```

## Hot Reloading `embedded`

You can enable `embedded` hot reloading by enabling the
`embedded_watcher` cargo feature:

```
cargo run --features=embedded_watcher
```

## Improved Hot Reloading Workflow

First: the `filesystem_watcher` cargo feature has been renamed to
`file_watcher` for brevity (and to match the `FileAssetReader` naming
convention).

More importantly, hot asset reloading is no longer configured in-code by
default. If you enable any asset watcher feature (such as `file_watcher`
or `rust_source_watcher`), asset watching will be automatically enabled.

This removes the need to _also_ enable hot reloading in your app code.
That means you can replace this:

```rust
app.add_plugins(DefaultPlugins.set(AssetPlugin::default().watch_for_changes()))
```

with this:

```rust
app.add_plugins(DefaultPlugins)
```

If you want to hot reload assets in your app during development, just
run your app like this:

```
cargo run --features=file_watcher
```

This means you can use the same code for development and deployment! To
deploy an app, just don't include the watcher feature

```
cargo build --release
```

My intent is to move to this approach for pretty much all dev workflows.
In a future PR I would like to replace `AssetMode::ProcessedDev` with a
`runtime-processor` cargo feature. We could then group all common "dev"
cargo features under a single `dev` feature:

```sh
# this would enable file_watcher, embedded_watcher, runtime-processor, and more
cargo run --features=dev
```

## AssetMode

`AssetPlugin::Unprocessed`, `AssetPlugin::Processed`, and
`AssetPlugin::ProcessedDev` have been replaced with an `AssetMode` field
on `AssetPlugin`.

```rust
// before 
app.add_plugins(DefaultPlugins.set(AssetPlugin::Processed { /* fields here */ })

// after 
app.add_plugins(DefaultPlugins.set(AssetPlugin { mode: AssetMode::Processed, ..default() })
```

This aligns `AssetPlugin` with our other struct-like plugins. The old
"source" and "destination" `AssetProvider` fields in the enum variants
have been replaced by the "asset source" system. You no longer need to
configure the AssetPlugin to "point" to custom asset providers.

## AssetServerMode

To improve the implementation of **Multiple Asset Sources**,
`AssetServer` was made aware of whether or not it is using "processed"
or "unprocessed" assets. You can check that like this:

```rust
if asset_server.mode() == AssetServerMode::Processed {
    /* do something */
}
```

Note that this refactor should also prepare the way for building "one to
many processed output files", as it makes the server aware of whether it
is loading from processed or unprocessed sources. Meaning we can store
and read processed and unprocessed assets differently!

## AssetPath can now refer to folders

The "file only" restriction has been removed from `AssetPath`. The
`AssetServer::load_folder` API now accepts an `AssetPath` instead of a
`Path`, meaning you can load folders from other asset sources!

## Improved AssetPath Parsing

AssetPath parsing was reworked to support sources, improve error
messages, and to enable parsing with a single pass over the string.
`AssetPath::new` was replaced by `AssetPath::parse` and
`AssetPath::try_parse`.

## AssetWatcher broken out from AssetReader

`AssetReader` is no longer responsible for constructing `AssetWatcher`.
This has been moved to `AssetSourceBuilder`.


## Duplicate Event Debouncing

Asset V2 already debounced duplicate filesystem events, but this was
_input_ events. Multiple input event types can produce the same _output_
`AssetSourceEvent`. Now that we have `embedded_watcher`, which does
expensive file io on events, it made sense to debounce output events
too, so I added that! This will also benefit the AssetProcessor by
preventing integrity checks for duplicate events (and helps keep the
noise down in trace logs).

## Next Steps

* **Port Built-in Shaders**: Currently the primary (and essentially
only) user of `load_interal_asset` in Bevy's source code is "built-in
shaders". I chose not to do that in this PR for a few reasons:
1. We need to add the ability to pass shader defs in to shaders via meta
files. Some shaders (such as MESH_VIEW_TYPES) need to pass shader def
values in that are defined in code.
2. We need to revisit the current shader module naming system. I think
we _probably_ want to imply modules from source structure (at least by
default). Ideally in a way that can losslessly convert asset paths
to/from shader modules (to enable the asset system to resolve modules
using the asset server).
  3. I want to keep this change set minimal / get this merged first.
* **Deprecate `load_internal_asset`**: we can't do that until we do (1)
and (2)
* **Relative Asset Paths**: This PR significantly increases the need for
relative asset paths (which was already pretty high). Currently when
loading dependencies, it is assumed to be an absolute path, which means
if in an `AssetLoader` you call `context.load("some/path/image.png")` it
will assume that is the "default" asset source, _even if the current
asset is in a different asset source_. This will cause breakage for
AssetLoaders that are not designed to add the current source to whatever
paths are being used. AssetLoaders should generally not need to be aware
of the name of their current asset source, or need to think about the
"current asset source" generally. We should build apis that support
relative asset paths and then encourage using relative paths as much as
possible (both via api design and docs). Relative paths are also
important because they will allow developers to move folders around
(even across providers) without reprocessing, provided there is no path
breakage.

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

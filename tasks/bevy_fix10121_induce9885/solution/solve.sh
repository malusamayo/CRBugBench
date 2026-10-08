#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/bevy_asset/src/server/mod.rs`:

This pull request introduces the defect later reported as "Assets in folders with multi asset sources can only use primary source". The
problem a user observed, and its root cause:

## Bevy version

main (0.12), just after PR #9885 is committed

## What you did

I have 2 sources, registered as follow

```
    app.register_asset_source(
        AssetSourceId::Default,
        AssetSource::build().with_reader(|| Box::new(FileAssetReader::new(ASSET_PATH))),
    );
    app.register_asset_source(
        AssetSourceId::Name("packfile".into()),
        AssetSource::build().with_reader(|| Box::new(PackFileReader::new(ASSET_PATH))),
    );
```

When I try to load a folder in the setup system. 

```
fn setup(mut commands: Commands, assets: Res<AssetServer>) {
    commands.insert_resource(Handles {
        global_assets: assets.load_folder("packfile://global_assets.pak"),
    });
}
```

## What went wrong

My `PackFileReader` considers pack files as a directory and starts reading the "directory" with read_directory and returns 1 file which is attempted to be loaded, eventually reaching this function https://github.com/bevyengine/bevy/blob/35073cf7aa9eaf748e167c103921a6764fcedfb1/crates/bevy_asset/src/server/mod.rs#L676 . At that point path is `global_assets.pak/internal_file.bmp` and has lost the `packfile://` and the source/reader resolves to the default one, not the `packfile`. 

## Additional information

Most of the AssetReader functions use Path and PathBuf instead of AssetPath, so it is easy to lose the source info

This same root cause must be fixed before merging.
REVIEW_EOF

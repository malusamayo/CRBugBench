#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/bevy_asset/src/io/embedded/mod.rs`:

This pull request introduces the defect later reported as "`embedded_asset!` panics on `unwrap` during path manipulation". The
problem a user observed, and its root cause:

## Bevy version

0.12.0

## What you did

```rust
pub struct TriplanarMaterialPlugin;

impl Plugin for TriplanarMaterialPlugin {
    fn build(&self, app: &mut App) {
        app.add_plugins(MaterialPlugin::<TriplanarMaterial>::default());

        embedded_asset!(app, "shaders/triplanar.wgsl");
        embedded_asset!(app, "shaders/biplanar.wgsl");
    }
}
```

## What went wrong

```
thread 'main' panicked at src/plugin.rs:11:9:
called `Option::unwrap()` on a `None` value
```

## Additional information

### Root Cause

I believe the root cause it trying to split a path string by "/src/" when the path does not even contain that substring.

Here's the implementation:

```rust
macro_rules! embedded_path {
    ($path_str: expr) => {{
        embedded_path!("/src/", $path_str)
    }};

    ($source_path: expr, $path_str: expr) => {{
        let crate_name = module_path!().split(':').next().unwrap();
        let after_src = file!().split($source_path).nth(1).unwrap();
        let file_path = std::path::Path::new(after_src)
            .parent()
            .unwrap()
            .join($path_str);
        std::path::Path::new(crate_name).join(file_path)
    }};
}
```

This line is where the panic happens:

```rust
        let after_src = file!().split($source_path).nth(1).unwrap();
```

The issue is `$source_path = "/src/"` while `file!() = "src/plugin.rs"`. Splitting will produce only one element from the iterator, so `nth(1)` will be `None`.

### Solution

Generally it's a bad idea to do path manipulation with raw strings when you could use `Path` or `PathBuf` instead, and I recommend eliminating any use of "/" (it's not portable), e.g. in `"/src/"`. So my suggested solution is to convert strings into `PathBuf` as soon as possible and do manipulation after that.

This same root cause must be fixed before merging.
REVIEW_EOF

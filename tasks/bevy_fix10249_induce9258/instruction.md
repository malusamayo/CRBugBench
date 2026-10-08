# Code Review Task

You are a maintainer reviewing a pull request to the `bevyengine/bevy` repository.

**PR title:** Deferred Renderer (#9258)

**PR description / commit message:**

Deferred Renderer (#9258)

# Objective

- Add a [Deferred
Renderer](https://en.wikipedia.org/wiki/Deferred_shading) to Bevy.
- This allows subsequent passes to access per pixel material information
before/during shading.
- Accessing this per pixel material information is needed for some
features, like GI. It also makes other features (ex. Decals) simpler to
implement and/or improves their capability. There are multiple
approaches to accomplishing this. The deferred shading approach works
well given the limitations of WebGPU and WebGL2.

Motivation: [I'm working on a GI solution for
Bevy](https://youtu.be/eH1AkL-mwhI)

# Solution
- The deferred renderer is implemented with a prepass and a deferred
lighting pass.
- The prepass renders opaque objects into the Gbuffer attachment
(`Rgba32Uint`). The PBR shader generates a `PbrInput` in mostly the same
way as the forward implementation and then [packs it into the
Gbuffer](https://github.com/DGriffin91/bevy/blob/ec1465559f2c82001830e908fc02ff1d7c2efe51/crates/bevy_pbr/src/render/pbr.wgsl#L168).
- The deferred lighting pass unpacks the `PbrInput` and [feeds it into
the pbr()
function](https://github.com/DGriffin91/bevy/blob/ec1465559f2c82001830e908fc02ff1d7c2efe51/crates/bevy_pbr/src/deferred/deferred_lighting.wgsl#L65),
then outputs the shaded color data.

- There is now a resource
[DefaultOpaqueRendererMethod](https://github.com/DGriffin91/bevy/blob/ec1465559f2c82001830e908fc02ff1d7c2efe51/crates/bevy_pbr/src/material.rs#L599)
that can be used to set the default render method for opaque materials.
If materials return `None` from
[opaque_render_method()](https://github.com/DGriffin91/bevy/blob/ec1465559f2c82001830e908fc02ff1d7c2efe51/crates/bevy_pbr/src/material.rs#L131)
the `DefaultOpaqueRendererMethod` will be used. Otherwise, custom
materials can also explicitly choose to only support Deferred or Forward
by returning the respective
[OpaqueRendererMethod](https://github.com/DGriffin91/bevy/blob/ec1465559f2c82001830e908fc02ff1d7c2efe51/crates/bevy_pbr/src/material.rs#L603)

- Deferred materials can be used seamlessly along with both opaque and
transparent forward rendered materials in the same scene. The [deferred
rendering
example](https://github.com/DGriffin91/bevy/blob/deferred/examples/3d/deferred_rendering.rs)
does this.

- The deferred renderer does not support MSAA. If any deferred materials
are used, MSAA must be disabled. Both TAA and FXAA are supported.

- Deferred rendering supports WebGL2/WebGPU. 

## Custom deferred materials
- Custom materials can support both deferred and forward at the same
time. The
[StandardMaterial](https://github.com/DGriffin91/bevy/blob/ec1465559f2c82001830e908fc02ff1d7c2efe51/crates/bevy_pbr/src/render/pbr.wgsl#L166)
does this. So does [this
example](https://github.com/DGriffin91/bevy_glowy_orb_tutorial/blob/deferred/assets/shaders/glowy.wgsl#L56).
- Custom deferred materials that require PBR lighting can create a
`PbrInput`, write it to the deferred GBuffer and let it be rendered by
the `PBRDeferredLightingPlugin`.
- Custom deferred materials that require custom lighting have two
options:
1. Use the base_color channel of the `PbrInput` combined with the
`STANDARD_MATERIAL_FLAGS_UNLIT_BIT` flag.
[Example.](https://github.com/DGriffin91/bevy_glowy_orb_tutorial/blob/deferred/assets/shaders/glowy.wgsl#L56)
(If the unlit bit is set, the base_color is stored as RGB9E5 for extra
precision)
2. A Custom Deferred Lighting pass can be created, either overriding the
default, or running in addition. The a depth buffer is used to limit
rendering to only the required fragments for each deferred lighting
pass. Materials can set their respective depth id via the
[deferred_lighting_pass_id](https://github.com/DGriffin91/bevy/blob/b79182d2a32cac28c4213c2457a53ac2cc885332/crates/bevy_pbr/src/prepass/prepass_io.wgsl#L95)
attachment. The custom deferred lighting pass plugin can then set [its
corresponding
depth](https://github.com/DGriffin91/bevy/blob/ec1465559f2c82001830e908fc02ff1d7c2efe51/crates/bevy_pbr/src/deferred/deferred_lighting.wgsl#L37).
Then with the lighting pass using
[CompareFunction::Equal](https://github.com/DGriffin91/bevy/blob/ec1465559f2c82001830e908fc02ff1d7c2efe51/crates/bevy_pbr/src/deferred/mod.rs#L335),
only the fragments with a depth that equal the corresponding depth
written in the material will be rendered.

Custom deferred lighting plugins can also be created to render the
StandardMaterial. The default deferred lighting plugin can be bypassed
with `DefaultPlugins.set(PBRDeferredLightingPlugin { bypass: true })`

---------

Co-authored-by: nickrart <nickolas.g.russell@gmail.com>

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

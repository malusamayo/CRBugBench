#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `candle-core/src/cpu_backend/conv2d.rs`:

This pull request introduces the defect later reported as "conv2d_tiled produces incorrect results compared to conv2d_im2col_gemm (CPU backend)". The
problem a user observed, and its root cause:

## Bug Description

`conv2d_tiled` (the default CPU conv2d implementation) produces **incorrect results** that differ significantly from both PyTorch and candle's own `conv2d_im2col_gemm` implementation. The error is not a small floating-point precision difference — output values are **completely wrong** (max diff ~2.4 on outputs with magnitude ~0.27).

## Minimal Reproduction

```rust
use candle_core::{DType, Device, Module, Result, Tensor, Var};
use candle_nn::{Conv2dConfig, VarBuilder, VarMap};

fn main() -> Result<()> {
    let device = &Device::Cpu;

    // Create input [1, 64, 64, 64] and Conv2d(64 -> 384, 3x3, pad=1) with fixed weights
    let input = Tensor::randn(0f32, 1.0, (1, 64, 64, 64), device)?;
    
    // Create conv with random weights
    let varmap = VarMap::new();
    let vb = VarBuilder::from_varmap(&varmap, DType::F32, device);
    let conv = candle_nn::conv2d(64, 384, 3, Conv2dConfig { padding: 1, ..Default::default() }, vb)?;
    
    // Run forward
    let output = conv.forward(&input)?;
    
    // Save input, weight, output as safetensors
    // Then load in PyTorch and compare - they will differ significantly
    println!("Output shape: {:?}", output.dims());
    println!("Output abs_mean: {:.6}", output.to_dtype(DType::F64)?.abs()?.mean_all()?.to_scalar::<f64>()?);
    Ok(())
}
```

## How to Reproduce (Cross-Framework Comparison)

### Step 1: Generate reference data from PyTorch
```python
import torch
from safetensors.torch import save_file

torch.manual_seed(42)
x = torch.randn(1, 64, 64, 64)
conv = torch.nn.Conv2d(64, 384, 3, stride=1, padding=1)
with torch.no_grad():
    y = conv(x)

save_file({
    'input': x,
    'weight': conv.weight.contiguous(),
    'bias': conv.bias.contiguous(),
    'output': y,
}, 'conv2d_test.safetensors')
print(f'PyTorch output first 5: {y.flatten()[:5].tolist()}')
```

### Step 2: Load in Candle and compare
```rust
// Load safetensors, create Conv2d with same weights, run forward
// Candle output will differ from PyTorch output by max_diff ~2.4
```

## Root Cause

The issue is in `conv2d_tiled` at `candle-core/src/cpu_backend/conv2d.rs`.

### Proof: Switching to `FullIm2Col` fixes the issue

Changing line 21:
```rust
// BEFORE (broken):
const DEFAULT_CONV2D_IMPL: Conv2dImpl = Conv2dImpl::TiledIm2Col;

// AFTER (correct):
const DEFAULT_CONV2D_IMPL: Conv2dImpl = Conv2dImpl::FullIm2Col;
```

With `FullIm2Col`, the same test produces max_diff=**1.6e-6** (correct fp32 precision).

### Analysis

The `conv2d_tiled` implementation converts the input to NHWC layout and uses a `(c_in, kh, kw)` ordering for im2col patches and kernel flattening (lines 172-181, 217-243). While this should be mathematically equivalent to the standard `(kh, kw, c_in)` ordering, the tiled implementation appears to have a correctness bug in how it interacts with the matmul.

Specifically, the kernel is flattened as `[c_out, kh * kw * c_in]` with `c_in` as the innermost dimension (line 172-181), and the im2col column is built with `c_in` as the innermost dimension too (line 218). This pairing should be correct, but the resulting matmul gives wrong answers for certain channel/spatial configurations.

## Impact

This affects any Conv2d where:
- kernel size > 1x1 (1x1 convs use a separate fast path)
- The combination of in_channels, out_channels, and spatial size triggers the tiled path

In practice, this breaks inference for models with decoder stages that use 3x3 convolutions at medium-to-large spatial resolutions. We discovered this while implementing [BiRefNet](https://github.com/ZhengPeng7/BiRefNet) inference — the model produces correct output at 384x384 (where errors don't accumulate enough to matter) but completely wrong output at 1024x1024.

## Measured Results

| Implementation | max_diff vs PyTorch |
|---------------|-------------------|
| `TiledIm2Col` (default) | **2.396** |
| `FullIm2Col` | **1.6e-6** |
| `Direct` | (not tested) |

## Environment

- candle-core 0.9.2 (also verified on git main — same code)
- CPU backend (macOS ARM64)
- Rust 1.93.1

This same root cause must be fixed before merging.
REVIEW_EOF

#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `candle-metal-kernels/src/kernels/mod.rs`:

This pull request introduces the defect later reported as "Error with candle-nn on latest Metal Refactor". The
problem a user observed, and its root cause:

Just updated candle to use the new metal refactor and were getting an error on compilation
```
candle-nn v0.9.1 (https://github.com/huggingface/candle.git#87fadf67)
error[E0432]: unresolved import `candle_metal_kernels::SdpaDType`
    --> /Users/pro/.cargo/git/checkouts/candle-5b4d092929d18d36/87fadf6/candle-nn/src/ops.rs:1016:13
     |
1016 |         use candle_metal_kernels::SdpaDType;
     |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ no `SdpaDType` in the root
     |
help: consider importing this enum instead
     |
1016 |         use candle_metal_kernels::kernels::sdpa::SdpaDType;
     |                                   +++++++++++++++

error[E0425]: cannot find value `SDPA_2PASS_BLOCKS` in crate `candle_metal_kernels`
    --> /Users/pro/.cargo/git/checkouts/candle-5b4d092929d18d36/87fadf6/candle-nn/src/ops.rs:1094:45
     |
1094 |                     &[candle_metal_kernels::SDPA_2PASS_BLOCKS],
     |                                             ^^^^^^^^^^^^^^^^^ not found in `candle_metal_kernels`
     |
help: consider importing this constant
     |
4    + use candle_metal_kernels::kernels::sdpa::SDPA_2PASS_BLOCKS;
     |
help: if you import `SDPA_2PASS_BLOCKS`, refer to it directly
     |
1094 -                     &[candle_metal_kernels::SDPA_2PASS_BLOCKS],
1094 +                     &[SDPA_2PASS_BLOCKS],
     |

error[E0425]: cannot find function `call_sdpa_vector_2pass` in crate `candle_metal_kernels`
    --> /Users/pro/.cargo/git/checkouts/candle-5b4d092929d18d36/87fadf6/candle-nn/src/ops.rs:1116:39
     |
1116 |                 candle_metal_kernels::call_sdpa_vector_2pass(
     |                                       ^^^^^^^^^^^^^^^^^^^^^^ not found in `candle_metal_kernels`
     |
help: consider importing this function
     |
4    + use candle_metal_kernels::kernels::call_sdpa_vector_2pass;
     |
help: if you import `call_sdpa_vector_2pass`, refer to it directly
     |
1116 -                 candle_metal_kernels::call_sdpa_vector_2pass(
1116 +                 call_sdpa_vector_2pass(
     |

error[E0425]: cannot find function `call_sdpa_vector` in crate `candle_metal_kernels`
    --> /Users/pro/.cargo/git/checkouts/candle-5b4d092929d18d36/87fadf6/candle-nn/src/ops.rs:1141:39
     |
1141 |                 candle_metal_kernels::call_sdpa_vector(
     |                                       ^^^^^^^^^^^^^^^^ not found in `candle_metal_kernels`
     |
help: consider importing this function
     |
4    + use candle_metal_kernels::kernels::call_sdpa_vector;
     |
help: if you import `call_sdpa_vector`, refer to it directly
     |
1141 -                 candle_metal_kernels::call_sdpa_vector(
1141 +                 call_sdpa_vector(
     |

error[E0425]: cannot find function `call_sdpa_full` in crate `candle_metal_kernels`
    --> /Users/pro/.cargo/git/checkouts/candle-5b4d092929d18d36/87fadf6/candle-nn/src/ops.rs:1170:35
     |
1170 |             candle_metal_kernels::call_sdpa_full(
     |                                   ^^^^^^^^^^^^^^ not found in `candle_metal_kernels`
     |
help: consider importing this function
     |
4    + use candle_metal_kernels::kernels::call_sdpa_full;
     |
help: if you import `call_sdpa_full`, refer to it directly
     |
1170 -             candle_metal_kernels::call_sdpa_full(
1170 +             call_sdpa_full(
     |

Some errors have detailed explanations: E0425, E0432.
For more information about an error, try `rustc --explain E0425`.
error: could not compile `candle-nn` (lib) due to 5 previous errors
warning: build failed, waiting for other jobs to finish...
failed to build app: failed to build app
       Error failed to build app: failed to build app
```

This same root cause must be fixed before merging.
REVIEW_EOF

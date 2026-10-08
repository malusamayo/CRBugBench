#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `candle-kernels/build.rs`:

This pull request introduces the defect later reported as "fatal error LNK1181: cannot open input file 'stdc++.lib'". The
problem a user observed, and its root cause:

Hi, I’m trying to build Candle on Windows 10 using Rust + MSVC (Visual Studio 2022) and CUDA 12.4. The compilation fails at the linking stage with the following error:
```
Compiling candle-core v0.9.2-alpha.2 (https://github.com/huggingface/candle.git#3a0d1cb8)
   Compiling candle-nn v0.9.2-alpha.2 (https://github.com/huggingface/candle.git#3a0d1cb8)
   Compiling candle_study v0.1.0 (C:\Users\forwardwu\work\project\candle_study)
warning: unused imports: `Device` and `Tensor`
 --> src\main.rs:1:19
  |
1 | use candle_core::{Device, Tensor};
  |                   ^^^^^^  ^^^^^^
  |
  = note: `#[warn(unused_imports)]` on by default

error: linking with `link.exe` failed: exit code: 1181
  |
  = note: "C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\VC\\Tools\\MSVC\\14.44.35207\\bin\\HostX64\\x64\\link.exe" "/NOLOGO" "C:\\Users\\forwardwu\\AppData\\Local\\Temp\\rustc0VGTGY\\symbols.o" "<6 object files omitted>" "C:\\Users\\forwardwu\\work\\project\\candle_study\\target\\debug\\deps/{libcandle_core-defad7136f40b4bd.rlib,libnum_cpus-fb4bedbc89b6c65e.rlib,libmemmap2-1a104ce6159f3e7d.rlib,libzip-96aabb13c9c207ce.rlib,libnum_enum-d9a5ddcf8625d23a.rlib,libindexmap-8196c6cd1a46178c.rlib,libequivalent-bf69e0f47555a7c9.rlib,libhashbrown-78fe8637e38de651.rlib,libcrc32fast-71a45df3ee6cf5c6.rlib,liblibm-c094bc53944490a0.rlib,libyoke-8ee347f3d67901c0.rlib,libzerofrom-137c62df912d1c9a.rlib,libstable_deref_trait-aead5694995e730e.rlib,libthiserror-438b9df441ada32c.rlib,libsafetensors-47bcd857b195e7b2.rlib,libserde_json-3cee723f471d6a2f.rlib,libmemchr-2cd46ac577d0962f.rlib,libitoa-096fe2954bef827f.rlib,libzmij-56419acc4c63d091.rlib,libserde-e4f5c2a4b6143820.rlib,libserde_core-8e650f168ee0310d.rlib,libcandle_kernels-35ceac14c81b24a0.rlib,libgemm-cf07450227f8c0f2.rlib,libgemm_c32-bfe50b76cedcc10f.rlib,libgemm_c64-add0c834370d618a.rlib,libgemm_f64-fc0373deb56498bb.rlib,libgemm_f16-5a1a69c143607f13.rlib,libgemm_f32-10b2315d7ac4d938.rlib,libgemm_common-74f66b67db673a00.rlib,libonce_cell-485667af4506d079.rlib,libpulp-626e6614a6c39baa.rlib,libnum_complex-a379284e38646cb7.rlib,libdyn_stack-70db6032df0ba730.rlib,libraw_cpuid-77a0f48e5468c7af.rlib,libbitflags-cadd31b582ebeba7.rlib,librayon-1b6ff3cf3cab7229.rlib,librayon_core-bbf6712e6f6f40d5.rlib,libcrossbeam_deque-8f6e4ff6017d09f7.rlib,libcrossbeam_epoch-4930b4541c48175a.rlib,libcrossbeam_utils-865a02ad4258a230.rlib,libeither-acc143748f92fce5.rlib,libfloat8-2f46064d9dab99ad.rlib,libcudarc-c87291e338078bce.rlib,libfloat8-eb494090bbc87020.rlib,liblibloading-2b3d51d5a696f685.rlib,libwindows_link-57fe558fbc78bd39.rlib,libbyteorder-00f3406578538545.rlib,libhalf-53e713a9936c66be.rlib,librand_distr-0bf1208c6b217867.rlib,librand-2409884470a6879e.rlib,librand_chacha-182b86daa9e3d3c8.rlib,libppv_lite86-c860634437473f53.rlib,librand_core-f9f29678a89224c6.rlib,libgetrandom-bd486248ad9da3f6.rlib,libcfg_if-59068db8513376d0.rlib,libnum_traits-7636d3f16dc572ea.rlib,libzerocopy-8aa25e7d473bf448.rlib,libbytemuck-c3777a8c59eea552.rlib}.rlib" "<sysroot>\\lib\\rustlib\\x86_64-pc-windows-msvc\\lib/{libstd-*,libpanic_unwind-*,libwindows_targets-*,librustc_demangle-*,libstd_detect-*,libhashbrown-*,librustc_std_workspace_alloc-*,libunwind-*,libcfg_if-*,librustc_std_workspace_core-*,liballoc-*,libcore-*,libcompiler_builtins-*}.rlib" "C:\\Users\\forwardwu\\work\\project\\candle_study\\target\\debug\\build\\candle-kernels-064d077d6139e19f\\out\\libmoe.a" "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v12.4\\lib/x64\\cudart.lib" "stdc++.lib" "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v12.4\\lib/x64\\cuda.lib" "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v12.4\\lib/x64\\nvrtc.lib" "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v12.4\\lib/x64\\curand.lib" "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v12.4\\lib/x64\\cublas.lib" "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v12.4\\lib/x64\\cublasLt.lib" "kernel32.lib" "kernel32.lib" "kernel32.lib" "ntdll.lib" "userenv.lib" "ws2_32.lib" "dbghelp.lib" "/defaultlib:msvcrt" "/NXCOMPAT" "/LIBPATH:C:\\Users\\forwardwu\\work\\project\\candle_study\\target\\debug\\build\\candle-kernels-064d077d6139e19f\\out" "/LIBPATH:C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v12.4\\lib" "/LIBPATH:C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v12.4\\lib/x64" "/LIBPATH:C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v12.4\\lib/Win32" "/OUT:C:\\Users\\forwardwu\\work\\project\\candle_study\\target\\debug\\deps\\candle_study.exe" "/OPT:REF,NOICF" "/DEBUG" "/PDBALTPATH:%_PDB%" "/NATVIS:<sysroot>\\lib\\rustlib\\etc\\intrinsic.natvis" "/NATVIS:<sysroot>\\lib\\rustlib\\etc\\liballoc.natvis" "/NATVIS:<sysroot>\\lib\\rustlib\\etc\\libcore.natvis" "/NATVIS:<sysroot>\\lib\\rustlib\\etc\\libstd.natvis"
  = note: some arguments are omitted. use `--verbose` to show all linker arguments
  = note: LINK : fatal error LNK1181: cannot open input file 'stdc++.lib'␍
```

This same root cause must be fixed before merging.
REVIEW_EOF

#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/vmm/src/arch/x86_64/xstate.rs`:

This pull request introduces the defect later reported as "[Bug] VM Failing to start on XSTATE check". The
problem a user observed, and its root cause:

# Describe the bug

On trying to start a VM, we get this error from Firecracker (v1.13.1):

```
RunWithApiError error: 
  Failed to build MicroVM from Json:
  Could not Start MicroVM from one single json:
  Kvm error:
    Architecture specific error:
      Failed to request permission for dynamic XSTATE features:
        Failed to request permission for XSTATE feature (18):
          Invalid argument (os error 22)
Error: RunWithApi(BuildFromJson(StartMicroVM(Kvm(ArchError(XstateFeatures(RequestFeaturePermission(18, Os { code: 22, kind: InvalidInput, message: "Invalid argument" })))))))
```

## To Reproduce

It appears that this happens on older kernels (pre-5.16) running on CPUs that support AMX. The supported flags apparently returns TILE_DATA, but that flag is greater than XFEATURE_MAX (https://github.com/torvalds/linux/blame/master/arch/x86/include/asm/fpu/types.h#L130) in the kernel, so attempting to request permissions fails with EINVAL 

## Expected behaviour

Should boot successfully.

## Environment

- Firecracker version: 1.13.1
- Host and guest kernel versions: 5.15.0-1090-aws; failure is before guest kernel starts
- Rootfs used: not used
- Architecture: x86_64 -- works on 8252C but fails on 8488C
- Any other relevant software versions:

## Additional context

This is in a cloud environment where we do not have strict control over CPU models

## Checks

- [X] Have you searched the Firecracker Issues database for similar problems?
- [X] Have you read the existing relevant Firecracker documentation?
- [~] Are you certain the bug being reported is a Firecracker issue?
   - This seems like it could be more of a kernel issue; it is saying that it supports a flag but erroring on its use

This same root cause must be fixed before merging.
REVIEW_EOF

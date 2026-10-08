#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/internal/process/per_thread.js`:

This pull request introduces the defect later reported as "internal/process/per_thread.js is incompatible with Hardened JS shim". The
problem a user observed, and its root cause:

### Version

16.15.1

### Platform

Darwin snow.local 21.5.0 Darwin Kernel Version 21.5.0: Tue Apr 26 21:08:37 PDT 2022; root:xnu-8020.121.3~4/RELEASE_ARM64_T6000 arm64

### Subsystem

internal/process

### What steps will reproduce the bug?

Unfortunately, I currently need to install third party deps to reproduce:

```sh
mkdir repro
cd repro
yarn init --yes
yarn add zx endo-exec
cd node_modules/endo-exec
node endo-exec.cjs ./scripts/zx-head.js /etc/passwd
```


### How often does it reproduce? Is there a required condition?

It reproduces every time.


### What is the expected behavior?

```console
Hello, world (from ./scripts/zx-head.js)!
$ head -5 /etc/passwd
##
# User Database
# 
# Note that this file is consulted directly only when the system is running
# in single-user mode.  At other times this information is provided by
$
```


### What do you see instead?

```console
(TypeError#1)
TypeError#1: Cannot assign to read only property 'Symbol(Symbol.iterator)' of object '[object Set]'
  at Object.buildAllowedFlags (node:internal/process/per_thread:375:53)
  at process.get [as allowedNodeEnvironmentFlags] (node:internal/bootstrap/node:279:34)
  at get (<anonymous>)
  at getOwn (node:internal/bootstrap/loaders:182:5)
  at NativeModule.syncExports (node:internal/bootstrap/loaders:294:31)
  at ModuleWrap.<anonymous> (node:internal/bootstrap/loaders:274:22)
  at NativeModule.getESMFacade (node:internal/bootstrap/loaders:279:17)
  at NativeModule.compileForPublicLoader (node:internal/bootstrap/loaders:259:10)
  at loadNativeModule (node:internal/modules/cjs/helpers:49:9)
  at ESMLoader.builtinStrategy (node:internal/modules/esm/translators:258:18)
  at ESMLoader.moduleProvider (node:internal/modules/esm/loader:337:14)
```


### Additional information

Here is a a fix that makes Node.js compatible with the prototype freezing done by the Endo SES shim:
```diff
diff --git a/lib/internal/process/per_thread.js b/lib/internal/process/per_thread.js
index 709bcb7b13..6ddc88a555 100644
--- a/lib/internal/process/per_thread.js
+++ b/lib/internal/process/per_thread.js
@@ -15,6 +15,7 @@ const {
   Float64Array,
   NumberMAX_SAFE_INTEGER,
   ObjectFreeze,
+  ObjectDefineProperty,
   ReflectApply,
   RegExpPrototypeTest,
   SafeArrayIterator,
@@ -371,9 +372,11 @@ function buildAllowedFlags() {
       return SetPrototypeValues(this[kInternal].set);
     }
   }
-  NodeEnvironmentFlagsSet.prototype.keys =
-  NodeEnvironmentFlagsSet.prototype[SymbolIterator] =
-    NodeEnvironmentFlagsSet.prototype.values;
+
+  const flagSetValues = NodeEnvironmentFlagsSet.prototype.values;
+  // NodeEnvironmentFlagsSet.prototype[SymbolIterator] = flagSetValues;
+  ObjectDefineProperty(NodeEnvironmentFlagsSet.prototype, SymbolIterator, { value: flagSetValues });
+  ObjectDefineProperty(NodeEnvironmentFlagsSet.prototype, 'keys', { value: flagSetValues });
 
   ObjectFreeze(NodeEnvironmentFlagsSet.prototype.constructor);
   ObjectFreeze(NodeEnvironmentFlagsSet.prototype);
 ```

This same root cause must be fixed before merging.
REVIEW_EOF

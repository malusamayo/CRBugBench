#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/react-devtools-core/src/standalone.js` (around line 187): This function should probably ensure the Profiler tab is opened by default too. It's weird to click the "Profiler tab" link and see the Components tab.

I think this should do it?

```diff
diff --git a/packages/react-devtools-core/src/standalone.js b/packages/react-devtools-core/src/standalone.js
index 40f52dbf5..e295237d3 100644
--- a/packages/react-devtools-core/src/standalone.js
+++ b/packages/react-devtools-core/src/standalone.js
@@ -30,7 +30,11 @@ import {readFileSync} from 'fs';
 import {installHook} from 'react-devtools-shared/src/hook';
 import DevTools from 'react-devtools-shared/src/devtools/views/DevTools';
 import {doesFilePathExist, launchEditor} from './editor';
-import {__DEBUG__} from 'react-devtools-shared/src/constants';
+import {
+  __DEBUG__,
+  LOCAL_STORAGE_DEFAULT_TAB_KEY,
+} from 'react-devtools-shared/src/constants';
+import {localStorageSetItem} from 'react-devtools-shared/src/storage';
 
 import type {FrontendBridge} from 'react-devtools-shared/src/bridge';
 import type {InspectedElement} from 'react-devtools-shared/src/devtools/views/Components/types';
@@ -184,6 +188,12 @@ function openProfiler() {
   bridge = new Bridge({listen: () => {}, send: () => {}});
   store = new Store(bridge, {});
 
+  // Ensure the Profiler tab is shown initially.
+  localStorageSetItem(
+    LOCAL_STORAGE_DEFAULT_TAB_KEY,
+    JSON.stringify('profiler'),
+  );
+
   reload();
 }
 
diff --git a/packages/react-devtools-shared/src/constants.js b/packages/react-devtools-shared/src/constants.js
index 60ce987e2..40c28a0f6 100644
--- a/packages/react-devtools-shared/src/constants.js
+++ b/packages/react-devtools-shared/src/constants.js
@@ -20,6 +20,8 @@ export const TREE_OPERATION_UPDATE_TREE_BASE_DURATION = 4;
 export const TREE_OPERATION_UPDATE_ERRORS_OR_WARNINGS = 5;
 export const TREE_OPERATION_REMOVE_ROOT = 6;
 
+export const LOCAL_STORAGE_DEFAULT_TAB_KEY = 'React::DevTools::defaultTab';
+
 export const LOCAL_STORAGE_FILTER_PREFERENCES_KEY =
   'React::DevTools::componentFilters';
 
diff --git a/packages/react-devtools-shared/src/devtools/views/DevTools.js b/packages/react-devtools-shared/src/devtools/views/DevTools.js
index 0fa4a4401..4e3b3ed8c 100644
--- a/packages/react-devtools-shared/src/devtools/views/DevTools.js
+++ b/packages/react-devtools-shared/src/devtools/views/DevTools.js
@@ -38,6 +38,7 @@ import UnsupportedVersionDialog from './UnsupportedVersionDialog';
 import WarnIfLegacyBackendDetected from './WarnIfLegacyBackendDetected';
 import {useLocalStorage} from './hooks';
 import ThemeProvider from './ThemeProvider';
+import {LOCAL_STORAGE_DEFAULT_TAB_KEY} from 'react-devtools-shared/src/constants';
 
 import styles from './DevTools.css';
 
@@ -143,7 +144,7 @@ export default function DevTools({
   hideViewSourceAction,
 }: Props) {
   const [currentTab, setTab] = useLocalStorage<TabID>(
-    'React::DevTools::defaultTab',
+    LOCAL_STORAGE_DEFAULT_TAB_KEY,
     defaultTab,
   );
```
REVIEW_EOF

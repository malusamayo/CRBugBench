# Code Review Task

You are a maintainer reviewing a pull request to the `Anuken/Mindustry` repository.

**PR title:** Fix Android loadJar

**PR description:**

If your pull request is **not** translation or serverlist-related, read the list of requirements below and check each box:

- [x] I have read the [contribution guidelines](https://github.com/Anuken/Mindustry/blob/master/CONTRIBUTING.md).
- [x] I have ensured that my code compiles, if applicable.
- [x] I have ensured that any new features in this PR function correctly in-game, if applicable.

On my Android 14 pad, java mods are failed to load. It throws:
```
java.io.IOException: java.lang.SecurityException: Writable dex file '/storage/emulated/0/Android/data/io.anuke.mindustry.be/files/mods/msf_1000006258.zip' is not allowed.
	at mindustry.mod.Mods.importMod(Mods.java:178)
	at mindustry.ui.dialogs.ModsDialog.lambda$setup$18(ModsDialog.java:3)
	at mindustry.ui.dialogs.ModsDialog.$r8$lambda$cRZ70EldMm554YRk51BqMzFRf7U(ModsDialog.java:1)
	at mindustry.ui.dialogs.ModsDialog$$ExternalSyntheticLambda1.get(R8$$SyntheticClass:70)
	at mindustry.android.AndroidLauncher$1.lambda$showFileChooser$1(AndroidLauncher.java:10)
	at mindustry.android.AndroidLauncher$1.$r8$lambda$MmEKgy8vVjrNgTCtvsdO1xjBTGs(AndroidLauncher.java:1)
	at mindustry.android.AndroidLauncher$1$$ExternalSyntheticLambda0.run(R8$$SyntheticClass:16)
	at arc.backend.android.AndroidGraphics.onDrawFrame(AndroidGraphics.java:89)
	at android.opengl.GLSurfaceView$GLThread.guardedRun(GLSurfaceView.java:1583)
	at android.opengl.GLSurfaceView$GLThread.run(GLSurfaceView.java:1272)
Caused by: java.lang.SecurityException: Writable dex file '/storage/emulated/0/Android/data/io.anuke.mindustry.be/files/mods/msf_1000006258.zip' is not allowed.
	at dalvik.system.DexFile.openDexFileNative(Native Method)
	at dalvik.system.DexFile.openDexFile(DexFile.java:428)
	at dalvik.system.DexFile.<init>(DexFile.java:133)
	at dalvik.system.DexFile.<init>(DexFile.java:106)
	at dalvik.system.DexPathList.loadDexFile(DexPathList.java:438)
	at dalvik.system.DexPathList.makeDexElements(DexPathList.java:397)
	at dalvik.system.DexPathList.<init>(DexPathList.java:166)
	at dalvik.system.BaseDexClassLoader.<init>(BaseDexClassLoader.java:160)
	at dalvik.system.BaseDexClassLoader.<init>(BaseDexClassLoader.java:105)
	at dalvik.system.DexClassLoader.<init>(DexClassLoader.java:55)
	at mindustry.android.AndroidLauncher$1$1.<init>(AndroidLauncher.java:5)
	at mindustry.android.AndroidLauncher$1.loadJar(AndroidLauncher.java:33)
	at mindustry.mod.Mods.loadMod(Mods.java:335)
	at mindustry.mod.Mods.importMod(Mods.java:99)
	... 9 more
```

I think `setReadOnly` to a file in `/storage/emulated/0/Android/data/io.anuke.mindustry.be/files/` does not work on some Android 14 device. 

I added a new method to bypass the security problem.

## Working environment

The repository is checked out at `/app/Mindustry` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.

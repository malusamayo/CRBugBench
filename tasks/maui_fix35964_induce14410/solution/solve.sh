#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Controls/src/Core/Platform/Android/Extensions/FormattedStringExtensions.cs`:

This pull request introduces the defect later reported as "[Android] IndexOutOfBoundsException in RecalculateSpanPositions when Label uses FormattedText + MaxLines + TailTruncation". The
problem a user observed, and its root cause:

### Description

On Android, assigning a `FormattedString` to `Label.FormattedText` on a label
that also has `MaxLines` and `LineBreakMode="TailTruncation"` (or `WordWrap`)
causes a fatal `Java.Lang.IndexOutOfBoundsException` in
`FormattedStringExtensions.RecalculateSpanPositions`.

The crash is reliable when:
- The `FormattedString` spans multiple paragraphs of text (total length > ~300 chars)
- The `Label` has `MaxLines` set to a low value (e.g. `4`)
- The label is assigned its `FormattedText` after the view has been laid out (e.g. on button click or data binding update)

Reassigning `FormattedText` multiple times to the same label increases crash frequency.

---

### Expected behavior

The label renders with 4 truncated lines of text.

---

### Actual behavior

The app crashes immediately with:

```text
Java.Lang.IndexOutOfBoundsException: offset(382) should be less than line limit(381)
   at Android.Text.Layout.GetPrimaryHorizontal(Int32 offset)
   at Microsoft.Maui.Controls.Compatibility.Platform.Android.FastRenderers.LabelRenderer.RecalculateSpanPositions(...)
   at Microsoft.Maui.Controls.Compatibility.Platform.Android.FormattedStringExtensions.RecalculateSpanPositions(
         TextView control, FormattedString fs, MeasuredSize measureResults)
      in FormattedStringExtensions.cs:187
```
### Root cause

`RecalculateSpanPositions` iterates every `Span`'s character end position using
the full `SpannableString` offset. When `MaxLines` is set, Android only lays out
enough lines to satisfy that limit. Any span character offset beyond that last
laid-out line's character count is then out of range for
`Layout.GetPrimaryHorizontal(offset)`, which throws:

```text
Java.Lang.IndexOutOfBoundsException: offset(382) should be less than line limit(381)
   at Android.Text.Layout.GetPrimaryHorizontal(Int32 offset)
   at FormattedStringExtensions.RecalculateSpanPositions(FormattedStringExtensions.cs:187)
```

---

### Steps to Reproduce

1. Clone the repro project and deploy to an Android device or emulator.
2. Launch the app.
3. Tap **Trigger unsafe version**.

**Expected:** The label renders with 4 truncated lines of text.

**Actual:** The app crashes with `Java.Lang.IndexOutOfBoundsException` in `FormattedStringExtensions.RecalculateSpanPositions`.


### Link to public reproduction project repository

https://github.com/johncdoherty/MauiFormattedStringCrash

### Version with bug

10.0.70

### Is this a regression from previous behavior?

No, this is something new

### Last version that worked well

_No response_

### Affected platforms

Android

### Affected platform versions

Android 16

### Did you find any workaround?

Replace `MaxLines` with `HeightRequest` to visually clip the label. The full
`FormattedString` is laid out normally and the container clips overflow, so
`RecalculateSpanPositions` never sees a layout/offset mismatch.

```xml
<!-- Crashes -->
<Label FormattedText="{Binding ...}"
       MaxLines="4"
       LineBreakMode="TailTruncation" />

<!-- Safe -->
<Label FormattedText="{Binding ...}"
       HeightRequest="88"
       LineBreakMode="WordWrap" />
```

### Relevant log output

```shell

```

This same root cause must be fixed before merging.
REVIEW_EOF

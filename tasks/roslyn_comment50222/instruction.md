# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/roslyn` repository.

**PR title:** Move IEditorFormattingService to the Features layer

**PR description:**

Today, IEditorFormattingService lives in the EditorFeatures layer, which is an impediment to making the API public and to making our LSP depend only on the Features layer. This moves the service down to the Features layer. The service was almost entirely independent of the EditorFeatures layer today, with one exception: it used [Microsoft.VisualStudio.TextEditor.IIndentationManager.GetIndentation](https://docs.microsoft.com/en-us/dotnet/api/microsoft.visualstudio.text.editor.iindentationmanagerservice.getindentation?view=visualstudiosdk-2019#Microsoft_VisualStudio_Text_Editor_IIndentationManagerService_GetIndentation_Microsoft_VisualStudio_Text_ITextBuffer_System_Boolean_System_Boolean__System_Int32__System_Int32__), which of course cannot be directly moved to the Features layer. I extracted the extension method that called this into it's own workspace service, with a no-op implementation in the Workspace layer, and a VS-specific implementation in the VisualStudio layer that overrides the no-op version and calls the VS-specific API. The implementation is otherwise almost entirely untouched, just a couple of small housekeeping changes while I was moving the file.

## Working environment

The repository is checked out at `/app/roslyn` at this PR's **base commit**
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

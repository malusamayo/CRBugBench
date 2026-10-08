# Code Review Task

You are a maintainer reviewing a pull request to the `JabRef/jabref` repository.

**PR title:** Relativize recent paths

**PR description:**

### Related issues and pull requests

Closes #3590 

### PR Description

I changed the processing of paths of recent libraries (.bib files) based on the boolean value of memoryStickMode. These changes were made in JabRefCliPreferences, FileHistory, FileHistoryMenu, JabRefBaseDirectoryLocator, and JabRefCliPreferences. These changes allowed each of the files to handle the file paths as relative or absolute depending on whether memoryStickMode == true or false. 

<img width="1023" height="442" alt="JabRef3590_bib" src="https://github.com/user-attachments/assets/6361bbce-fe06-4526-a1dd-8225f05feda2" />

## Before 
<img width="1128" height="796" alt="before" src="https://github.com/user-attachments/assets/50d0b09f-3cfc-41b0-94bc-6eb6da97335c" />

## After
<img width="980" height="620" alt="after" src="https://github.com/user-attachments/assets/0417e914-3d87-4d51-9eea-ca1c6c074d86" />

### Steps to test
1.  Ensure there is a bib file (JabRef3590.bib) In the same directory as your JabRef executable
     <img width="745" height="548" alt="same dir" src="https://github.com/user-attachments/assets/0cde7eb8-d785-4912-8e3c-6fb981579719" />
2. Open JabRef Preferences
3. Ensure that memoryStickMode is untoggled (red rectangle)
    <img width="847" height="612" alt="untoggled" src="https://github.com/user-attachments/assets/25b86c03-e9f5-4e42-97d9-cb166e72214e" />
4. Open library and notice how the path is stored under Recent on the welcome tab (this will be  an absolute path) 
5. Open JabRef Preferences again 
6. Now, ensure that memoryStickMode is toggled 
7. Open that same library and notice how the path becomes stored under Recent in the welcome table (this will be  a relative path)
    a. You can open again using any method "Open library…" under start or using path under Recent
8. With memoryStickMode still toggled, move the folder holding the JabRef executable and that bib file somewhere else in your file system 
9. Open JabRef and ensure that JabRef3590.bib still opens
10. Now, ensure that memoryStickMode is untoggled (again)
11.  Close the JabRef application 
12. Reopen JabRef and ensure the relative paths under Recent on the welcome tab have reverted back to absolute
13. Repeat steps 10-12, but vice versa to ensure that absolute paths restore as relative paths upon JabRef's reopening

#### Note
Some tweaks are needed as after doing Steps 8 and 9 an extra relative path referring to the old location of JabRef3590.bib is stored in Recent. This path should not get stored.

### Checklist

- [x] I own the copyright of the code submitted and I license it under the [MIT license](https://github.com/JabRef/jabref/blob/main/LICENSE)
- [x] I manually tested my changes in running JabRef (always required)
- [x] I added JUnit tests for changes (if applicable)
- [x] I added screenshots in the PR description (if change is visible to the user)
- [x] I added a screenshot in the PR description showing a library with a single entry with me as author and as title the issue number
- [x] I described the change in `CHANGELOG.md` in a way that can be understood by the average user (if change is visible to the user)
- [/] I checked the [user documentation](https://docs.jabref.org/) for up to dateness and submitted a pull request to our [user documentation repository](https://github.com/JabRef/user-documentation/tree/main/en)

## Working environment

The repository is checked out at `/app/jabref` at this PR's **base commit**
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

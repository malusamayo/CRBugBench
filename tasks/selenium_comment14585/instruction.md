# Code Review Task

You are a maintainer reviewing a pull request to the `SeleniumHQ/selenium` repository.

**PR title:** [java] Fix `v*Network.java` conditions

**PR description:**

### **User description**
### Description

As described in this [comment](https://github.com/SeleniumHQ/selenium/pull/14421#issuecomment-2395023808), SpotBugs found some additional bugs in the code.
In this PR I fix part of the found problems.

SpotBugs error:
```
H D UC: Useless condition: it's known that code <= 399 (0x18f) at this point  At V85Network.java:[line 140]
```

In this PR I change the condition in the `v*Network` classes - the warning should appear only if there was a problem reading the body in a request other than a redirect.

### Motivation and Context
Fixing the actual problems is necessary before enabling full SpotBugs analysis, in order to not break the build.

### Types of changes
<!--- What types of changes does your code introduce? Put an `x` in all the boxes that apply: -->
- [x] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to change)

### Checklist
<!--- Go over all the following points, and put an `x` in all the boxes that apply. -->
<!--- If you're unsure about any of these, don't hesitate to ask. We're here to help! -->
- [x] I have read the [contributing](https://github.com/SeleniumHQ/selenium/blob/trunk/CONTRIBUTING.md) document.
- [ ] My change requires a change to the documentation.
- [ ] I have updated the documentation accordingly.
- [ ] I have added tests to cover my changes.
- [ ] All new and existing tests passed.
<!--- Provide a general summary of your changes in the Title above -->


___

### **PR Type**
Bug fix


___

### **Description**
- Fixed a logical error in the condition checking HTTP status codes in multiple `v*Network` classes.
- Changed the condition from using 'and' to 'or' to correctly identify non-redirect HTTP responses.
- This change addresses SpotBugs warnings and improves the reliability of the code.



___



### **Changes walkthrough** 📝
<table><thead><tr><th></th><th align="left">Relevant files</th></tr></thead><tbody><tr><td><strong>Bug fix</strong></td><td><table>
<tr>
  <td>
    <details>
      <summary><strong>v127Network.java</strong><dd><code>Correct HTTP status code condition in v127Network</code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </dd></summary>
<hr>

java/src/org/openqa/selenium/devtools/v127/v127Network.java

<li>Fixed condition to correctly handle HTTP status codes.<br> <li> Changed logical operator from 'and' to 'or' in condition.<br>


</details>


  </td>
  <td><a href="https://github.com/SeleniumHQ/selenium/pull/14585/files#diff-ca9be65dceeb68f7ec846388a0cd06af1d6fd0e781b0fe7ce8befc287ddb4f51">+1/-1</a>&nbsp; &nbsp; &nbsp; </td>

</tr>                    

<tr>
  <td>
    <details>
      <summary><strong>v128Network.java</strong><dd><code>Correct HTTP status code condition in v128Network</code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </dd></summary>
<hr>

java/src/org/openqa/selenium/devtools/v128/v128Network.java

<li>Fixed condition to correctly handle HTTP status codes.<br> <li> Changed logical operator from 'and' to 'or' in condition.<br>


</details>


  </td>
  <td><a href="https://github.com/SeleniumHQ/selenium/pull/14585/files#diff-7dcfad679458283e19037d57f7da27185e20e2949dca54b2e89491b404dd5a38">+1/-1</a>&nbsp; &nbsp; &nbsp; </td>

</tr>                    

<tr>
  <td>
    <details>
      <summary><strong>v129Network.java</strong><dd><code>Correct HTTP status code condition in v129Network</code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </dd></summary>
<hr>

java/src/org/openqa/selenium/devtools/v129/v129Network.java

<li>Fixed condition to correctly handle HTTP status codes.<br> <li> Changed logical operator from 'and' to 'or' in condition.<br>


</details>


  </td>
  <td><a href="https://github.com/SeleniumHQ/selenium/pull/14585/files#diff-3e4f37fe2d12ffa157852f40d3c7e1f34b346d516c450c6f3b7bdc47ca053f2a">+1/-1</a>&nbsp; &nbsp; &nbsp; </td>

</tr>                    

<tr>
  <td>
    <details>
      <summary><strong>V85Network.java</strong><dd><code>Correct HTTP status code condition in V85Network</code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </dd></summary>
<hr>

java/src/org/openqa/selenium/devtools/v85/V85Network.java

<li>Fixed condition to correctly handle HTTP status codes.<br> <li> Changed logical operator from 'and' to 'or' in condition.<br>


</details>


  </td>
  <td><a href="https://github.com/SeleniumHQ/selenium/pull/14585/files#diff-7d2ede887b6d41abf418cc653aad842cdf24ae4fc6b61ffacb204ee63dc91f88">+1/-1</a>&nbsp; &nbsp; &nbsp; </td>

</tr>                    
</table></td></tr></tr></tbody></table>

___

> 💡 **PR-Agent usage**: Comment `/help "your question"` on any pull request to receive relevant information

## Working environment

The repository is checked out at `/app/selenium` at this PR's **base commit**
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

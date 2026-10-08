# Code Review Task

You are a maintainer reviewing a pull request to the `SeleniumHQ/selenium` repository.

**PR title:** [java]: add `websocket-port` test and `--connect-existing` check

**PR description:**

### **User description**
**Thanks for contributing to Selenium!**
**A PR well described will help maintainers to quickly review and merge it**

Before submitting your PR, please check our [contributing](https://github.com/SeleniumHQ/selenium/blob/trunk/CONTRIBUTING.md) guidelines.
Avoid large PRs, help reviewers by making them as simple and short as possible.

<!--- Provide a general summary of your changes in the Title above -->

### Motivation and Context
<!--- Why is this change required? What problem does it solve? -->
Java fix for #15451.

Java already uses a free websocket port for new firefox webdriver sessions. This PR adds a check for the `--connect-existing` flag and a BiDi based test for multiple Firefox driver sessions.

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
- [x] I have added tests to cover my changes.
- [x] All new and existing tests passed.
<!--- Provide a general summary of your changes in the Title above -->


___

### **PR Type**
Bug fix, Tests


___

### **Description**
- Added a check for the `--connect-existing` flag in `GeckoDriverService` to avoid websocket port conflicts.

- Enhanced logic to allocate websocket ports only when not connecting to an existing Firefox instance.

- Introduced a BiDi-based test to verify multiple Firefox driver sessions with unique websocket ports.

- Ensured proper validation of BiDi websocket URLs and port uniqueness in the new test.


___



### **Changes walkthrough** 📝
<table><thead><tr><th></th><th align="left">Relevant files</th></tr></thead><tbody><tr><td><strong>Bug fix</strong></td><td><table>
<tr>
  <td>
    <details>
      <summary><strong>GeckoDriverService.java</strong><dd><code>Add `--connect-existing` check and websocket port allocation logic</code></dd></summary>
<hr>

java/src/org/openqa/selenium/firefox/GeckoDriverService.java

<li>Added logic to check for the <code>--connect-existing</code> flag.<br> <li> Allocated websocket ports only when not connecting to an existing <br>instance.<br> <li> Updated origin handling logic to avoid conflicts with multiple Firefox <br>instances.


</details>


  </td>
  <td><a href="https://github.com/SeleniumHQ/selenium/pull/15462/files#diff-a441a4f6b8b9cfb6e4e25122a31c17dbf86beae9bf02521e1516b27fcd130245">+19/-6</a>&nbsp; &nbsp; </td>

</tr>
</table></td></tr><tr><td><strong>Tests</strong></td><td><table>
<tr>
  <td>
    <details>
      <summary><strong>FirefoxDriverConcurrentTest.java</strong><dd><code>Add BiDi test for multiple Firefox instances</code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </dd></summary>
<hr>

java/test/org/openqa/selenium/firefox/FirefoxDriverConcurrentTest.java

<li>Added a new test for multiple Firefox instances with BiDi enabled.<br> <li> Verified unique websocket ports for each Firefox instance.<br> <li> Validated BiDi websocket URLs and port extraction logic.


</details>


  </td>
  <td><a href="https://github.com/SeleniumHQ/selenium/pull/15462/files#diff-21fcf0bcc582a5d48fa67e7fd2ae2aa795adfb14f8b629ffbc2ddc437c08ebce">+32/-0</a>&nbsp; &nbsp; </td>

</tr>
</table></td></tr></tr></tbody></table>

___

> <details> <summary>  Need help?</summary><li>Type <code>/help how to ...</code> in the comments thread for any questions about Qodo Merge usage.</li><li>Check out the <a href="https://qodo-merge-docs.qodo.ai/usage-guide/">documentation</a> for more information.</li></details>

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

# Code Review Task

You are a maintainer reviewing a pull request to the `SeleniumHQ/selenium` repository.

**PR title:** [grid] Expose register status via Node status response

**PR description:**

### **User description**
**Thanks for contributing to Selenium!**
**A PR well described will help maintainers to quickly review and merge it**

Before submitting your PR, please check our [contributing](https://github.com/SeleniumHQ/selenium/blob/trunk/CONTRIBUTING.md) guidelines.
Avoid large PRs, help reviewers by making them as simple and short as possible.

<!--- Provide a general summary of your changes in the Title above -->

### Motivation and Context
Fixes https://github.com/SeleniumHQ/docker-selenium/issues/2705
Currently, Node status response looks like
```json
{
  "value": {
    "ready": true,
    "message": "Ready",
    "node": {
      "availability": "UP",

```

`"ready": true` is returned by `hasCapability()` - this status reflects Node is ready (connected to Bus, has slots available).
However, this does not include registration status.
To have reliable data for adding Node health checks (Docker) or Node startup/readiness probes (K8s), via `/status` response, we expose one more attribute `registered` (true/false) for registration status with Hub.

Now, response when Node just up, not registered to Hub yet
```json
{
  "value": {
    "ready": true,
    "message": "Ready",
    "registered": false,
    "node": {
      "availability": "UP",
```

Once it is able to register to Hub
```json
{
  "value": {
    "ready": true,
    "message": "Ready",
    "registered": true,
    "node": {
      "availability": "UP",
```

### Types of changes
<!--- What types of changes does your code introduce? Put an `x` in all the boxes that apply: -->
- [ ] Bug fix (non-breaking change which fixes an issue)
- [x] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to change)

### Checklist
<!--- Go over all the following points, and put an `x` in all the boxes that apply. -->
<!--- If you're unsure about any of these, don't hesitate to ask. We're here to help! -->
- [x] I have read the [contributing](https://github.com/SeleniumHQ/selenium/blob/trunk/CONTRIBUTING.md) document.
- [ ] My change requires a change to the documentation.
- [ ] I have updated the documentation accordingly.
- [ ] I have added tests to cover my changes.
- [x] All new and existing tests passed.
<!--- Provide a general summary of your changes in the Title above -->


___

### **PR Type**
Enhancement


___

### **Description**
- Added `registered` attribute to Node status response for registration status.

- Updated `hasCapacity` and `hasCapability` methods to check Node availability.

- Introduced `isRegistered` and `register` methods in `Node` class.

- Enhanced readiness check to include Node registration status.


___



### **Changes walkthrough** 📝
<table><thead><tr><th></th><th align="left">Relevant files</th></tr></thead><tbody><tr><td><strong>Enhancement</strong></td><td><table>
<tr>
  <td>
    <details>
      <summary><strong>NodeStatus.java</strong><dd><code>Update capacity checks with Node availability</code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </dd></summary>
<hr>

java/src/org/openqa/selenium/grid/data/NodeStatus.java

<li>Updated <code>hasCapability</code> and <code>hasCapacity</code> methods to check Node <br>availability.<br> <li> Ensured Node's availability is considered in capacity checks.


</details>


  </td>
  <td><a href="https://github.com/SeleniumHQ/selenium/pull/15448/files#diff-04bf71dc8f94e5e1e3620bb9b03ea6162519e7adefa5dbec7a420a5c88dfc1d8">+6/-3</a>&nbsp; &nbsp; &nbsp; </td>

</tr>

<tr>
  <td>
    <details>
      <summary><strong>Node.java</strong><dd><code>Add registration status tracking to Node</code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </dd></summary>
<hr>

java/src/org/openqa/selenium/grid/node/Node.java

<li>Added <code>registered</code> attribute to track Node registration status.<br> <li> Introduced <code>isRegistered</code> and <code>register</code> methods for registration <br>handling.


</details>


  </td>
  <td><a href="https://github.com/SeleniumHQ/selenium/pull/15448/files#diff-9724970402f0d888442caa09bf30d6f8074edde726dae3e98a52eda4f2ed8462">+9/-0</a>&nbsp; &nbsp; &nbsp; </td>

</tr>

<tr>
  <td>
    <details>
      <summary><strong>StatusHandler.java</strong><dd><code>Include registration status in Node status response</code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </dd></summary>
<hr>

java/src/org/openqa/selenium/grid/node/StatusHandler.java

<li>Added <code>registered</code> attribute to Node status response.<br> <li> Modified response to include registration status.


</details>


  </td>
  <td><a href="https://github.com/SeleniumHQ/selenium/pull/15448/files#diff-898d6e3841b5f97f2d6c06d43a5a05431c6fcab8bb29075ecba0757760ca5461">+2/-0</a>&nbsp; &nbsp; &nbsp; </td>

</tr>

<tr>
  <td>
    <details>
      <summary><strong>NodeServer.java</strong><dd><code>Improve readiness check with registration status</code>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </dd></summary>
<hr>

java/src/org/openqa/selenium/grid/node/httpd/NodeServer.java

<li>Enhanced readiness check to include Node registration status.<br> <li> Updated Node registration event to set <code>registered</code> attribute.


</details>


  </td>
  <td><a href="https://github.com/SeleniumHQ/selenium/pull/15448/files#diff-6b57ab0a9dd897b266c9f06a46be2aa968b943059a7ed818ef049461b977d31e">+2/-1</a>&nbsp; &nbsp; &nbsp; </td>

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

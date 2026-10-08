#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `core/src/main/resources/hudson/views/BuildButtonColumn/icon.js`:

This pull request introduces the defect later reported as "[JENKINS-75417] Scheduling build under disabled Multibranch folder says "Build Scheduled" while it is not scheduled". The
problem a user observed, and its root cause:

<!-- ### Imported Jira references for easier searching -->
<!-- [jira_issue_key=JENKINS-75417] -->
<!-- [jira_issue_type=Bug] -->
<!-- [reporter=allan_burdajewicz] -->
<!-- [author=allan_burdajewicz] -->
<!-- [jira_component=cloudbees-folder-plugin] -->
<!-- [jira_component=core] -->
<!-- [jira_issues_importer_version=1.2.0] -->

<p>When trying to trigger a build of a branch job of a *<b>disabled</b>* Multibranch project, the build is not scheduled (because the multibranch is disabled) but a UI notification pop up shows "Build Scheduled".</p>

<p> <span class="image-wrap" style=""><a id="64087_thumb" href="https://issues.jenkins.io/secure/attachment/64087/64087_build-scheduled-msg-while-it-is-not.png" title="build-scheduled-msg-while-it-is-not.png" file-preview-type="image" file-preview-id="64087" file-preview-title="build-scheduled-msg-while-it-is-not.png"><img src="https://issues.jenkins.io/secure/thumbnail/64087/_thumb_64087.png" style="border: 0px solid black" role="presentation"/></a></span> </p>

<p>Note: The developer console shows that the request to <tt>/build?delay=0</tt> returns a <tt>302</tt>. Whereas in a case where the build is actually scheduled we get a <tt>201</tt>.</p>

<h3><a name="HowtoReproduce"></a>How to Reproduce</h3>

<ul>
	<li>Create a Multibranch pipeline</li>
	<li>Disable the Multibranch Pipeline (through its configuration page or <tt>/disable</tt>)</li>
	<li>try to build a branch job</li>
</ul>


---
<details><summary><i>Originally reported by <img align="left" width="20" src="https://raw.githubusercontent.com/jenkinsci/artifacts-from-jira-issues/refs/heads/main/avatars/allan_burdajewicz.png" title="allan_burdajewicz's avatar" /> <a href="https://issues.jenkins.io/secure/ViewProfile.jspa?name=allan_burdajewicz">allan_burdajewicz</a>, imported from: <a class="no-jira-link-rewrite" href="https://issues.jenkins.io/browse/JENKINS-75417" target="_blank">Scheduling build under disabled Multibranch folder says "Build Scheduled" while it is not scheduled</a></i></summary>
<i><ul>
<li><b>status</b>: Open
<li><b>priority</b>: Major
<li><b>component(s)</b>: cloudbees-folder-plugin, core
<li><b>resolution</b>: Unresolved
<li><b>votes</b>: 0
<li><b>watchers</b>: 1
<li><b>imported</b>: 2025-11-24
</ul></i>
<details><summary>Raw content of original issue</summary>

<pre>
<p>When trying to trigger a build of a branch job of a *<b>disabled</b>* Multibranch project, the build is not scheduled (because the multibranch is disabled) but a UI notification pop up shows "Build Scheduled".</p>

<p> <span class="image-wrap" style=""><a id="64087_thumb" href="https://issues.jenkins.io/secure/attachment/64087/64087_build-scheduled-msg-while-it-is-not.png" title="build-scheduled-msg-while-it-is-not.png" file-preview-type="image" file-preview-id="64087" file-preview-title="build-scheduled-msg-while-it-is-not.png"><img src="https://issues.jenkins.io/secure/thumbnail/64087/_thumb_64087.png" style="border: 0px solid black" role="presentation"/></a></span> </p>

<p>Note: The developer console shows that the request to <tt>/build?delay=0</tt> returns a <tt>302</tt>. Whereas in a case where the build is actually scheduled we get a <tt>201</tt>.</p>

<h3><a name="HowtoReproduce"></a>How to Reproduce</h3>

<ul>
	<li>Create a Multibranch pipeline</li>
	<li>Disable the Multibranch Pipeline (through its configuration page or <tt>/disable</tt>)</li>
	<li>try to build a branch job</li>
</ul>
</pre>
</details>
</details>
<ul><li><i>environment</i>: <code>core:2.501</code></li></ul>
<details><summary><i>1 attachment</i></summary>

- [build-scheduled-msg-while-it-is-not.png](https://issues.jenkins.io/secure/attachment/64087/build-scheduled-msg-while-it-is-not.png)
  > ![build-scheduled-msg-while-it-is-not.png](https://issues.jenkins.io/secure/attachment/64087/build-scheduled-msg-while-it-is-not.png)
</details>

This same root cause must be fixed before merging.
REVIEW_EOF

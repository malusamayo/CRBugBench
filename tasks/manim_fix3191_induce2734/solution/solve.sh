#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `manim/scene/scene.py`:

This pull request introduces the defect later reported as "Using Manim python API with threading (named threads)". The
problem a user observed, and its root cause:

## Description of bug / unexpected behavior
Manim skips scene animations if it detects a thread name is not `MainThread`


## Expected behavior
Manim detects if it currently uses threads spawned by itself, or running within threads outside of Manim's control.
Manim will render scene animations.


## How to reproduce the issue
<!-- Provide a piece of code illustrating the undesired behavior. -->

<details><summary>Code for reproducing the problem</summary>

https://github.com/karpfediem/manim-use_with_threading/blob/ac0ccc03d7fcecd7b82be55b9a867e976bd9ae01/tests/test_rendering.py#L49

https://github.com/karpfediem/manim-use_with_threading/blob/ac0ccc03d7fcecd7b82be55b9a867e976bd9ae01/tests/test_rendering.py#L68

</details>


## Additional media files
<!-- Paste in the files manim produced on rendering the code above. -->

<details><summary>Images/GIFs</summary>

![2023-03-10_12-15](https://user-images.githubusercontent.com/11753414/224302536-2c46f51f-19b1-410d-9e28-5f2719982977.png)

</details>


## Logs
<details><summary>Terminal output</summary>
</details>


## System specifications

<details><summary>System Details</summary>

- OS (with version, e.g., Windows 10 v2004 or macOS 10.15 (Catalina)): 6.2.1-gentoo-x86_64
- RAM: 64GB
- Python version (`python/py/python3 --version`): Python 3.10.10
- Installed modules (provide output from `pip list`): manim

</details>

<details><summary>LaTeX details</summary>
</details>

<details><summary>FFMPEG</summary>
</details>

## Additional comments
Hey there, I discovered a problem when running manim within named threads.

Here is my repository containing minimal reproducible examples: https://github.com/karpfediem/manim-use_with_threading

It is a showcase of how manim fails to render video output when used within renamed threads.

Threads can be manually renamed or automatically renamed by running ThreadPools in certain situations (such as spawning new process tasks within threads).

The tests expect the output file to stay the same as the configured file (ending in .mp4).

However when Manim detects the thread name is not equal to 'MainThread' it will put the play command into a queue, which causes manim to not render any animation.


See [scene.py](https://github.com/ManimCommunity/manim/blob/92b01ebbc603565b8a91a996fb0165e0d8f002a6/manim/scene/scene.py#L1057)
```python
if threading.current_thread().name != "MainThread":
    #...
    self.queue.put(("play", args, kwargs))
    return
```

Since the manim renderer has no configured animations (renderer.num_plays stays 0) it defaults to render the last frame as a PNG output.

This same root cause must be fixed before merging.
REVIEW_EOF

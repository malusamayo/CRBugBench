#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `manim/mobject/functions.py`:

This pull request introduces the defect later reported as "Weird line when plotting staircase function". The
problem a user observed, and its root cause:

## Description of bug / unexpected behavior
I tried to plot a staircase function with a logarithmic x axis. The function is plotted correctly but there is a line in the graph that does not belong to the staircase function.


## Expected behavior
Do not print the line that does not belong to the function.


## How to reproduce the issue

Put the below code in `staircase.py` and run `manim -pql staircase.py BuggyStaircase`.

<details><summary>Code for reproducing the problem</summary>

```py
from manim import *

class BuggyStaircase(Scene):
    def construct(self):
        axes = Axes(
            x_range=[-1, 5, 1],
            y_range=[0, 30, 5],
            x_axis_config={"scaling": LogBase()},
        )

        price = lambda x: 21 if x < 180 else 10 if x < 6000 else 6

        graph = axes.plot(price, x_range=[-1, 4.9, 0.001], use_smoothing=False)

        self.add(axes, graph)
```

</details>


## Additional media files
<!-- Paste in the files manim produced on rendering the code above. -->

<details><summary>Images/GIFs</summary>

![bug](https://user-images.githubusercontent.com/39318299/153752124-dd204987-56a2-49d9-a7fc-f247f7e52878.png)

</details>


## Logs
<details><summary>Terminal output</summary>
<!-- Add "-v DEBUG" when calling manim to generate more detailed logs -->

```
Manim Community v0.14.0

[02/13/22 13:02:25] INFO                                                                                                                                      scene_file_writer.py:729
                             File ready at '/home/something/something/media/images/staircase/BuggyStaircase_ManimCE_v0.14.0.png'                                                   
                                                                                                                                                                                      
                    INFO     Rendered BuggyStaircase                                                                                                                      scene.py:237
                             Played 0 animations                                                                                                                                      
                    INFO     Previewed File at: '/home/something/something/media/images/staircase/BuggyStaircase_ManimCE_v0.14.0.png'                               file_ops.py:202
```

<!-- Insert screenshots here (only when absolutely necessary, we prefer copy/pasted output!) -->

</details>


## System specifications

<details><summary>System Details</summary>

- OS (with version, e.g., Windows 10 v2004 or macOS 10.15 (Catalina)): Arch Linux
- RAM: 16 GB
- Python version (`python/py/python3 --version`): 3.10.2
- Installed modules (provide output from `pip list`):
```
PASTE HERE
```
</details>

<details><summary>LaTeX details</summary>

+ LaTeX distribution (e.g. TeX Live 2020):
+ Installed LaTeX packages:
<!-- output of `tlmgr list --only-installed` for TeX Live or a screenshot of the Packages page for MikTeX -->
</details>

<details><summary>FFMPEG</summary>

Output of `ffmpeg -version`:

```
PASTE HERE
```
</details>

## Additional comments
<!-- Add further context that you think might be relevant for this issue here. -->

This same root cause must be fixed before merging.
REVIEW_EOF

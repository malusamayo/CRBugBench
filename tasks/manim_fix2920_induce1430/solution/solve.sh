#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `manim/mobject/graphing/coordinate_systems.py`:

This pull request introduces the defect later reported as "Unnatural axis alignment when using faded_line_ratio property". The
problem a user observed, and its root cause:

## Description of bug / unexpected behaviour
<!-- Add a clear and concise description of the problem you encountered. -->
An uneven interval between the axis and grids causes mapping of coordinates using the NumberPlane.c2p unexpected.

## Expected behaviour
<!-- Add a clear and concise description of what you expected to happen. -->
The interval between the units from ORIGIN should be uniform and Coordinates should be mapped properly.

## How to reproduce the issue
<!-- Provide a piece of code illustrating the undesired behaviour. -->

<details><summary>Code for reproducing the problem</summary>

```py
class Test(Scene):
    def construct(self):
        numberplane = NumberPlane(
            faded_line_ratio=5,
            axis_config={
            "font_size": 40,
            }
        ).add_coordinates()
        coord = numberplane.c2p

        self.add(
            Dot(coord(0, 0)),
            Dot(coord(1, 0)),
            Dot(coord(2, 0)),
        )
        self.add(numberplane)
```


</details>


## Additional media files
<!-- Paste in the files manim produced on rendering the code above. -->

<details><summary>Images/GIFs</summary>

<!-- PASTE MEDIA HERE -->
![image](https://user-images.githubusercontent.com/25475894/180486457-c0c64a92-3cc8-4756-bf75-36ff2b01c270.png)
</details>

## System specifications
Not relevant

## Additional comments
<!-- Add further context that you think might be relevant for this issue here. -->

This same root cause must be fixed before merging.
REVIEW_EOF

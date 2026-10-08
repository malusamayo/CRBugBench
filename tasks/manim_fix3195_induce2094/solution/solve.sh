#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `manim/mobject/graphing/coordinate_systems.py`:

This pull request introduces the defect later reported as "NumberPlane plot_implicit_curve method doesnot respect 'scaling' factor of Axes". The
problem a user observed, and its root cause:

## Description of bug / unexpected behaviour
Graphs plotted with plot implicit curve do not respect the "scaling" factor set in NumberLine and remain unchanged on all scaling factors.


## Expected behaviour
Like with graphs plotted with the plot() function we need to take the scaling of axes into account and plot curves according to it.

## How to reproduce the issue

<details><summary>A: Without scaling (Working as usual)</summary>

```py
from manim import *


class Test(Scene):
    def construct(self):
        numberplane = NumberPlane().add_coordinates()

        unit_circle = numberplane.plot_implicit_curve(
            lambda x, y: (x) ** 2 + (y) ** 2 - 1, color=BLUE
        )

        self.add(numberplane, unit_circle)
```

</details>

<details><summary>B: Code for reproducing the problem</summary>

```py
from manim import *


class Test(Scene):
    def construct(self):
        numberplane = NumberPlane(
            axis_config=dict(
                scaling=LinearBase(scale_factor=0.5),
                decimal_number_config=dict(
                    num_decimal_places=1,
                ),
            ),
        ).add_coordinates()

        unit_circle = numberplane.plot_implicit_curve(
            lambda x, y: (x) ** 2 + (y) ** 2 - 1, color=BLUE
        )

        self.add(numberplane, unit_circle)
```

</details>


## Additional media files

<details><summary>A: Image output</summary>
 
![Test_ManimCE_v0 17 2](https://user-images.githubusercontent.com/25475894/216259840-fda384b9-dc3a-4698-8df4-43fb0c30eba1.png)

</details>

<details><summary>B: Image output</summary>

![Test_ManimCE_v0 17 2](https://user-images.githubusercontent.com/25475894/216259135-480490bb-bcc1-402c-bd67-ba5e0debcd7b.png)

</details>


## Logs

not relevant


## Additional comments

This same root cause must be fixed before merging.
REVIEW_EOF

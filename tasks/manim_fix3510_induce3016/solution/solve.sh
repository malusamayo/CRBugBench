#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `example_scenes/basic.py`:

This pull request introduces the defect later reported as "keyword argument 'line_join'". The
problem a user observed, and its root cause:

## Description of bug / unexpected behavior
When I rendering the line joint scene from basic.py from the example scene it shows Mobject.__init__() got an unexpected keyword argument 'line_join'

## How to reproduce the issue
<!-- Provide a piece of code illustrating the undesired behavior. -->

<details><summary>Code for reproducing the problem</summary>

```py
class LineJoints(Scene):
    def construct(self):
        t1 = Triangle()
        t2 = Triangle(line_join=LineJointType.ROUND)
        t3 = Triangle(line_join=LineJointType.BEVEL)

        grp = VGroup(t1, t2, t3).arrange(RIGHT)
        grp.set(width=config.frame_width - 1)

        self.add(grp)
```

</details>

## Logs
<details><summary>Virtual Code Studio output</summary>
<!-- Add "-v DEBUG" when calling manim to generate more detailed logs -->

```
╭─────────────────────────────── Traceback (most recent call last) ────────────────────────────────╮
│ C:\tools\Manim\Lib\site-packages\manim\cli\render\commands.py:115 in render                      │
│                                                                                                  │
│   112 │   │   │   try:                                                                           │
│   113 │   │   │   │   with tempconfig({}):                                                       │
│   114 │   │   │   │   │   scene = SceneClass()                                                   │
│ ❱ 115 │   │   │   │   │   scene.render()                                                         │
│   116 │   │   │   except Exception:                                                              │
│   117 │   │   │   │   error_console.print_exception()                                            │
│   118 │   │   │   │   sys.exit(1)                                                                │
│                                                                                                  │
│ C:\tools\Manim\Lib\site-packages\manim\scene\scene.py:223 in render                              │
│                                                                                                  │
│    220 │   │   """                                                                               │
│    221 │   │   self.setup()                                                                      │
│    222 │   │   try:                                                                              │
│ ❱  223 │   │   │   self.construct()                                                              │
│    224 │   │   except EndSceneEarlyException:                                                    │
│    225 │   │   │   pass                                                                          │
│    226 │   │   except RerunSceneException as e:                                                  │
│                                                                                                  │
│ C:\Users\HP\Documents\ManimCE\basic.py:170 in construct                                          │
│                                                                                                  │
│   167 class LineJoints(Scene):                                                                   │
│   168 │   def construct(self):                                                                   │
│   169 │   │   t1 = Triangle()                                                                    │
│ ❱ 170 │   │   t2 = Triangle(line_join=LineJointType.ROUND)                                       │
│   171 │   │   t3 = Triangle(line_join=LineJointType.BEVEL)                                       │
│   172 │   │                                                                                      │
│   173 │   │   grp = VGroup(t1, t2, t3).arrange(RIGHT)                                            │
│                                                                                                  │
│ C:\tools\Manim\Lib\site-packages\manim\mobject\geometry\polygram.py:559 in __init__              │
│                                                                                                  │
│   556 │   """                                                                                    │
│   557 │                                                                                          │
│   558 │   def __init__(self, **kwargs):                                                          │
│ ❱ 559 │   │   super().__init__(n=3, **kwargs)                                                    │
│   560                                                                                            │
│   561                                                                                            │
│   562 class Rectangle(Polygon):                                                                  │
│                                                                                                  │
│ C:\tools\Manim\Lib\site-packages\manim\mobject\geometry\polygram.py:428 in __init__              │
│                                                                                                  │
│   425 │   """                                                                                    │
│   426 │                                                                                          │
│   427 │   def __init__(self, n: int = 6, **kwargs):                                              │
│ ❱ 428 │   │   super().__init__(n, density=1, **kwargs)                                           │
│   429                                                                                            │
│   430                                                                                            │
│   431 class Star(Polygon):                                                                       │
│                                                                                                  │
│ C:\tools\Manim\Lib\site-packages\manim\mobject\geometry\polygram.py:399 in __init__              │
│                                                                                                  │
│   396 │   │   │                                                                                  │
│   397 │   │   │   vertex_groups.append(group)                                                    │
│   398 │   │                                                                                      │
│ ❱ 399 │   │   super().__init__(*vertex_groups, **kwargs)                                         │
│   400                                                                                            │
│   401                                                                                            │
│   402 class RegularPolygon(RegularPolygram):                                                     │
│                                                                                                  │
│ C:\tools\Manim\Lib\site-packages\manim\mobject\geometry\polygram.py:69 in __init__               │
│                                                                                                  │
│    66 │   """                                                                                    │
│    67 │                                                                                          │
│    68 │   def __init__(self, *vertex_groups: Iterable[Sequence[float]], color=BLUE, **kwargs):   │
│ ❱  69 │   │   super().__init__(color=color, **kwargs)                                            │
│    70 │   │                                                                                      │
│    71 │   │   for vertices in vertex_groups:                                                     │
│    72 │   │   │   first_vertex, *vertices = vertices                                             │
│          

This same root cause must be fixed before merging.
REVIEW_EOF

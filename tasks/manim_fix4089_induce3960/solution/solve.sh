#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `manim/utils/bezier.py`:

This pull request introduces the defect later reported as "`FadeOut` and `.animate.set_opacity()` are not working correctly on `ImageMobject`". The
problem a user observed, and its root cause:

## Description of bug / unexpected behavior
After adding an `ImageMobject`:
- When applying `.animate.set_opacity(0.1)`, **the opacity goes up from 0.0 to 0.1 instead of going down from 1.0 to 0.1.**
- Applying `.animate.set_opacity(0.5)` works as expected.
- When applying `FadeOut`, **the opacity of the image goes to 1.0 instead of 0.0.**
- Applying `FadeIn` works as it should: it starts with an opacity of 0.0, and it goes up to 0.5: the last opacity we set before.

## Expected behavior
- When applying `.animate.set_opacity(0.1)`, **the opacity should have gone down from 1.0 to 0.1.**
- When applying `FadeOut`, **the opacity of the image should have gone down to 0.0.**

## How to reproduce the issue
```py
class ImageScene(Scene):
    def construct(self):
        array = np.zeros((400, 400, 4), dtype=np.uint8)
        array[:, :, 1] = 255 # Green
        array[:, :, 3] = 255 # Opaque
        image = ImageMobject(array)

        self.add(image)
        self.play(image.animate.set_opacity(0.1))
        self.play(image.animate.set_opacity(0.5))
        self.play(FadeOut(image))
        self.play(FadeIn(image))
```
## Additional media files
Current version (with bug):

https://github.com/user-attachments/assets/0389f83e-9335-488d-9753-017192f2f9ec

Without this bug, it should look like this instead (I rendered this video on an earlier version of Manim):

https://github.com/user-attachments/assets/38ac6d4a-40b6-46ac-9551-76f76d43d303

## Additional comments
This bug is recent. I switched to the branch for my PR #3742, last updated in July, and the error was not present. I haven't yet found the cause of this. I looked at the `fading.py`, `transform.py`, `animation.py` and `image_mobject.py`, but I didn't find any relevant change: most of them were added typehints.

_NOTE: I had to change a `np.float_` to `np.float64` in `manim.utils.iterables` and convert the `config.frame_rate` float to a `Fraction` in `manim.scene.scene_file_writer` in order to be able to render the scene in that older branch._

This same root cause must be fixed before merging.
REVIEW_EOF

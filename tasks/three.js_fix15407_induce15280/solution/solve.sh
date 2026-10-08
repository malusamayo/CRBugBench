#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `rollup.config.js`:

This pull request introduces the defect later reported as "Incorrect build of threejs on windows". The
problem a user observed, and its root cause:

##### Description of the problem

With the current stable version you cannot build threejs correctly on windows. There was a change to the ShaderChunk system (refering to [#15280](https://github.com/mrdoob/three.js/pull/15280)) with all glsl.js files using backticks now, which of course will not work in browsers that are not es6 compatible (like IE11). 

Now during build, rollup is performed and the glsl() - function in the rollup.config.js should replace the code inside of the backticks, as well as the backticks themselves. However the regex in line 165:

**/\`((.*|\n)*)\`/**

will never match if you clone the repository on windows because windows line endings are always \r\n and not just \n like on mac. So the backticks code won't get replaced.

Ideas to solve this issue are:
  - change the .gitattributes file and replace "text=auto" with "text eol = lf" so when cloning the 
     repo lineendings will always be \n.
  - Change the regex so that it matches the \r\n case as well.

##### Three.js version

- r99

##### Browser

- Especially IE11

##### OS

- Windows

This same root cause must be fixed before merging.
REVIEW_EOF

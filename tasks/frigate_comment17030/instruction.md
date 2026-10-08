# Code Review Task

You are a maintainer reviewing a pull request to the `blakeblackshear/frigate` repository.

**PR title:** Base path via environment variable

**PR description:**

## Proposed change
See [discussion](https://github.com/blakeblackshear/frigate/discussions/16746).

Currently Frigate already can be hosted under a base path (e.g. `/frigate`) instead of at the root path `/`.  That base path can now only be specified via a http header `X-Ingress-Path`.  However that is quite inconvenient in some use cases.  For example the reverse proxy inside a Tailscale agent cannot add such a http header, so an extra reverse proxy would need to be installed (only to add a single http header).  Which would add a lot of unnecessary complexity to such systems.

This PR offers an extra second mechanism to specify a base path, as an environment variable `BASE_PATH` inside the docker compose file:
```
services:
  frigate:
    image: ghcr.io/blakeblackshear/frigate:stable-standard-arm64
   environment:
      - BASE_PATH=frigate
```
The existing mechanism (based on the http header) shouldn't be touched by this PR, instead this PR uses the existing mechanism (see further).

### 1. Explanation

The new mechanism works quite similar to the existing implementation of the TLS config:
1. When the container is runned, the `get_base_path.py` is executed to load the environment variable.
2. The `base_path.gotmpl` Nginx template file is used to generate a */usr/local/nginx/conf/base_path.conf* file at runtime inside the container.  
   Remarks: 
   + This template file is based on [this](https://github.com/blakeblackshear/frigate/discussions/3996#discussioncomment-10318509) discussion.  So the credits for this one go to @bdoiron74 :heart:
   + The template stores the base path from the environment variable into the existing http header, and from then on the existing mechanism is being used!
   + This config file is empty if no environment variable has been set, to have no impact on users that don't use it.
3. The `web_manifest.gotmpl` Nginx template file is used to generate a */usr/local/nginx/conf/web_manifest.conf* file at runtime inside the container.  
   Remarks:
   + This template file is based on [this](https://github.com/blakeblackshear/frigate/issues/16256) issue.  So the credits for this one go to @Lhachtoo :heart:
   + The template not only changes the start_url value, but also all the other urls in the webmanifest to allow all icons to be loaded via the base path.
   + I have added this change to this PR, because it is also related to the base path.
   + This config file is empty if no environment variable has been set, to have no impact on users that don't use it.
4. These 2 new config files are included into the `nginx.conf` file.

So when no environment variable has been set, both generated config files are empty.  Since two empty files are then included into the Nginx config, the Nginx config should remain identical.  Therefore I assume/hope this PR does not introduce breaking changes. 

### 2. Some doubt...

In this PR I have also added a regex fix in the Nginx conf file, to solve the initial problem in my [discussion](https://github.com/blakeblackshear/frigate/discussions/16746#discussion-8002864) that I had no thumbnail images in the *"Explore"* panel when using a subpath:

![image](https://github.com/user-attachments/assets/ea873492-ed08-434b-868c-3dd0e9b71698)

I have to admit that I find it strange that I had to fix this.  Because I would expect that these thumbnail images would also not appear when the sub path is set via the `X-Ingress-Path` http header.  But I didn't find anywhere a complaint/issue about that, so I don't understand how that can work without problems...

Thanks a lot for your time to review this PR!!!

### 3. TODO's

+ It was not clear to me what would be the best location to explain this in the documentation.  Because I didn't find the `X-Ingress-Path` http header mechanism either in the documentation. 
+ Unfortunately the npm lint and test did not output any info in my console log, so I wasn't able to finalize that.  Must have been doing something wrong, but don't know what...
+ I assume all PR's need to target the dev branch, because I had no master branch in my fork available.  If this PR 'should' be accepted, then I would appreciate a lot if it could be released with some 0.15.x version.  Because I need to do manually all changes over and over again.  
 
## Type of change

- [ ] Dependency upgrade
- [X] Bugfix (non-breaking change which fixes an issue)
- [X] New feature
- [ ] Breaking change (fix/feature causing existing functionality to break)
- [ ] Code quality improvements to existing code
- [ ] Documentation Update

## Additional information

- This PR fixes or closes issue: fixes #16256
- This PR is related to issue: 

## Checklist

<!--
  Put an `x` in the boxes that apply.
-->

- [ ] The code change is tested and works locally.
- [ ] Local tests pass. **Your PR cannot be merged unless tests pass**
- [ ] There is no commented out code in this PR.
- [ ] The code has been formatted using Ruff (`ruff format frigate`)

## Working environment

The repository is checked out at `/app/frigate` at this PR's **base commit**
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

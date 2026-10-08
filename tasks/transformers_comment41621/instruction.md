# Code Review Task

You are a maintainer reviewing a pull request to the `huggingface/transformers` repository.

**PR title:** Add LightOnOCR model implementation

**PR description:**

# What does this PR do?

Implementation of the LightonOCR model following Modular Transformers architecture.

Our model is a 1B parameter OCR model using Pixtral as the vision encoder and Qwen3 as the LLM decoder.

I still have an issue with auto configuration, which I'm not familiar with:

`🚨 Config not found for lightonocr. You can manually add it to HARDCODED_CONFIG_FOR_MODELS in utils/auto_docstring.py`


<!--
Congratulations! You've made it this far! You're not quite done yet though.

Once merged, your PR is going to appear in the release notes with the title you set, so make sure it's a great title that fully reflects the extent of your awesome contribution.

Then, please replace this with a description of the change and which issue is fixed (if applicable). Please also include relevant motivation and context. List any dependencies (if any) that are required for this change.

Once you're done, someone will review your PR shortly (see the section "Who can review?" below to tag some potential reviewers). They may suggest changes to make the code even better. If no one reviewed your PR after a week has passed, don't hesitate to post a new comment @-mentioning the same persons---sometimes notifications get lost.
-->

<!-- Remove if not applicable -->

Fixes # (issue)


## Before submitting
- [ ] This PR fixes a typo or improves the docs (you can dismiss the other checks if that's the case).
- [ ] Did you read the [contributor guideline](https://github.com/huggingface/transformers/blob/main/CONTRIBUTING.md#create-a-pull-request),
      Pull Request section?
- [ ] Was this discussed/approved via a Github issue or the [forum](https://discuss.huggingface.co/)? Please add a link
      to it if that's the case.
- [ ] Did you make sure to update the documentation with your changes? Here are the
      [documentation guidelines](https://github.com/huggingface/transformers/tree/main/docs), and
      [here are tips on formatting docstrings](https://github.com/huggingface/transformers/tree/main/docs#writing-source-documentation).
- [ ] Did you write any new necessary tests?


## Who can review?

Anyone in the community is free to review the PR once the tests have passed. Feel free to tag
members/contributors who may be interested in your PR.

<!-- Your PR will be replied to more quickly if you can figure out the right person to tag with @

 If you know how to use git blame, that is the easiest way, otherwise, here is a rough guide of **who to tag**.
 Please tag fewer than 3 people.

Models:

- text models: @ArthurZucker @Cyrilvallez
- vision models: @yonigozlan @molbap
- audio models: @eustlb @ebezzam @vasqu
- multimodal models: @zucchini-nlp
- graph models: @clefourrier

Library:

- generate: @zucchini-nlp (visual-language models) or @gante (all others)
- continuous batching: @remi-or @ArthurZucker @McPatate
- pipelines: @Rocketknight1
- tokenizers: @ArthurZucker and @itazap
- trainer: @SunMarc
- attention: @vasqu @ArthurZucker @CyrilVallez
- model loading (from pretrained, etc): @CyrilVallez
- distributed: @3outeille @ArthurZucker
- CIs: @ydshieh

Integrations:

- ray/raytune: @richardliaw, @amogkam
- Big Model Inference: @SunMarc
- quantization: @SunMarc @MekkCyber
- kernels: @MekkCyber @drbh
- peft: @BenjaminBossan @githubnemo

Devices/Backends:

- AMD ROCm: @ivarflakstad
- Intel XPU: @IlyasMoutawwakil
- Ascend NPU: @ivarflakstad 

Documentation: @stevhliu

Research projects are not maintained and should be taken as is.

 -->

## Working environment

The repository is checked out at `/app/transformers` at this PR's **base commit**
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

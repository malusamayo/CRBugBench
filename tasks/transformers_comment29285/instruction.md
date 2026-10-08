# Code Review Task

You are a maintainer reviewing a pull request to the `huggingface/transformers` repository.

**PR title:** RoPE loses precision for Llama / Gemma + Gemma logits.float()

**PR description:**

Tagging @ArthurZucker :)

When I was implementing Gemma for Unsloth, I noticed when one uses bfloat16, the RoPE embeddings get autocast to bfloat16, when we require it to be in float32. This causes the positional encodings to lose precision dramatically especially for very large context lengths.

Below I pasted the image on how HF for now handles RoPE. You can see the loss in precision when using bfloat16. I manually autocasted it to float32 in Unsloth, and you can see the expected positional encodings.
![image](https://github.com/huggingface/transformers/assets/23090290/ce691e66-ac77-4904-a4f1-ecf15db48a16)

I couldn't find why Unsloth's error could not match that of HF's original Gemma implementation. On float16, this issue does not occur, with HF and Unsloth's training loss curve being equivalent:
![image](https://github.com/huggingface/transformers/assets/23090290/eda26d8a-2102-4f17-baaa-dc6b9d93d799)

However when I switched over to bfloat16, HF and Unsloth's training losses diverge at the start, and Unsloth always retains a lower loss as training goes on:
![image](https://github.com/huggingface/transformers/assets/23090290/179c0d31-45f9-4109-8eb1-33ed0a7b74b9)

If you look at the losses more carefully (same seed), you can see the differences more closely.
![image](https://github.com/huggingface/transformers/assets/23090290/22b94ff9-96ac-4d15-9c18-ede35e3920c8)

The culprit I found was
```python
inv_freq_expanded = self.inv_freq[None, :, None].float().expand(position_ids.shape[0], -1, 1)
position_ids_expanded = position_ids[:, None, :].float()
freqs = (inv_freq_expanded @ position_ids_expanded).transpose(1, 2)
emb = torch.cat((freqs, freqs), dim=-1)
```
where if one uses `torch.autocast()`, `freqs = (inv_freq_expanded @ position_ids_expanded).transpose(1, 2)` gets done in bfloat16 and not float32. I propose we turn off autocast to force float32. Ie:
```python
with torch.autocast(device_type=position_ids_expanded.device.type, enabled=False):
    freqs = (inv_freq_expanded.float() @ position_ids_expanded.float()).transpose(1, 2)
```
This ensures `torch.autocast` to turn off automatic downcasting to float16 / bfloat16 for the RoPE embeddings. My proposed fix shows the following loss curve:
![image](https://github.com/huggingface/transformers/assets/23090290/fefe0663-ec79-4cac-8ffe-dfc932bd09f3)

Also, in Gemma, a 1 liner was missed :) `logits = logits.float()` must be placed to upcast the `logits` to float32. Although it should be done automatically in `torch.autocast`, it's best to keep the convention as done in llama, mistral and other models. Gemma's implementation seems to maybe have forgotten this 1 line :)

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

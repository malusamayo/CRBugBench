#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/transformers/modeling_utils.py`:

This pull request introduces the defect later reported as "apply_chunking_to_forward should only be the same in the chunking dimension". The
problem a user observed, and its root cause:

## Environment info
<!-- You can run the command `transformers-cli env` and copy-and-paste its output below.
     Don't forget to fill out the missing fields in that output! -->
     
- `transformers` version: 3.4.0
- Platform: All
- Python version:
- PyTorch version (GPU?):
- Tensorflow version (GPU?):
- Using GPU in script?:
- Using distributed or parallel set-up in script?:

### Who can help
<!-- Your issue will be replied to more quickly if you can figure out the right person to tag with @
 If you know how to use git blame, that is the easiest way, otherwise, here is a rough guide of **who to tag**.
 Please tag fewer than 3 people.
 
 albert, bert, GPT2, XLM: @LysandreJik 
 tokenizers: @mfuntowicz
 Trainer: @sgugger
 Speed and Memory Benchmarks: @patrickvonplaten
 Model Cards: @julien-c
 Translation: @sshleifer
 Summarization: @sshleifer
 TextGeneration: @TevenLeScao 
 examples/distillation: @VictorSanh
 nlp datasets: [different repo](https://github.com/huggingface/nlp)
 rust tokenizers: [different repo](https://github.com/huggingface/tokenizers)
 Text Generation: @patrickvonplaten @TevenLeScao
 blenderbot: @mariamabarham
 Bart: @sshleifer
 Marian: @sshleifer
 T5: @patrickvonplaten
 Longformer/Reformer: @patrickvonplaten
 TransfoXL/XLNet: @TevenLeScao
 RAG: @patrickvonplaten, @lhoestq
 FSTM: @stas00
 examples/seq2seq: @sshleifer
 examples/bert-loses-patience: @JetRunner
 tensorflow: @jplu
 examples/token-classification: @stefan-it
 documentation: @sgugger
 -->

## Information

Model I am using (Bert, XLNet ...): XLNet

The problem arises when using:
* [ ] the official example scripts: (give details below)
* [x] my own modified scripts: (give details below)

The tasks I am working on is:
* [ ] an official GLUE/SQUaD task: (give the name)
* [x] my own task or dataset: (give details below)

## To reproduce

Steps to reproduce the behavior:

1. Simply send in 2 tensor to the apply_chunking_to_forward that have the same batch length, same batch size, but different dimensionality and it will pop up with an exception


<!-- If you have code snippets, error messages, stack traces please provide them here as well.
     Important! Use code tags to correctly format your code. See https://help.github.com/en/github/writing-on-github/creating-and-highlighting-code-blocks#syntax-highlighting
     Do not use screenshots, as they are hard to read and (more importantly) don't allow others to copy-and-paste your code.-->

## Expected behavior
Should only chunk if they are the same in the chunk dimension

```
 assert len(input_tensors) > 0, "{} has to be a tuple/list of tensors".format(input_tensors)
    tensor_shape = input_tensors[0].shape
    assert all(
        input_tensor.shape == tensor_shape for input_tensor in input_tensors
    ), "All input tenors have to be of the same shape"
```
Should be:
```
    tensor_shape = input_tensors[0].shape[chunk_dim]
    assert all(
        input_tensor.shape[chunk_dim] == tensor_shape for input_tensor in input_tensors
    ), "All input tenors have to be of the same shape"
```

In here if there are 2 input tensors with the shapes:
[512,2,768] and [512,2,300] the method throws an exception when it should only chunk based on the chunk dimension (in this case 2).

This same root cause must be fixed before merging.
REVIEW_EOF

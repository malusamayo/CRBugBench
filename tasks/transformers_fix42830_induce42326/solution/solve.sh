#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/transformers/pipelines/text_to_audio.py`:

This pull request introduces the defect later reported as "SpeechT5 TTS pipeline breaks by processor.". The
problem a user observed, and its root cause:

### System Info

latest transformers

### Who can help?

@ebezzam @vasqu @Rocketknight1 

### Information

- [ ] The official example scripts
- [ ] My own modified scripts

### Tasks

- [ ] An officially supported task in the `examples` folder (such as GLUE/SQuAD, ...)
- [ ] My own task or dataset (give details below)

### Reproduction

```python
import torch
from transformers import pipeline

synthesiser = pipeline("text-to-speech", "microsoft/speecht5_tts")
speaker_embedding = (torch.rand(1, 512) * 0.2 - 0.1).to(torch.float16)

speech = synthesiser("Hello, my dog is cooler than you!", forward_params={"speaker_embeddings": speaker_embedding})
```

After PR #42326 , it got error:
```
Traceback (most recent call last):
  File "/home/jiqingfe/transformers/test_speecht5.py", line 7, in <module>
    speech = synthesiser("Hello, my dog is cooler than you!", forward_params={"speaker_embeddings": speaker_embedding})
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/jiqingfe/transformers/src/transformers/pipelines/text_to_audio.py", line 252, in __call__
    return super().__call__(text_inputs, **forward_params)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/jiqingfe/transformers/src/transformers/pipelines/base.py", line 1286, in __call__
    return self.run_single(inputs, preprocess_params, forward_params, postprocess_params)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/jiqingfe/transformers/src/transformers/pipelines/base.py", line 1292, in run_single
    model_inputs = self.preprocess(inputs, **preprocess_params)
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/jiqingfe/transformers/src/transformers/pipelines/text_to_audio.py", line 175, in preprocess
    output = preprocessor(text, **kwargs, return_tensors="pt")
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/jiqingfe/transformers/src/transformers/models/speecht5/processing_speecht5.py", line 76, in __call__
    raise ValueError(
ValueError: You need to specify either an `audio`, `audio_target`, `text`, or `text_target` input to process.
```

### Expected behavior

Previous behavior use tokenizer instead of processor.

This same root cause must be fixed before merging.
REVIEW_EOF

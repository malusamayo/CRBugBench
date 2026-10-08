# Code Review Task

You are a maintainer reviewing a pull request to the `PaddlePaddle/PaddleOCR` repository.

**PR title:** add ocr test ci shell script

**PR description:**

## 使用说明：
模式1: lite_train_infer
CI：  少量数据集训练、预测打通验证
bash test/prepare.sh   ./test/ocr_det_params.txt  'lite_train_infer'
bash test/test.sh ./test/ocr_det_params.txt  'lite_train_infer'

模式2: whole_infer
CI： 少量数据训练，全量数据预测，验证训练模型预测速度是否合理
bash test/prepare.sh   ./test/ocr_det_params.txt  'whole_infer'
bash test/test.sh ./test/ocr_det_params.txt  'whole_infer'

模式3: infer
CI ：不训练，全量数据预测，走通开源模型评估、动转静，检查inference model预测时间和精度
bash test/prepare.sh   ./test/ocr_det_params.txt  'infer'
bash test/test.sh ./test/ocr_det_params.txt 'infer'

模式4: whole_train_infer
CE： 全量数据训练，全量数据预测，验证模型训练精度，预测精度，预测速度
bash test/prepare.sh   ./test/ocr_det_params.txt  'whole_train_infer'
bash test/test.sh ./test/ocr_det_params.txt  'whole_train_infer'

## TODO：
- [ ]  test/test.sh 支持C++预测
- [x] 支持加载不同pretrain model，量化裁剪训练需要
- [x] 支持下载敏感度分析文件，减少敏感度分析时间
- [x] 上传infer.sh所需要的数据集，测试速度
- [x] 套件代码预测增加warmup逻辑, [PR](https://github.com/PaddlePaddle/PaddleOCR/pull/3061)
- [x] 增加env 变量，支持设置环境变量
- [x] 增加paddleslim依赖


Reference PR :
https://github.com/PaddlePaddle/PaddleOCR/pull/2926
https://github.com/PaddlePaddle/PaddleOCR/pull/3069
https://github.com/PaddlePaddle/PaddleOCR/pull/3061
https://github.com/PaddlePaddle/PaddleOCR/pull/3203
https://github.com/PaddlePaddle/PaddleOCR/pull/3182

## Working environment

The repository is checked out at `/app/PaddleOCR` at this PR's **base commit**
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

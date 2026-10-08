# Code Review Task

You are a maintainer reviewing a pull request to the `PaddlePaddle/PaddleOCR` repository.

**PR title:** [tipc] merge benchmark to tipc

**PR description:**

2022.1.28：
1. benchmark_params放在tipc的txt最后；benchmark.txt不在需要
2. 针对benchmark运行不跑infer的问题，需要在benchmark_train.sh中把eval, export设置为null;
3. device_num; run_process; run_mode 三个参数从benchmark中去掉；
4. speed_unit；skip_steps；keyword:ips；convergence_key:loss统一套件规范，设置为固定的参数；不在benchmark.txt中设置；
5. benchmark_train.sh中检索benchmark_params, 如果没有就报错；不跑benchmark，提示这个模型不支持benchmark训练；

2022.1.27：
该PR用于db benchmark测试合并到tipc，主要改动有：
- 新增benchmark.txt（仅包含训练部分参数）
- prepare.sh中新增下载benchmark测试用到的数据集
- 新增benchmark_train.sh

# 使用方式
benchmark的命令运行方式是：
bash  test_tipc/benchmark_train.sh  config.txt  mode  params

以PaddleOCR的db模型为例，benchmark运行方式如下：
```shell
bash test_tipc/benchmark_train.sh test_tipc/configs/det_mv3_db_v2.0/train_benchmark.txt  benchmark_train dynamic_bs8_null_SingleP_DP_N1C1
```

各部分参数解析如下：
config.txt：即对应 `test_tipc/configs/det_mv3_db_v2.0/train_benchmark.txt`表示当前要使用的参数配置文件，每个模型的参数配置文件默认以train_benchmark.txt 名字区分，并存放在每个模型的目录下；
mode：即对应benchmark_train模式，无需修改
params: 即对应`benchmark_train dynamic_bs8_fp32_SingleP_DP_N1C1`，表示当前模型的运行参数配置；


## 日志解析

执行后的日志文件格式如下：

![image](https://user-images.githubusercontent.com/26592129/150942326-44b94c5d-ba67-4736-a109-45f389173a7a.png)

执行完后在默认在repo根目录下创建benchmark_log文件夹，用于存放训练日志，其格式如下：

![image](https://user-images.githubusercontent.com/26592129/151300762-070b744b-e7f2-4782-adf5-bdd0f53c0069.png)

benchmark_train.sh中解析完后会自动解析日志，日志解析的输出如下所示：
![image](https://user-images.githubusercontent.com/26592129/151296484-a7b62025-a639-46be-ade2-a19981c9d2c1.png)



## 遇到的问题
1. cuda10.1上开启profile会报错，cuda10.2正常，报错信息如下：
![034aa085d5b5e6164086ac5dacd5cd1b](https://user-images.githubusercontent.com/26592129/150944342-26e5051a-a23b-4235-9dae-750275332cca.png)

2. 如果遇到如下问题，请按照[PR](https://github.com/PaddlePaddle/PaddleOCR/pull/5351)修改
![image](https://user-images.githubusercontent.com/26592129/151286807-004972ba-c3e2-4abc-bc8f-7eecd727470e.png)

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

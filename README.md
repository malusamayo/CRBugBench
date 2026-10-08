# CRBugBench

We rebuilt CRBugBench from descriptions in the paper: (When) Should a Software Factory be Lights-off?
Benchmarking Code Review Agents on Bug Detection.

This contains 995 [Harbor](https://github.com/harbor-framework/harbor)-format code-review tasks,
mined from 98 open-source GitHub repositories: 500 on the fix track and 495 on the comment track. 

An agent reviews a real pull request; an LLM judge panel inside the container then decides whether the review caught a known defect the agent never sees.

## Requirements

* Docker
* uv
* [Harbor](https://github.com/harbor-framework/harbor) (`uv tool install harbor`)
* An agent harness for Harbor runs (e.g., Copilot and Codex CLIs)

Each task builds its own environment from `environment/Dockerfile`:
a published repository image (`docker.io/malusamayo/swe-review-repo-<repository>:v1`, the
repository's git history). Nothing else needs to be set up.

## Run

```bash
export GITHUB_TOKEN="$(gh auth token)"     # the Copilot judges (and copilot-cli agent)
python scripts/run.py --agent codex --model gpt-6-luna --sample 10
python scripts/summarize.py jobs/*
```

`scripts/run.py` selects tasks with `--track fix|comments`, `--repo <name>`,
`--task <id>` (each repeatable) and `--sample N` (balanced across repositories,
`--seed` to vary), then calls `harbor run`; arguments after `--` go to Harbor.
Without a selection, it runs every task. Harbor works directly too:

```bash
harbor run --path tasks --agent codex --model gpt-6-luna --include-task-name axios_fix581_induce160
```

Agents bring their own credentials, e.g. Harbor's `codex` agent reads
`OPENAI_API_KEY`, or your ChatGPT login with `CODEX_FORCE_AUTH_JSON=1`.

## Judges

Inside each container an LLM judge panel scores the agent's `/app/review.md`
against the task's ground truth. The default panel is gpt-5.5, claude-opus-4.8, gemini-3.5-flash through
the GitHub Copilot CLI, so `GITHUB_TOKEN` must belong to an account that can
select those models. To judge with models you can call instead:

```bash
python scripts/set_judges.py --models gpt-5.5,gpt-5.6-sol,gpt-5.6-terra --runtime codex
export CODEX_AUTH_JSON="$(cat ~/.codex/auth.json)"
```

`set_judges.py` rewrites only the judge lines of each `tasks/*/task.toml`.

## Tasks

`tasks/index.json` lists every task with its `track` and repository:

| Track | Task id | The agent reviews | Ground truth |
| --- | --- | --- | --- |
| `fix` | `<repo>_fix<fix-pr>_induce<pr>` | the PR that introduced a bug | the issue its later fix closed |
| `comments` | `<repo>_comment<pr>` | the snapshot a human reviewer saw | the bugs that reviewer flagged |

A fix task's repository is checked out at the PR's base commit with the change
in `/app/pr_to_review.diff`; a comment task's repository has the reviewed diff
applied. Later history is pruned, so the fix is never reachable.

## Results

Each trial writes `verifier/reward.json` (`reward` is the mean strict detection
over the task's cases; `detected_lenient` also credits partial matches) and
`verifier/judge_details.json` (every judge's verdict and rationale).
`scripts/summarize.py` aggregates them by track.

## Disk

The first task of a repository pulls that repository's history (up to 19 GB);
later tasks of the same repository reuse it from Docker's build cache. Each
built task adds a repacked copy of the history up to its base commit, about
650 GB for all tasks, so run large selections in batches and
`docker builder prune` between them.

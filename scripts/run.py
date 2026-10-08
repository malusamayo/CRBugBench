#!/usr/bin/env python3
"""Run benchmark tasks with Harbor.

    python scripts/run.py --agent codex --model gpt-6-luna --track fix --sample 20
    python scripts/run.py --agent copilot-cli --model gpt-5.5 --task axios_fix581_induce160
    python scripts/run.py --agent codex --model gpt-6-luna -- --timeout-multiplier 2

Selection flags combine (track, repositories, task ids, then a seeded sample
balanced across repositories); with none, every task runs. Arguments after
``--`` go to ``harbor run`` unchanged. Needs only Python, Docker, and Harbor.
"""

from __future__ import annotations

import argparse
import json
import random
import shlex
import subprocess
import sys
from collections.abc import Sequence
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TASKS = ROOT / "tasks"


def stratified_sample(tasks: Sequence[dict], size: int, seed: int) -> list[dict]:
    """A deterministic round-robin sample across repositories."""
    target = min(size, len(tasks))
    groups: dict[str, list[dict]] = {}
    for task in tasks:
        groups.setdefault(str(task.get("repo") or ""), []).append(task)
    rng = random.Random(seed)
    for values in groups.values():
        rng.shuffle(values)
    selected: list[dict] = []
    while len(selected) < target:
        active = sorted(name for name, values in groups.items() if values)
        if not active:
            break
        rng.shuffle(active)
        for name in active:
            selected.append(groups[name].pop())
            if len(selected) == target:
                break
    return selected


def select(
    tasks: Sequence[dict],
    *,
    track: str | None = None,
    repositories: Sequence[str] = (),
    task_ids: Sequence[str] = (),
    sample: int | None = None,
    seed: int = 42,
) -> list[str]:
    """Task ids matching every given filter, in index order."""
    chosen = [
        task for task in tasks
        if (track is None or task["track"] == track)
        and (not repositories or task["repo"] in repositories)
        and (not task_ids or task["task_id"] in task_ids)
    ]
    if sample:
        chosen = stratified_sample(chosen, sample, seed)
    return [task["task_id"] for task in chosen]


def harbor_command(args: argparse.Namespace, task_ids: Sequence[str], select_all: bool) -> list[str]:
    command = [
        "harbor", "run", "--path", str(TASKS), "--jobs-dir", str(args.jobs_dir),
        "--agent", args.agent, "-k", str(args.attempts),
        "--n-concurrent", str(args.concurrency), "-y",
    ]
    if args.model:
        command += ["--model", args.model]
    if not select_all:
        for task_id in task_ids:
            command += ["--include-task-name", task_id]
    return command + list(args.harbor_args)


def main(argv: Sequence[str] | None = None) -> int:
    argv = list(sys.argv[1:] if argv is None else argv)
    harbor_args = argv[argv.index("--") + 1:] if "--" in argv else []
    own = argv[: argv.index("--")] if "--" in argv else argv
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument("--agent", required=True, help="Harbor agent, e.g. codex or copilot-cli")
    parser.add_argument("--model", help="model for the agent")
    parser.add_argument("-k", "--attempts", type=int, default=1)
    parser.add_argument("--concurrency", type=int, default=4)
    parser.add_argument("--track", choices=("fix", "comments"))
    parser.add_argument("--repo", action="append", default=[], help="repository name, e.g. axios")
    parser.add_argument("--task", action="append", default=[], help="task id")
    parser.add_argument("--sample", type=int, help="sample this many tasks, balanced by repository")
    parser.add_argument("--seed", type=int, default=42)
    parser.add_argument("--jobs-dir", type=Path, default=ROOT / "jobs")
    parser.add_argument("--dry-run", action="store_true", help="print the harbor command only")
    args = parser.parse_args(own)
    args.harbor_args = harbor_args

    tasks = json.loads((TASKS / "index.json").read_text())["tasks"]
    task_ids = select(
        tasks, track=args.track, repositories=args.repo, task_ids=args.task,
        sample=args.sample, seed=args.seed,
    )
    if not task_ids:
        parser.error("no task matches the selection")
    select_all = len(task_ids) == len(tasks)
    command = harbor_command(args, task_ids, select_all)
    print(f"{len(task_ids)} tasks -> {args.jobs_dir}", file=sys.stderr)
    if args.dry_run:
        print(shlex.join(command))
        return 0
    return subprocess.call(command)


if __name__ == "__main__":
    sys.exit(main())

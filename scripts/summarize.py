#!/usr/bin/env python3
"""Summarize Harbor runs of the benchmark by track.

    python scripts/summarize.py jobs/2026-10-08__12-00-00 [more job folders]
    python scripts/summarize.py jobs/* --json results.json

``detected`` is the mean strict verdict (the judge panel agrees the review
names the defect), ``lenient`` also credits partial matches, and ``any`` is the
share of tasks whose defect at least one trial caught. A trial without a score
(an agent error, or no review written) counts as not detected.
"""

from __future__ import annotations

import argparse
import json
import sys
from collections import defaultdict
from collections.abc import Iterable, Sequence
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def load_trials(job_dirs: Iterable[Path]) -> list[dict]:
    """One record per trial folder (``<task>__<id>``) under the job folders."""
    trials = []
    for job in job_dirs:
        for result in sorted(job.glob("*__*/result.json")):
            value = json.loads(result.read_text())
            rewards = (value.get("verifier_result") or {}).get("rewards") or {}
            trials.append({
                "task_id": result.parent.name.rsplit("__", 1)[0],
                "reward": float(rewards.get("reward") or 0.0),
                "lenient": float(rewards.get("detected_lenient") or 0.0),
                "scored": bool(rewards.get("n_judges")),
                "error": (value.get("exception_info") or {}).get("exception_type"),
            })
    return trials


def summarize(trials: Sequence[dict], tracks: dict[str, str]) -> dict[str, dict]:
    by_track: dict[str, list[dict]] = defaultdict(list)
    for trial in trials:
        by_track[tracks.get(trial["task_id"], "unknown")].append(trial)
    summary = {}
    for track, rows in sorted(by_track.items()):
        tasks: dict[str, list[dict]] = defaultdict(list)
        for row in rows:
            tasks[row["task_id"]].append(row)
        summary[track] = {
            "trials": len(rows),
            "tasks": len(tasks),
            "unscored": sum(not row["scored"] for row in rows),
            "errors": sum(bool(row["error"]) for row in rows),
            "detected": sum(row["reward"] for row in rows) / len(rows),
            "lenient": sum(row["lenient"] for row in rows) / len(rows),
            "any": sum(any(row["reward"] > 0 for row in group) for group in tasks.values())
            / len(tasks),
        }
    return summary


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument("jobs", nargs="+", type=Path, help="Harbor job folders")
    parser.add_argument("--json", type=Path, help="also write the summary here")
    args = parser.parse_args(argv)
    index = json.loads((ROOT / "tasks" / "index.json").read_text())
    tracks = {task["task_id"]: task["track"] for task in index["tasks"]}
    summary = summarize(load_trials(args.jobs), tracks)
    if not summary:
        parser.error("no trials found under the given job folders")
    print(f"{'track':10} {'trials':>6} {'tasks':>6} {'unscored':>8} {'errors':>6} "
          f"{'detected':>8} {'lenient':>8} {'any':>6}")
    for track, row in summary.items():
        print(f"{track:10} {row['trials']:>6} {row['tasks']:>6} {row['unscored']:>8} "
              f"{row['errors']:>6} {row['detected']:>8.3f} {row['lenient']:>8.3f} "
              f"{row['any']:>6.3f}")
    if args.json:
        args.json.write_text(json.dumps(summary, indent=2) + "\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())

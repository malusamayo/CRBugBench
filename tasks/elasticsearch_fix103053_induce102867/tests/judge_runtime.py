"""Shared case evaluation and output handling for generated verifiers."""

from __future__ import annotations

import json
from collections.abc import Callable, Sequence
from pathlib import Path

try:
    from . import judge_common
except ImportError:  # Copied into a generated task's /tests directory.
    import judge_common


def load_inputs(
    ground_truth_path: Path,
    review_path: Path,
) -> tuple[dict, str]:
    ground_truth = json.loads(ground_truth_path.read_text())
    review = review_path.read_text() if review_path.exists() else ""
    return ground_truth, review


def evaluate_cases(
    cases: Sequence[dict],
    review: str,
    build_prompt: Callable[[dict, str], str],
    case_metadata: Callable[[dict], dict] | None = None,
) -> list[dict]:
    """Evaluate each ground-truth case against the same review."""
    results = []
    for case in cases:
        per_judge = judge_common.judge_prompt(build_prompt(case, review))
        result = {
            "per_judge": per_judge,
            **summarize_judges(per_judge),
        }
        if case_metadata is not None:
            result = {**case_metadata(case), **result}
        results.append(result)
    return results


def summarize_judges(per_judge: Sequence[dict]) -> dict:
    """Recompute one case's scores from its judge panel."""
    if not per_judge:
        raise ValueError("cannot summarize an empty judge panel")
    strict = [judge["strict"] for judge in per_judge]
    lenient = [judge["lenient"] for judge in per_judge]
    levels = [judge["detected"] for judge in per_judge]
    count = len(per_judge)
    return {
        "strict": sum(strict) / count,
        "lenient": sum(lenient) / count,
        "consensus": min(strict),
        "any": max(strict),
        "agreement": int(len(set(levels)) == 1),
    }


def aggregate(results: Sequence[dict]) -> dict:
    """Average case-level scores while preserving panel-size metadata."""
    count = len(results)
    if count == 0:
        raise ValueError("cannot aggregate an empty case list")
    return {
        "reward": sum(result["strict"] for result in results) / count,
        "detected_strict": (
            sum(result["strict"] for result in results) / count
        ),
        "detected_lenient": (
            sum(result["lenient"] for result in results) / count
        ),
        "detected_strict_consensus": (
            sum(result["consensus"] for result in results) / count
        ),
        "detected_strict_any": (
            sum(result["any"] for result in results) / count
        ),
        "judge_agreement": (
            sum(result["agreement"] for result in results) / count
        ),
        "n_cases": count,
        "n_judges": len(results[0]["per_judge"]),
    }


def zero_outputs(
    reason: str,
    *,
    track: str,
    task: dict,
    n_cases: int,
) -> tuple[dict, dict]:
    reward = {
        "reward": 0.0,
        "detected_strict": 0.0,
        "detected_lenient": 0.0,
        "detected_strict_consensus": 0.0,
        "detected_strict_any": 0.0,
        "judge_agreement": 0.0,
        "n_cases": n_cases,
        "n_judges": 0,
    }
    details = {
        "track": track,
        "task": task,
        "reason": reason,
        "n_cases": n_cases,
        "judge_agreement": 0.0,
        "cases": [],
    }
    return reward, details


def write_outputs(
    reward_path: Path,
    details_path: Path,
    reward: dict,
    details: dict,
) -> None:
    reward_path.write_text(json.dumps(reward))
    details_path.write_text(json.dumps(details, indent=2))


def print_judges(per_judge: Sequence[dict], *, indent: str = "  ") -> None:
    for judge in per_judge:
        flag = "" if judge["parsed"] else "  [warn: unparsed JSON]"
        print(
            f"{indent}- {judge['model']}: detected={judge['detected']} "
            f"strict={judge['strict']}{flag}"
        )
        justification = judge["justification"].strip() or "(none)"
        print(f"{indent}    justification: {justification}")
        evidence = judge["evidence_quote"].strip()
        print(f"{indent}    evidence_quote: {evidence or '(none)'}")
        if judge["review_items"]:
            print(
                f"{indent}    item_matches: {judge['item_matches']} "
                f"({judge['matched_item_count']}/"
                f"{len(judge['review_items'])} items match)"
            )
        if not judge["parsed"]:
            print(
                f"{indent}    raw_reply: "
                f"{judge['raw_reply'].strip() or '(empty reply)'}"
            )

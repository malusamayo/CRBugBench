"""Unified verifier for every review benchmark track."""

from __future__ import annotations

import json
from pathlib import Path

try:
    from . import judge_runtime
except ImportError:  # Copied into a generated task's /tests directory.
    import judge_runtime


def _display(value: object) -> str:
    if isinstance(value, str):
        return value
    return json.dumps(value, ensure_ascii=False)


def _fields(values: dict) -> str:
    return "\n".join(
        f"- {name.replace('_', ' ')}: {_display(value)}"
        for name, value in values.items()
        if value not in (None, "", [], {})
    ) or "- (none)"


def build_prompt(case: dict, review: str) -> str:
    return f"""You are judging whether a blind code review caught one specific known defect.

The reviewer saw ONLY the pull request under review. The ground-truth evidence
below was not available to the reviewer. Use it only to establish what the real
defect was.

GROUND-TRUTH DEFECT:
- provenance: {case.get("provenance")}
- summary: {case.get("summary")}
- description:
{case.get("description")}

LOCATION:
{_fields(case.get("location") or {})}

CORROBORATING EVIDENCE:
{_fields(case.get("evidence") or {})}

THE REVIEW UNDER TEST:
{review}

Did the review identify THIS SPECIFIC defect: the same faulty behaviour and root
cause, at the right code? Unrelated issues do NOT count. Be strict about
substance and lenient about wording.

Also break the review under test into its DISCRETE items -- each distinct finding,
concern, or comment the reviewer raised, in the order they appear -- and for each
item output 1 if THAT item identifies this defect or 0 otherwise.
``item_matches`` must be parallel to ``review_items`` (same length and order);
``detected`` is "no" only if every entry is 0.

Respond with ONLY a JSON object (no prose, no code fences) of the form:
{{"detected": "yes|partial|no", "evidence_quote": "<verbatim review sentence or empty>", "justification": "<1-3 sentences>", "review_items": ["<one-line summary of each discrete review item, in order>"], "item_matches": [0 or 1 for each review item, parallel to review_items]}}
where "yes" means it clearly flags the same issue at the right location,
"partial" means it touches the right code/area or a related symptom but misses
the actual defect, and "no" means it never mentions this defect."""


def _case_metadata(case: dict) -> dict:
    return {
        "id": case.get("id"),
        "summary": case.get("summary"),
        "location": case.get("location") or {},
    }


def _validate_ground_truth(ground_truth: dict) -> tuple[str, dict, list[dict]]:
    track = ground_truth.get("track")
    task = ground_truth.get("task")
    cases = ground_truth.get("cases")
    if not isinstance(track, str) or not track:
        raise ValueError("ground truth must contain a non-empty track")
    if not isinstance(task, dict):
        raise ValueError("ground truth must contain a task object")
    if not isinstance(cases, list) or any(
        not isinstance(case, dict) for case in cases
    ):
        raise ValueError("ground truth must contain a cases array of objects")
    return track, task, cases


def main(
    ground_truth_path: Path = Path("/tests/ground_truth.json"),
    review_path: Path = Path("/app/review.md"),
    reward_path: Path = Path("/logs/verifier/reward.json"),
    details_path: Path = Path("/logs/verifier/judge_details.json"),
) -> None:
    ground_truth, review = judge_runtime.load_inputs(
        ground_truth_path,
        review_path,
    )
    track, task, cases = _validate_ground_truth(ground_truth)
    if not review.strip() or not cases:
        reason = "empty review" if not review.strip() else "no cases"
        reward, details = judge_runtime.zero_outputs(
            reason,
            track=track,
            task=task,
            n_cases=len(cases),
        )
        judge_runtime.write_outputs(reward_path, details_path, reward, details)
        print(f"{reason} -> reward 0")
        return

    results = judge_runtime.evaluate_cases(
        cases,
        review,
        build_prompt,
        _case_metadata,
    )
    reward = judge_runtime.aggregate(results)
    details = {
        "track": track,
        "task": task,
        "reward": reward["reward"],
        "n_cases": len(results),
        "judge_agreement": reward["judge_agreement"],
        "cases": results,
    }
    judge_runtime.write_outputs(reward_path, details_path, reward, details)

    print("=" * 70)
    print(
        f"JUDGE: track={track} cases={len(results)} "
        f"reward={reward['reward']:.3f} "
        f"lenient={reward['detected_lenient']:.3f} "
        f"agreement={reward['judge_agreement']:.3f}"
    )
    for case in results:
        print(
            f"  - {case['id']} {case['summary']}: "
            f"strict={case['strict']:.2f} lenient={case['lenient']:.2f}"
        )
        judge_runtime.print_judges(case["per_judge"], indent="      ")
    print("=" * 70)


if __name__ == "__main__":
    main()

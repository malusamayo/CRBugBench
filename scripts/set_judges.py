"""Point a Harbor dataset's verifiers at another judge panel.

Standalone on purpose: it uses only the standard library, so the exported
benchmark ships this file as ``scripts/set_judges.py`` and needs nothing
installed.

    python scripts/set_judges.py --models gpt-5.5,gpt-5.6-sol,gpt-5.6-terra --runtime codex
"""

from __future__ import annotations

import argparse
import json
import re
from collections.abc import Sequence
from pathlib import Path

RUNTIMES = ("copilot-cli", "codex")
_JUDGE_LINE = re.compile(r"^(JUDGE_MODELS|JUDGE_RUNTIME|CODEX_AUTH_JSON) = .*\n", re.M)


def judge_credentials(runtime: str) -> str:
    """Extra ``[verifier.env]`` lines the judge runtime needs from the host."""
    if runtime == "codex":
        return '\nCODEX_AUTH_JSON = "${CODEX_AUTH_JSON}"'
    return ""


def retarget_judges(dataset_dir: Path, models: Sequence[str], runtime: str) -> int:
    """Rewrite every task's judge panel and runtime; return the tasks changed.

    Only the judge lines of ``[verifier.env]`` change: ground truth, diffs, and
    images are untouched, so a researcher without access to the published
    panel can still score the benchmark with models they can call.
    """
    if runtime not in RUNTIMES:
        raise ValueError(f"runtime must be one of {RUNTIMES}")
    block = (
        f'JUDGE_MODELS = "{",".join(models)}"\n'
        f'JUDGE_RUNTIME = "{runtime}"{judge_credentials(runtime)}\n'
    )
    changed = 0
    for task in sorted(dataset_dir.iterdir()):
        toml = task / "task.toml"
        if not toml.exists():
            continue
        text = toml.read_text()
        head, marker, rest = text.partition("[verifier.env]\n")
        if not marker:
            raise ValueError(f"{toml} has no [verifier.env] table")
        body, separator, tail = rest.partition("\n[")
        body = _JUDGE_LINE.sub("", body.rstrip("\n") + "\n") + block
        toml.write_text(
            head + marker + body.rstrip("\n") + (separator + tail if separator else "\n")
        )
        changed += 1
    index = dataset_dir / "index.json"
    if index.exists():
        value = json.loads(index.read_text())
        value["judge_models"] = list(models)
        index.write_text(json.dumps(value, indent=2) + "\n")
    return changed


def main(argv: Sequence[str] | None = None) -> None:
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument("--models", required=True, help="comma-separated judge models")
    parser.add_argument("--runtime", choices=RUNTIMES, default="copilot-cli")
    parser.add_argument(
        "--dataset",
        type=Path,
        default=Path(__file__).resolve().parent.parent / "tasks",
        help="folder of task directories (default: ../tasks next to this script)",
    )
    args = parser.parse_args(argv)
    models = [model.strip() for model in args.models.split(",") if model.strip()]
    changed = retarget_judges(args.dataset, models, args.runtime)
    print(f"Judging {changed} tasks with {','.join(models)} via {args.runtime}")


if __name__ == "__main__":
    main()

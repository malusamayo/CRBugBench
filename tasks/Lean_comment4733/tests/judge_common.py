"""Shared judge-panel execution (Copilot CLI or Codex) and verdict parsing."""

from __future__ import annotations

import json
import os
import re
import subprocess
import tempfile
from pathlib import Path

LEVEL_SCORE = {"yes": 1.0, "partial": 0.5, "no": 0.0}


class JudgeResponseError(ValueError):
    """Raised when a judge response violates the required schema."""


def judge_models() -> list[str]:
    """Return the configured judge panel, or one default-model entry."""
    raw = os.getenv("JUDGE_MODELS", "").strip() or os.getenv(
        "JUDGE_MODEL", ""
    ).strip()
    models = [model.strip() for model in raw.split(",") if model.strip()]
    return models or [""]


def run_copilot(prompt: str, model: str = "") -> str:
    """Run one tool-free Copilot judge attempt."""
    command = [
        "copilot",
        "--prompt",
        prompt,
        "--output-format",
        "json",
        "--available-tools=",
        "--no-ask-user",
        "--no-custom-instructions",
        "--disable-builtin-mcps",
    ]
    if model:
        command += ["--model", model]
    try:
        process = subprocess.run(
            command,
            capture_output=True,
            text=True,
            timeout=600,
        )
    except subprocess.TimeoutExpired:
        return ""
    return _last_assistant_message(process.stdout)


def run_codex(prompt: str, model: str = "") -> str:
    """Run one Codex judge attempt in a throwaway, read-only CODEX_HOME.

    ``CODEX_AUTH_JSON`` carries the contents of a Codex ``auth.json`` (a ChatGPT
    login or an API key). The prompt goes in on stdin, so long diffs never hit
    the argument-length limit.
    """
    with tempfile.TemporaryDirectory() as home:
        auth = os.getenv("CODEX_AUTH_JSON", "")
        if auth:
            Path(home, "auth.json").write_text(auth)
        reply = Path(home, "reply.txt")
        command = [
            "codex", "exec", "--skip-git-repo-check", "--ephemeral",
            "--sandbox", "read-only", "--output-last-message", str(reply),
        ]
        if model:
            command += ["--model", model]
        try:
            subprocess.run(
                command + ["-"],
                input=prompt,
                capture_output=True,
                text=True,
                timeout=600,
                cwd=home,
                env={**os.environ, "CODEX_HOME": home},
            )
        except subprocess.TimeoutExpired:
            return ""
        return reply.read_text().strip() if reply.exists() else ""


JUDGE_RUNTIMES = {"copilot-cli": "run_copilot", "codex": "run_codex"}


def run_judge(prompt: str, model: str = "") -> str:
    """Run one judge attempt through the runtime ``JUDGE_RUNTIME`` names."""
    runtime = os.getenv("JUDGE_RUNTIME", "").strip() or "copilot-cli"
    if runtime not in JUDGE_RUNTIMES:
        raise ValueError(f"unknown JUDGE_RUNTIME {runtime!r}")
    return globals()[JUDGE_RUNTIMES[runtime]](prompt, model)


def _last_assistant_message(stdout: str) -> str:
    """Return the last complete assistant message from Copilot JSONL."""
    last = ""
    for line in stdout.splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        if event.get("type") == "assistant.message":
            content = event.get("data", {}).get("content")
            if isinstance(content, str) and content:
                last = content
    return last


def extract_verdict(text: str) -> dict:
    """Extract a verdict while tolerating quotes in model-authored fields."""
    decoder = json.JSONDecoder()
    objects = []
    for match in re.finditer(r"\{", text):
        try:
            value, _ = decoder.raw_decode(text[match.start() :])
        except json.JSONDecodeError:
            continue
        if isinstance(value, dict):
            objects.append(value)
    for value in reversed(objects):
        if str(value.get("detected", "")).strip().lower() in LEVEL_SCORE:
            return value

    verdict = {}
    detected = re.search(
        r'"detected"\s*:\s*"(yes|partial|no)"',
        text,
        re.IGNORECASE,
    )
    if detected:
        verdict["detected"] = detected.group(1).lower()
    for field in ("evidence_quote", "justification"):
        value = re.search(
            r'"%s"\s*:\s*"(.*?)"\s*(?:,\s*"|\}\s*$)' % field,
            text,
            re.DOTALL,
        )
        if value:
            verdict[field] = value.group(1)
    for field in ("review_items", "item_matches"):
        start = re.search(rf'"{field}"\s*:\s*', text)
        if not start:
            continue
        try:
            value, _ = decoder.raw_decode(text[start.end() :])
        except json.JSONDecodeError:
            continue
        if isinstance(value, list):
            verdict[field] = value
    return verdict


def validate_verdict(verdict: dict) -> None:
    """Require the complete schema needed for position-aware scoring."""
    level = str(verdict.get("detected", "")).strip().lower()
    if level not in LEVEL_SCORE:
        raise JudgeResponseError("response has no valid detected level")
    review_items = verdict.get("review_items")
    item_matches = verdict.get("item_matches")
    if not isinstance(review_items, list) or not isinstance(item_matches, list):
        raise JudgeResponseError(
            "response must contain review_items and item_matches arrays"
        )
    if len(review_items) != len(item_matches):
        raise JudgeResponseError(
            "review_items and item_matches must have the same length"
        )


def normalize_items(review_items, item_matches) -> tuple[list[str], list[int]]:
    """Return parallel review-item and normalized binary-match arrays."""
    items = review_items if isinstance(review_items, list) else []
    matches = item_matches if isinstance(item_matches, list) else []
    items = [str(item) for item in items]
    normalized = []
    for match in matches:
        try:
            normalized.append(1 if int(match) != 0 else 0)
        except (TypeError, ValueError):
            normalized.append(
                1
                if str(match).strip().lower() in ("1", "yes", "true")
                else 0
            )
    length = min(len(items), len(normalized))
    return items[:length], normalized[:length]


def judge_result(reply: str, model: str) -> dict:
    """Normalize one reply while retaining incomplete responses for repair."""
    verdict = extract_verdict(reply)
    try:
        validate_verdict(verdict)
    except JudgeResponseError:
        parsed = False
    else:
        parsed = True
    level = str(verdict.get("detected", "no")).strip().lower()
    if not parsed or level not in LEVEL_SCORE:
        level = "no"
    review_items, item_matches = normalize_items(
        verdict.get("review_items"),
        verdict.get("item_matches"),
    )
    return {
        "model": model or "default",
        "detected": level,
        "strict": 1.0 if level == "yes" else 0.0,
        "lenient": LEVEL_SCORE[level],
        "evidence_quote": verdict.get("evidence_quote", ""),
        "justification": verdict.get("justification", ""),
        "review_items": review_items,
        "item_matches": item_matches,
        "matched_item_count": sum(item_matches),
        "parsed": parsed,
        "raw_reply": reply,
    }


def judge_prompt(prompt: str) -> list[dict]:
    """Poll the configured panel and normalize each model's verdict."""
    per_judge = []
    for model in judge_models():
        reply = run_judge(prompt, model)
        per_judge.append(judge_result(reply, model))
    return per_judge

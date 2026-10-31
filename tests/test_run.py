"""Selection and dry-run regressions; no Harbor installation is required."""

import importlib.util
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest


RUN_SCRIPT = Path(__file__).resolve().parents[1] / "scripts" / "run.py"
SPEC = importlib.util.spec_from_file_location("benchmark_run", RUN_SCRIPT)
runner = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(runner)

TASKS = [
    {"task_id": "alpha_fix1", "track": "fix", "repo": "alpha"},
    {"task_id": "beta_fix1", "track": "fix", "repo": "beta"},
    {"task_id": "alpha_comments1", "track": "comments", "repo": "alpha"},
]


class SelectionTests(unittest.TestCase):
    def test_zero_sample_selects_nothing(self):
        self.assertEqual(runner.select(TASKS, sample=0), [])

    def test_omitted_sample_preserves_selection(self):
        self.assertEqual(runner.select(TASKS), [t["task_id"] for t in TASKS])
        self.assertEqual(runner.select(TASKS, track="comments"), ["alpha_comments1"])

    def test_positive_sample_is_capped_and_repeatable(self):
        first = runner.select(TASKS, sample=2, seed=7)
        self.assertEqual(len(first), 2)
        self.assertEqual(first, runner.select(TASKS, sample=2, seed=7))
        self.assertEqual(set(runner.select(TASKS, sample=10)), {t["task_id"] for t in TASKS})


class DryRunTests(unittest.TestCase):
    def invoke(self, *selection):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "scripts").mkdir()
            (root / "tasks").mkdir()
            shutil.copyfile(RUN_SCRIPT, root / "scripts" / "run.py")
            (root / "tasks" / "index.json").write_text(json.dumps({"tasks": TASKS}))
            return subprocess.run(
                [sys.executable, "-B", str(root / "scripts" / "run.py"),
                 "--agent", "fixture-agent", "--dry-run", *selection],
                capture_output=True, text=True, timeout=5,
                env={**os.environ, "PATH": "", "PYTHONDONTWRITEBYTECODE": "1"},
            )

    def test_zero_sample_is_rejected_without_harbor_command(self):
        result = self.invoke("--sample", "0")
        self.assertEqual(result.returncode, 2, result.stderr)
        self.assertEqual(result.stdout, "")
        self.assertIn("no task matches the selection", result.stderr)

    def test_zero_sample_after_track_filter_is_rejected(self):
        result = self.invoke("--track", "fix", "--sample", "0")
        self.assertEqual(result.returncode, 2, result.stderr)
        self.assertEqual(result.stdout, "")

    def test_positive_sample_keeps_one_include(self):
        result = self.invoke("--sample", "1")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout.count("--include-task-name"), 1)
        self.assertIn("1 tasks ->", result.stderr)

    def test_default_still_selects_all(self):
        result = self.invoke()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertNotIn("--include-task-name", result.stdout)
        self.assertIn("3 tasks ->", result.stderr)


if __name__ == "__main__":
    unittest.main()

#!/bin/bash
mkdir -p /logs/verifier
# Persist the agent's review to the collected logs (host gets /logs, not /app).
cp /app/review.md /logs/verifier/review.md 2>/dev/null || true
python3 /tests/llm_judge.py

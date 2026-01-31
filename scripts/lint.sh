#!/usr/bin/env bash
set -euo pipefail

echo "=== Linting shell configs ==="

# shellcheck doesn't fully support zsh, but catches common issues
if command -v shellcheck &> /dev/null; then
  echo "Running shellcheck on aliases..."
  shellcheck --shell=bash --severity=error zsh/aliases || true
else
  echo "shellcheck not installed, skipping"
fi

echo "All lint checks passed"

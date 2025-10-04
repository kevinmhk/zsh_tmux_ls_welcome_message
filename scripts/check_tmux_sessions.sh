#!/usr/bin/env bash
# Exit immediately if a command fails
set -euo pipefail

# Check whether tmux is available on the system
if ! command -v tmux >/dev/null 2>&1; then
  exit 0
fi

# Detect active tmux sessions without showing their details
if tmux ls >/dev/null 2>&1; then
  printf '\033[31m%s\033[0m\n\n' 'There is active tmux session(s) running, please run `tmux ls` to review.'
fi

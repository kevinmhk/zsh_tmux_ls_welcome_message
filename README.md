# zsh_tmux_ls_welcome_message

## Overview
This repository delivers a minimal helper that reminds you about active `tmux` sessions whenever a new Z shell starts. The solution consists of a small Bash notifier and an installation script that wires the notifier into `~/.zshrc`, ensuring you do not forget to reconnect to existing terminal workspaces.

## Features
- Detects whether `tmux` is installed before doing any work.
- Emits a concise, color-highlighted reminder when sessions are detected.
- Installs cleanly into `~/.local/bin` and appends a single-line hook to `~/.zshrc` in an idempotent fashion.
- Leaves your shell startup fast by performing only lightweight checks.

## Prerequisites
- macOS or Linux with Z shell (`zsh`) as the interactive shell.
- `tmux` available on the `PATH`. If `tmux` is absent, the notifier exits quietly.
- A writable `~/.local/bin` directory (created automatically by the installer if missing).

## Installation
Run the installer from the repository root:

```bash
./scripts/install.sh
```

The script performs the following actions:
- Copies `scripts/check_tmux_sessions.sh` to `~/.local/bin/check_tmux_sessions.sh` with executable permissions.
- Appends the line
  ```sh
  [ -x "$HOME/.local/bin/check_tmux_sessions.sh" ] && "$HOME/.local/bin/check_tmux_sessions.sh"
  ```
  to `~/.zshrc` if it is not already present.

Open a fresh terminal after installation to see the reminder in action.

## Usage
1. Launch a new `zsh` session.
2. If active `tmux` sessions exist, the notifier prints a red reminder advising you to run `tmux ls` for details.
3. If no sessions exist or `tmux` is unavailable, the shell starts silently.

## Uninstallation
1. Remove the invocation line from `~/.zshrc`.
2. Delete `~/.local/bin/check_tmux_sessions.sh` if you no longer need the helper.
3. Reload your shell configuration.

## Development Notes
- Scripts are POSIX-friendly and should remain portable across common Unix environments.
- Keep modifications defensive and simple; the notifier should do one thing well without introducing shell startup latency.
- When adding new capabilities, update this README and any related documentation to keep the information current.

## License
This project will be released under the Apache License, Version 2.0. Include the full license text in a `LICENSE` file before publishing.

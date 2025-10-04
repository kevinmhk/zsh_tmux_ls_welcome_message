#!/usr/bin/env sh
# Install the chezmoi status check helper and ensure the shell loads it.

set -eu # Fail fast on errors and undefined variables.

# Resolve paths for the helper script and destination.
SCRIPT_NAME="check_tmux_sessions.sh"
SRC_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_PATH="${SRC_DIR}/${SCRIPT_NAME}"
DEST_DIR="${HOME}/.local/bin"
DEST_PATH="${DEST_DIR}/${SCRIPT_NAME}"

# Configuration for wiring the helper into the user's shell startup.
ZSHRC_PATH="${HOME}/.zshrc"
INVOCATION_LINE='[ -x "$HOME/.local/bin/check_tmux_sessions.sh" ] && "$HOME/.local/bin/check_tmux_sessions.sh"'

# Abort if the source helper script is missing.
if [ ! -f "$SOURCE_PATH" ]; then
  echo "Error: ${SOURCE_PATH} not found." >&2
  exit 1
fi

# Stage the helper into ~/.local/bin with safe permissions.
mkdir -p "$DEST_DIR"
cp "$SOURCE_PATH" "$DEST_PATH"
chmod 755 "$DEST_PATH"

# Ensure .zshrc exists so we can append the invocation once.
touch "$ZSHRC_PATH"

# Append the invocation only if it is not present already.
if ! grep -Fqx "$INVOCATION_LINE" "$ZSHRC_PATH"; then
  echo "$INVOCATION_LINE" >> "$ZSHRC_PATH"
fi

echo "Installed ${SCRIPT_NAME} to ${DEST_PATH}."
echo "Ensured invocation is present in ${ZSHRC_PATH}."

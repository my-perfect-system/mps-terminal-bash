#!/usr/bin/env bash
# Bootstrap mps-terminal-bash: clone to ~/.local/share/mps and run install.sh.
# Standalone usage:
#   curl -fsSL https://raw.githubusercontent.com/my-perfect-system/mps-terminal-bash/main/bootstrap.sh | bash
set -euo pipefail

REPO_NAME="mps-terminal-bash"
REPO_URL="https://github.com/my-perfect-system/${REPO_NAME}.git"
DEST="${XDG_DATA_HOME:-$HOME/.local/share}/mps/${REPO_NAME}"

if [ -d "${DEST}/.git" ]; then
    echo "==> Updating ${DEST}"
    git -C "${DEST}" pull --ff-only
else
    echo "==> Cloning ${REPO_URL}"
    git clone --depth 1 "${REPO_URL}" "${DEST}"
fi

exec bash "${DEST}/install.sh"
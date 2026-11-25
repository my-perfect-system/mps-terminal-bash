#!/usr/bin/env bash
# Deploy mps-terminal-bash to the current user's home directory. Idempotent.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONF="${HOME}/.config/bashrc"

install -d -m 0700 "${CONF}"
install -m 0600 "${SRC}/.bashrc"                   "${HOME}/.bashrc"
install -m 0600 "${SRC}/.config/bashrc/.bashrc"     "${CONF}/.bashrc"
install -m 0600 "${SRC}/.config/bashrc/.bashrc_colors" "${CONF}/.bashrc_colors"
install -m 0600 "${SRC}/.config/bashrc/.bashrc_distro" "${CONF}/.bashrc_distro"
install -m 0600 "${SRC}/.config/bashrc/.bashrc_prompt" "${CONF}/.bashrc_prompt"
install -m 0600 "${SRC}/.config/bashrc/.bash_logout"   "${CONF}/.bash_logout"

echo "mps-terminal-bash deployed to ${HOME}. Run: exec bash"
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

# Per-user alias overrides: ~/.config/bash_aliases.d is sourced as a whole
# directory (.bashrc_alias_* files) — create it on first install only and
# never touch what the user put there.
ALIASES_D="${HOME}/.config/bash_aliases.d"
if [[ ! -d "${ALIASES_D}" ]]; then
  install -d -m 0700 "${ALIASES_D}"
fi
# Migrate the legacy single-file override into the dir (first install only).
if [[ -f "${CONF}/.bashrc_alias_custom" && ! -f "${ALIASES_D}/.bashrc_alias_custom" ]]; then
  mv "${CONF}/.bashrc_alias_custom" "${ALIASES_D}/.bashrc_alias_custom"
fi

echo "mps-terminal-bash deployed to ${HOME}. Run: exec bash"
#!/usr/bin/env bash
# Deploy mps-terminal-bash to the current user's home directory. Idempotent.
# OS-specific packages live in install-debian.sh / install-fedora.sh and are
# installed best-effort before the config deploy.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONF="${HOME}/.config/bashrc"

#--- Distro detection -----------------------------------------------------------
detect_distro() {
    local id
    id="$(grep -sE '^ID=' /etc/os-release | head -1 | cut -d= -f2 | tr -d '\"')"
    case "${id}" in
        debian|ubuntu) echo "debian" ;;
        fedora|rhel)   echo "fedora" ;;
        *)
            if command -v apt-get >/dev/null 2>&1; then echo "debian"
            elif command -v dnf >/dev/null 2>&1; then echo "fedora"
            else echo "none"; fi ;;
    esac
}

#--- System packages (best-effort: config deploys even without sudo rights) ----
case "$(detect_distro)" in
    debian) "${SRC}/install-debian.sh" || echo "==> WARN: install-debian.sh failed; deploying config only" ;;
    fedora)  "${SRC}/install-fedora.sh" || echo "==> WARN: install-fedora.sh failed; deploying config only" ;;
    *)       echo "==> Unsupported distro — skipping system packages" ;;
esac

#--- Config deploy ---------------------------------------------------------------
install -d -m 0700 "${CONF}"
install -m 0600 "${SRC}/.bashrc"                   "${HOME}/.bashrc"
install -m 0600 "${SRC}/.config/bashrc/.bashrc"     "${CONF}/.bashrc"
install -m 0600 "${SRC}/.config/bashrc/.bashrc_colors" "${CONF}/.bashrc_colors"
install -m 0600 "${SRC}/.config/bashrc/.bashrc_distro" "${CONF}/.bashrc_distro"
install -m 0600 "${SRC}/.config/bashrc/.bashrc_prompt" "${CONF}/.bashrc_prompt"
install -m 0600 "${SRC}/.config/bashrc/.bash_logout"   "${CONF}/.bash_logout"
install -m 0600 "${SRC}/.config/bashrc/.bashrc_aliases_minimal" "${CONF}/.bashrc_aliases_minimal"

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
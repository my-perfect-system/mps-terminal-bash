#!/usr/bin/env bash
# Install mps-terminal-bash system packages on Fedora (dnf). Idempotent.
# Toggles (defaults match the odem.terminal.bash role):
#   MPS_BASH_ENABLE_COMPLETION / MPS_BASH_ENABLE_ZOXIDE / MPS_BASH_ENABLE_FUN
set -euo pipefail

ENABLE_COMPLETION="${MPS_BASH_ENABLE_COMPLETION:-1}"
ENABLE_ZOXIDE="${MPS_BASH_ENABLE_ZOXIDE:-1}"
ENABLE_FUN="${MPS_BASH_ENABLE_FUN:-1}"

SUDO=""
[[ ${EUID} -eq 0 ]] || SUDO="sudo"

pkgs=()
if [[ "${ENABLE_COMPLETION}" = 1 ]]; then pkgs+=(bash-completion); fi
if [[ "${ENABLE_ZOXIDE}" = 1 ]]; then pkgs+=(zoxide); fi
# Fedora has no fortunes-min
if [[ "${ENABLE_FUN}" = 1 ]]; then
    pkgs+=(cowsay figlet fortune-mod cmatrix fastfetch)
fi

if ((${#pkgs[@]} > 0)); then
    ${SUDO} dnf install -y "${pkgs[@]}"
fi
echo "mps-terminal-bash packages installed (fedora)."
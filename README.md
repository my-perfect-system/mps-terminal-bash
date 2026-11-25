# mps-terminal-bash

Bash shell configuration of the [my-perfect-system](https://github.com/my-perfect-system) (mps) terminal stack.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/my-perfect-system/mps-terminal-bash/main/bootstrap.sh | bash
```

Clones the repo to the system-wide mps repo dir
`${MPS_REPO_DIR:-/srv/repo/github/my-perfect-system}` — the same clone the
`odem.terminal.bash` role manages — and runs [`install.sh`](install.sh), which
deploys to the invoking user's home. One clone per host: every user can run
the same command. Re-run it to update. The clone location defaults to
`REPO_DIR_DEFAULT` in [`bootstrap.sh`](bootstrap.sh) (override per invocation
with the `MPS_REPO_DIR` env var).

## Install Ansible

Installed by the `odem.terminal.bash` role of the
[odem-terminal](https://github.com/my-perfect-system/odem-terminal) collection,
which clones this repository and deploys the same files per user.

## Install Standalone

```bash
./install.sh    # deploys to the current user's $HOME; idempotent
```

Then start a new shell (`exec bash`) or `source ~/.bashrc`.

## Examples

```bash
exec bash                        # load the new config: prompt shows exit code,
                                 # git branch, venv, user@host and cwd
echo "alias gs='git status'" \
  > ~/.config/bash_aliases.d/.bashrc_alias_git  # per-user overrides: one
                                                # .bashrc_alias_* file per topic,
                                                # sourced after /etc/bash_aliases.d
erc                                # open the main bash config in $EDITOR
cat ~/.config/bashrc/.bash_history           # history lives in XDG, not $HOME
```
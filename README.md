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

## Layout

```
~/.bashrc                    thin loader; sources ~/.config/bashrc/.bashrc
~/.config/bashrc/
  .bashrc                    main config: prompt, history, aliases, completion, env
  .bashrc_colors             256-color escape helpers
  .bashrc_distro             distribution detection (DISTRO)
  .bashrc_prompt             PS1 prompt builders
  .bash_logout               clear screen on logout
  .gitignore                 keeps .bash_history out of version control
```

`.bashrc` loads system-wide aliases from `/etc/bash_aliases.d/` (deployed by
[mps-terminal-bash-aliases](https://github.com/my-perfect-system/mps-terminal-bash-aliases))
and the optional per-user override `~/.config/bashrc/.bashrc_alias_custom`.

## Standalone install

```bash
./install.sh    # deploys to the current user's $HOME; idempotent
```

Then start a new shell (`exec bash`) or `source ~/.bashrc`.

## Ansible install

Installed by the `odem.terminal.bash` role of the
[odem-terminal](https://github.com/my-perfect-system/odem-terminal) collection,
which clones this repository and deploys the same files per user.
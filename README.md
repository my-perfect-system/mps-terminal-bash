# mps-terminal-bash

Bash shell configuration of the [my-perfect-system](https://github.com/my-perfect-system) (mps) terminal stack.

## Install

| Method | Description |
|---|---|
| Default | `bootstrap.sh` clones to the system-wide mps repo dir and runs `install.sh` |
| Ansible | role `odem.terminal.bash` of [odem-terminal](https://github.com/my-perfect-system/odem-terminal) |
| Standalone | run `./install.sh`; no network needed |

```bash
curl -fsSL https://raw.githubusercontent.com/my-perfect-system/mps-terminal-bash/main/bootstrap.sh | bash
```

All methods deploy to the current user's `$HOME`; one clone per host
(`${MPS_REPO_DIR:-/srv/repo/github/my-perfect-system}`), shared by all users.
Then run `exec bash` or `sb`.

## Usage

```bash
exec bash                        # load the new config: prompt shows exit code,
                                 # git branch, venv, user@host and cwd
info-hist                        # show the persistent history file
                                 # (~/.config/bashrc/.bash_history, XDG)
sb                               # reload the bash config (source ~/.bashrc)

cfg-alias-common                 # sudo vim /etc/bash_aliases.d (system-wide), re-source
cfg-alias-custom                 # edit ~/.config/bash_aliases.d, re-source
cfg-alias-minimal                # edit the cfg-* helpers file, re-source
```

## Creating new aliases

```bash
echo "alias gs='git status'" \
  > ~/.config/bash_aliases.d/.bashrc_alias_git  # per-user override: one
                                                # .bashrc_alias_* file per topic,
                                                # sourced after /etc/bash_aliases.d
```
# mps-terminal-bash

Bash shell configuration of the [my-perfect-system](https://github.com/my-perfect-system) (mps) terminal stack.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/my-perfect-system/mps-terminal-bash/main/bootstrap.sh | bash
```

Clones the repo to `${XDG_DATA_HOME:-$HOME/.local/share}/mps/mps-terminal-bash`
and runs [`install.sh`](install.sh). Re-run the same command to update.

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
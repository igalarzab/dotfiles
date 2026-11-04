# dotfiles

My setup for macOS and Linux. Each tool gets a directory, and
[dotbot](https://github.com/anishathalye/dotbot) links the files into place.

## Install

```sh
git clone https://github.com/igalarzab/dotfiles ~/.config/dotfiles
cd ~/.config/dotfiles
./install
```

This installs packages and runtimes, links the configs and makes zsh the login
shell. It needs Python 3 and sudo. On Linux it only supports APT-based distributions.

After that, `./install links` is usually enough. It only refreshes the symlinks,
works offline and takes about a second. Run the full `./install` when the package
lists change. Add `--dry-run` to preview either one.

dotbot only prints changes and problems, so a quiet run means nothing needed doing.
Pass `-v` to see every link it checked.

If a link's target is already a regular file, or a symlink to somewhere else, the run
stops. Pass `--force` to replace those files, or `--skip` to leave them alone and
carry on.

## Adding a config

Name a file or directory with one of these suffixes and `./install links` picks it up.

| Suffix | Links to |
| --- | --- |
| `*.symlink` | `~/.*` |
| `*.configsymlink` | `~/.config/*` |
| `*.codexsymlink` | `~/.codex/*` |
| `*.claudesymlink` | `~/.claude/*` |

Shell setup also goes by filename, in any top-level directory. zsh and xonsh both
load `env.sh` and `init.sh`. zsh also loads `init.zsh`, and xonsh loads `*.xsh`.

## Adding a package

- `mise/mise.configsymlink/config.toml` has the runtimes and tools that should match
  on every machine.
- `packages/Brewfile` is for macOS and `packages/Aptfile` is for Linux.
- `packages/Brewfile.<hostname>` and `dotbot/hosts/<hostname>.conf.yaml` are for a
  single machine.

## Machine-local settings

These files stay out of git.

- `~/.config/local.sh` is loaded last by zsh and xonsh. Secrets go here.
- `~/.config/git/config-local` holds your identity and signing key. The tracked config
  has placeholders and signs every commit, so git can't commit without this file.
  On a machine with no signing key, turn signing off:

  ```ini
  [user]
      name = Your Name
      email = you@example.com
  [commit]
      gpgsign = false
  [tag]
      gpgsign = false
  [log]
      showSignature = false
  ```

- `~/.ssh/config.d/local.cfg` holds extra SSH hosts.

`~/.ssh`, `~/.kube` and `~/.config/git` are symlinks into this repository, so their
private files live here too, gitignored. Never run `git clean -x` in this repository.
It deletes them and there is no backup.

## Login shell

zsh is the default. The xonsh config stays in the repository, so you can switch:

```sh
./shells/set-default.sh xonsh
./shells/set-default.sh zsh
```

# AGENTS

Personal dotfiles, one directory per tool, deployed with dotbot. See `README.md` for
the suffixes, package lists and machine-local files.

## Commands

- `./install links` refreshes the symlinks. It works offline.
- `./install` also installs packages and runtimes and applies macOS defaults. It uses
  the network and sudo, and changes the machine.
- `--dry-run` previews either one, and `-v` also logs links that were already correct.
- A link whose target is already a file stops the run. `--force` replaces it and
  `--skip` leaves it alone. `./install` passes these to `regexlink` through
  `REGEXLINK_EXISTING`, because dotbot rejects unknown options.
- dotbot prints only changes and problems, so silence means nothing needed doing.

## Rules

- Never run `git clean -x`. `~/.ssh`, `~/.kube` and `~/.config/git` are symlinks into
  this repository, so `known_hosts`, `authorized_keys`, the kubeconfig and `config-local`
  live here, gitignored, with no backup.
- In a git worktree, only use `./install links --dry-run`. A real run repoints the
  symlinks in `$HOME` at the worktree.
- Don't name the machines or services that use these dotfiles. Settings for one machine
  belong in `dotbot/hosts/<hostname>.conf.yaml` or `~/.config/local.sh`.
- `agents/claude/settings.json.claudesymlink` is the live `~/.claude/settings.json`,
  and Claude Code can write to it. Check for those changes before committing it.

## dotbot

Setup lives in `dotbot/`. `dotbot/plugins/regexlink.py` implements the link suffixes,
and everything else uses stock directives.

`shell` has no conditions and silently drops unknown keys, so an `if:` still runs the
command. Put guards inside the command.

Always go through `./install`. It sets two things that dotbot needs:

- `-d <repo root>`. Without it, dotbot starts from the config's own directory, so
  `regexlink` walks `dotbot/` and matches nothing.
- `SHELL=/bin/bash`. dotbot runs commands with `$SHELL`, and the configs are written in
  bash. xonsh can't parse them.

Plugins are Python 3.14. Lint them with
`uvx ruff check --select UP,F,E,W,I,B,SIM dotbot/plugins/`.

# dotfiles

Your dotfiles are how you personalize your system. These are mine. This repository is based in the original dotfiles
promoted by [@holman](http://github.com/holman).


## Install

- `git clone git://github.com/igalarzab/dotfiles ~/.dotfiles`
- `cd ~/.dotfiles`
- `python bootstrap.py`

This will symlink the appropriate files in `.dotfiles` to your home directory. Everything is configured and tweaked
within `~/.dotfiles`.


## Components

Everything's built around topic areas. If you're adding a new area to your forked dotfiles — say, "Java" — you can
simply add a `java` directory and put files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get symlinked without extension into `$HOME`
when you run `bootstrap`.

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.
- **topic/\*.fish**: Any files ending in `.fish` get loaded into your environment.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into your `$HOME`. This is so you can keep all of
  those versioned in your dotfiles but still keep those autoloaded files in your home directory.
- **topic/\*.configsymlink**: Any files ending in `*.configsymlink` get symlinked into your `$HOME/.config`.
- **topic/\*.launchagent**: Any files ending in `*.launchagent` get symlinked into your `$HOME/Library/LaunchAgents` and
  load with `launchctl`.

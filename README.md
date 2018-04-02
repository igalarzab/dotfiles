# dotfiles

This repository and this README is based in the original dotfiles promoted by [@holman](http://github.com/holman).


## dotfiles

Your dotfiles are how you personalize your system. These are mine.

I was a little tired of having long alias files and everything strewn about (which is extremely common on other dotfiles
projects, too). That led to this project being much more topic-centric. I realized I could split a lot of things up into
the main areas I used (Python, git, system libraries, and so on), so I structured the project accordingly.

If you're interested in the philosophy behind why projects like these are awesome, you might want to
[read the post on the subject written by holman](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).


## Install

- `git clone git://github.com/igalarzab/dotfiles ~/.dotfiles`
- `cd ~/.dotfiles`
- `python bootstrap.py`

This will symlink the appropriate files in `.dotfiles` to your home directory.  Everything is configured and tweaked
within `~/.dotfiles`.

Everything's built around topic areas. If you're adding a new area to your forked dotfiles — say, "Java" — you can
simply add a `java` directory and put files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get symlinked without extension into `$HOME`
when you run `bootstrap`.


## Components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your environment.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into your `$HOME`. This is so you can keep all of
  those versioned in your dotfiles but still keep those autoloaded files in your home directory.
- **topic/\*.configsymlink**: Any files ending in `*.configsymlink` get symlinked into your `$HOME/.config`.

## Thanks

- [Zach Holman dotfiles](http://github.com/holman/dotfiles)
- [Ryan Bates dotfiles](http://github.com/ryanb/dotfiles)


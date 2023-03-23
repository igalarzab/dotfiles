# dotfiles

Your dotfiles are how you personalize your system. These are mine. This repository is based in the original dotfiles
promoted by [@holman](http://github.com/holman).


## Install

```sh
$ git clone https://github.com/igalarzab/dotfiles ~/.dotfiles
$ cd ~/.dotfiles
$ python bootstrap.py
$ cd packages
$ ./install.sh
```

This will symlink the appropriate files in `.dotfiles` to your home directory. Everything is configured and tweaked
within `~/.dotfiles`.


## Components

Everything's built around topic areas. If you're adding a new area to your forked dotfiles — say, "Java" — you can
simply add a `java` directory and put files in there. There's a few special files in the hierarchy:

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available
- **topic/\*.xsh**: Any files ending in `.xsh` get loaded into your environment
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into your `$HOME`
- **topic/\*.configsymlink**: Any files ending in `*.configsymlink` get symlinked into your `$HOME/.config`.
- **topic/\*.launchagent**: Any files ending in `*.launchagent` get symlinked into your `$HOME/Library/LaunchAgents` and
  load with `launchctl` (in OSX).


## Config

You should be able to extend your config without having to modify the files of the repo. For example, for configuring
your git information, just create a `~/.gitconfig-local` file with the following content:

```
[user]
    name         = John Doe
    email        = john.doe@example.com
    signingkey   = my-key-id
    helper       = osxkeychain
[github]
    user         = john.doe
```

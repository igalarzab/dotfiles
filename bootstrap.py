#!/usr/bin/env python
#
# Bootstrap script
# ===========================================
#
#  Jose Galarza <igalarzab@gmail.com>
#

import glob
import os
import six
import subprocess


# Path to this file
SELF_PATH = os.path.dirname(os.path.abspath(__file__))


def create_symlinks(source_extension, target_folder, *, hidden=False, extension=None):
    created_symlinks = []
    symlinks = glob.glob('*/' + source_extension)
    always_overwrite = False

    for symlink in symlinks:
        origin = os.path.join(SELF_PATH, symlink)
        filename = os.path.splitext(os.path.basename(symlink))[0]

        if hidden:
            filename = '.' + filename

        destine = os.path.expanduser(os.path.join(target_folder, filename))

        if extension:
            destine = destine + '.' + extension

        if os.path.lexists(destine):

            # Ask the user if overwrite the file
            if not always_overwrite:
                answer = confirm_overwrite(destine)
                always_overwrite = answer == 'a'

            # Remove the file if the user answered yes
            if always_overwrite or answer in ('y', 'a'):
                os.remove(destine)

            # Keep the file if the user answered no
            if answer == 'n':
                continue

        # Create the symlink
        os.symlink(origin, destine)
        created_symlinks.append(destine)

    return created_symlinks


def run_agents(agents):
    for agent in agents:
        subprocess.run(['launchctl', 'load', '-F', agent])


def confirm_overwrite(path):
    'Ask the user to overwrite a file'
    while True:
        answer = six.moves.input('%s exists, overwrite it? (a/y/n) ' % os.path.basename(path))

        if answer in ('y', 'n', 'a'):
            break

    return answer


if __name__ == '__main__':
    os.chdir(SELF_PATH)

    try:
        os.mkdir(os.path.expanduser('~/.config'))
    except FileExistsError:
        pass  # The .config dir already exists

    create_symlinks('*.symlink', '~', hidden=True)
    create_symlinks('*.configsymlink', '~/.config')

    agents = create_symlinks('*.launchagent', '~/Library/LaunchAgents', extension='plist')
    run_agents(agents)

    print('Remember to install fisher')

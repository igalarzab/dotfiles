#
# Python configuration file.
#
# Use:
#   Place the file in ~/.pythonrc.py
#   $ export PYTHONSTARTUP=~/.pythonrc.py
#

import atexit
import collections
import os
import readline
import rlcompleter
import sys
from code import InteractiveConsole
from tempfile import mkstemp


# Configuration variables
HISTORY_FILE = os.path.expanduser('~/.py_history')  # Path to save the history
HISTORY_SIZE = 1000                                 # Number of commands to save
EDITOR = 'vim'                                      # Editor to use
EDITOR_CMD = '\e'                                   # How to invoque the editor


class TerminalColors(collections.Sequence):
    'Helper class to print with colors'

    COLOR_TEMPLATES = {
        'Black':       '0;30',
        'Red':         '0;31',
        'Green':       '0;32',
        'Brown':       '0;33',
        'Blue':        '0;34',
        'Purple':      '0;35',
        'Cyan':        '0;36',
        'LightGray':   '0;37',
        'DarkGray':    '1;30',
        'LightRed':    '1;31',
        'LightGreen':  '1;32',
        'Yellow':      '1;33',
        'LightBlue':   '1;34',
        'LightPurple': '1;35',
        'LightCyan':   '1;36',
        'White':       '1;37',
        'Normal':      '0',
    }

    def __getitem__(self, key):
        'Get the shell code to print with colors'
        return '\033[%sm' % self.COLOR_TEMPLATES[key]

    def __len__(self):
        'Retrieve the number of colors'
        return len(self.COLOR_TEMPLATES)


# Enable colors on terminal
_colors = TerminalColors()

# Read the existing history if there is one
if os.path.exists(HISTORY_FILE):
    readline.read_history_file(HISTORY_FILE)

# Set the history size
readline.set_history_length(HISTORY_SIZE)

# Complete on tab
readline.parse_and_bind("tab: complete")

# Save the new commands on exit
def save():
    'Save the history'
    import readline
    global HISTORY_FILE
    readline.write_history_file(HISTORY_FILE)

atexit.register(save)

# Set the color prompt
sys.ps1 = '%s>>> %s' % (_colors['Green'], _colors['Normal'])
sys.ps2 = '%s... %s' % (_colors['Red'], _colors['Normal'])

# Welcome message
WELCOME_MSG = '%(Brown)sType \e to get an external editor.%(Normal)s' % _colors

# Load the environment if we are working with Django
if 'DJANGO_SETTINGS_MODULE' in os.environ:
    from django.db.models.loading import get_models
    from django.test.client import Client
    from django.test.utils import setup_test_environment
    from django.test.utils import teardown_test_environment
    from django.conf import settings as S

    class DjangoModels(object):
        'Loop through all the models in INSTALLED_APPS and import them'
        def __init__(self):
            for model in get_models():
                setattr(self, model.__name__, model)

    A = DjangoModels()
    C = Client()

    WELCOME_MSG += """%(Green)s
Django environment detected.
    * Your INSTALLED_APPS models are available as `A`.
    * Your project settings are available as `S`.
    * The Django test client is available as `C`.
%(Normal)s""" % _colors

    setup_test_environment()
    S.DEBUG_PROPAGATE_EXCEPTIONS = True

    WELCOME_MSG += """%(LightPurple)s
Warning: the Django test environment has been set up; to restore the
normal environment call `teardown_test_environment()`.

Warning: DEBUG_PROPAGATE_EXCEPTIONS has been set to True.
%(Normal)s""" % _colors


# Tip: http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/438813/
class EditableBufferInteractiveConsole(InteractiveConsole):
    'Allow to start an external editor to write nested python'

    def __init__(self, *args, **kwargs):
        self.last_buffer = []  # This holds the last executed statement
        InteractiveConsole.__init__(self, *args, **kwargs)

    def runsource(self, source, *args):
        self.last_buffer = [source.encode('utf-8')]
        return InteractiveConsole.runsource(self, source, *args)

    def raw_input(self, *args):
        line = InteractiveConsole.raw_input(self, *args)
        if line == EDITOR_CMD:
            fd, tmpfl = mkstemp('.py')
            os.write(fd, b'\n'.join(self.last_buffer))
            os.close(fd)
            os.system('%s %s' % (EDITOR, tmpfl))
            line = open(tmpfl).read()
            os.unlink(tmpfl)
            tmpfl = ''
            lines = line.split('\n')
            for i in range(len(lines) - 1): self.push( lines[i] )
            line = lines[-1]
        return line

c = EditableBufferInteractiveConsole(locals=locals())
c.interact(banner=WELCOME_MSG)

# Exit the Python shell on exiting the InteractiveConsole
sys.exit()

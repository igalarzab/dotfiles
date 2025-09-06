import importlib.util

# Check if the package is there, otherwise install it
if not importlib.util.find_spec("xontrib.fzf-widgets"):
    print("Installing xontrib-fzf-widgets...")
    xpip install xontrib-fzf-widgets

# Load the plugin
xontrib load fzf-widgets

# Set the shortcuts
$fzf_history_binding = "c-r"
$fzf_file_binding = "c-p"

$FZF_DEFAULT_COMMAND = "fd --type f -c always"
$FZF_DEFAULT_OPTS = "--height 60% --layout=reverse --ansi"

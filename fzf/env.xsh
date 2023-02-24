from importlib.metadata import version

# Check if the package is there, otherwise install it
try:
    version("xontrib-fzf-widgets")
except:
    print("Installing xontrib-fzf-widgets...")
    xpip install xontrib-fzf-widgets

# Load the plugin
xontrib load fzf-widgets

# Set the shortcuts
$fzf_history_binding = "c-r"
$fzf_file_binding = "c-p"

$FZF_DEFAULT_COMMAND = "/opt/homebrew/bin/fd --type f -c always"
$FZF_DEFAULT_OPTS = "--height 60% --layout=reverse --ansi"

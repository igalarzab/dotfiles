from importlib.metadata import version

try:
    # Check if the package is installed, otherwise it throws 
    version("xontrib-fzf-widgets")

    # Load the plugin
    xontrib load fzf-widgets

    # Set the shortcuts
    $fzf_history_binding = "c-r"
    $fzf_file_binding = "c-p"

    $FZF_DEFAULT_COMMAND = "/usr/local/bin/fd --type f -c always"
    $FZF_DEFAULT_OPTS = "--height 60% --layout=reverse --ansi"
except:
    pass


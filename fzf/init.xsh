import importlib.util
import shutil

if $XONSH_INTERACTIVE and shutil.which("fzf"):
    # Check if the package is there, otherwise install it
    if not importlib.util.find_spec("xontrib.fzf-widgets"):
        print("Installing xontrib-fzf-widgets...")
        xpip install xontrib-fzf-widgets

    xontrib load fzf-widgets

    $fzf_history_binding = "c-r"
    $fzf_file_binding = "c-p"

from xonsh.built_ins import XSH

env = XSH.env or {}
XONSH_INTERACTIVE = env.get("XONSH_INTERACTIVE", False)
TERM_PROGRAM = env.get("TERM_PROGRAM", "").lower()
HOSTNAME = env.get("HOSTNAME", "localhost")


class Codes:
    ESC = "\x1b"
    BEL = "\x07"
    OSC = ESC + "]"


def on_changedir(olddir: str, newdir: str) -> None:
    """Notify ghostty of directory change"""
    sys.stdout.write(f'{Codes.OSC}7;file://{HOSTNAME}/{newdir}{Codes.BEL}')
    sys.stdout.flush()


if XONSH_INTERACTIVE and TERM_PROGRAM == "ghostty":
    XSH.builtins.events.on_chdir(on_changedir)
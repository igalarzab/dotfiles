import os
import sys
import time


_ENABLED = os.environ.get("XONSH_DEBUG_STARTUP") == "1"
_T0 = time.perf_counter()
_LAST = _T0


def __perf_mark(label: str) -> None:
    """
    Print a timestamped label to stderr if XONSH_DEBUG_STARTUP is set.
    Useful for measuring how long different parts of the startup process take.
    """
    global _LAST

    if not _ENABLED:
        return

    now = time.perf_counter()
    total = now - _T0
    step = now - _LAST
    _LAST = now

    print(
        "[+{:.4f}s | +{:.4f}s] {}".format(total, step, label),
        file=sys.stderr,
        flush=True,
    )


@events.on_post_init
def _post_init(**kwargs):
    __perf_mark("on_post_init")


@events.on_pre_prompt
def _pre_prompt(**kwargs):
    __perf_mark("on_pre_prompt")

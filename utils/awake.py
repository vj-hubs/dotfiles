#!/usr/bin/env python3
"""
keep_awake.py – Periodically move the cursor by 1 px to keep the Mac awake.

Usage
-----
$ python keep_awake.py            # move every 60 s
$ python keep_awake.py -i 300     # move every 5 m
$ python keep_awake.py -i 30 -d   # run as a daemon in the background
"""

import argparse
import contextlib
import signal
import sys
import time

import pyautogui


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="Periodically move the mouse cursor.")
    p.add_argument(
        "-i", "--interval",
        type=float,
        default=60.0,
        help="Seconds between cursor moves (default: 60)."
    )
    p.add_argument(
        "-d", "--daemon",
        action="store_true",
        help="Fork into the background after the first move."
    )
    return p.parse_args()


@contextlib.contextmanager
def daemonize(enabled: bool):
    """
    If *enabled* is True, fork and let the parent exit so the child continues
    in the background (simple 'double-fork' daemon).
    """
    if not enabled:
        yield
        return

    # First fork
    pid = os.fork()
    if pid > 0:
        # Exit parent
        sys.exit(0)

    # Detach from terminal & create new session
    os.setsid()

    # Second fork so the daemon can't acquire a controlling TTY
    pid = os.fork()
    if pid > 0:
        sys.exit(0)

    # Redirect stdio to /dev/null
    with open("/dev/null", "rb", 0) as devnull_in, \
         open("/dev/null", "wb", 0) as devnull_out:
        os.dup2(devnull_in.fileno(), sys.stdin.fileno())
        os.dup2(devnull_out.fileno(), sys.stdout.fileno())
        os.dup2(devnull_out.fileno(), sys.stderr.fileno())

    yield


def wiggle():
    """
    Move the cursor by (1, 0) pixels and then restore it.
    """
    try:
        x, y = pyautogui.position()
        pyautogui.move(1, 0, duration=0)     # nudge
        # pyautogui.move(-1, 0, duration=0)    # restore
    except pyautogui.FailSafeException as e:
        # Mouse was in a corner (PyAutoGUI fail-safe) – ignore and continue.
        # print(e)
        pass


def main() -> None:
    args = parse_args()
    stop = False

    def _handler(signum, frame):
        nonlocal stop
        stop = True

    # Handle ^C and SIGTERM nicely
    signal.signal(signal.SIGINT, _handler)
    signal.signal(signal.SIGTERM, _handler)

    with daemonize(args.daemon):
        while not stop:
            wiggle()
            for _ in range(int(args.interval / 0.2)):
                if stop:
                    break
                time.sleep(0.2)


if __name__ == "__main__":
    # Lazy-import os for daemonize only when necessary
    import os  # noqa: WPS433 (import at top constrained by daemonize design)
    main()

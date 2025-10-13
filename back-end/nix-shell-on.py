#!/usr/bin/env python3
import os, shlex, subprocess
from pathlib import Path

orig = Path.cwd().resolve()               # where you are now
librelane_root = Path.home() / "librelane"

# Start nix-shell in ~/librelane, then cd back here and open your shell
cmd = f"cd {shlex.quote(str(orig))} && exec $SHELL -i"
subprocess.run(["nix-shell", "--run", cmd], cwd=librelane_root, check=True)

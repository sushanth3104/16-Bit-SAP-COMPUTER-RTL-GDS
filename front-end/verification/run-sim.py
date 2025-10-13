#!/usr/bin/env python3
import subprocess, sys
from pathlib import Path

subprocess.run(["iverilog","-o","sim_out.vvp", "tb.v", "includes.v"], check=True)
subprocess.run(["vvp", "sim_out.vvp"], check=True)

vcd = Path("sim_output.vcd")
if not vcd.exists() or vcd.stat().st_size == 0:
    sys.exit("im_output.vcd not produced or empty")

subprocess.run(["surfer", str(vcd)], check=True)
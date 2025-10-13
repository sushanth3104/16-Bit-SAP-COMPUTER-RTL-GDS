iverilog -o sim_out.vvp tb.v include.v|| exit 1
vvp sim_out.vvp || exit 1
[ -s sim_output.vcd ] || exit 1
surfer sim_output.vcd || exit 1

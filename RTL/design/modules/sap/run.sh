clear
iverilog -o sim_out.vvp tb.v sap.v
vvp sim_out.vvp
surfer sim_output.vcd
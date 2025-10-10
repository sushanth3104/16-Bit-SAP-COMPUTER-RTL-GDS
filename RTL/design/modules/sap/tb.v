`timescale 1ns/1ps
module tb;

reg clk,rst;
wire [15:0]debug;

integer i ;

always #1 clk = ~clk ;

sap dut(
    .rst(rst),
    .clk(clk),
    .debug(debug)
);

initial begin

    $dumpfile("sim_output.vcd");
    $dumpvars(0,tb);
    #200;
    $finish;

end

initial begin // Writing Instr and Data to RAM for simulation

    for(i =0 ; i <256; i ++)
        dut.ram1.mem[i] = 0;

    /// Instr
    dut.ram1.mem[0] = 16'd3;
    dut.ram1.mem[10] = 16'h0B00;
    dut.ram1.mem[11] = 16'h0200;
    dut.ram1.mem[12] = 16'h080A;

end

initial begin
    clk = 0;
    rst = 1;
    #11;
    rst = 0;

end



endmodule
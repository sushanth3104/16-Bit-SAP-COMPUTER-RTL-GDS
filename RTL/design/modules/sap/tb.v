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
    #1000;
    $finish;

end

initial begin // Writing Instr and Data to RAM for simulation

    for(i =0 ; i <256; i ++)
        dut.ram1.mem[i] = 0;

    /// Data Section
    dut.ram1.mem[0] = 16'h0000;
    dut.ram1.mem[1] = 16'h0001;

    // Instr Section
    dut.ram1.mem[10] = 16'h0000;
    dut.ram1.mem[11] = 16'h0B00;
    dut.ram1.mem[12] = 16'h0201;
    dut.ram1.mem[13] = 16'h0102;
    dut.ram1.mem[14] = 16'h0001;
    dut.ram1.mem[15] = 16'h0100;
    dut.ram1.mem[16] = 16'h0002;
    dut.ram1.mem[17] = 16'h0101;
    dut.ram1.mem[18] = 16'h080A;

end

initial begin
    clk = 0;
    rst = 1;
    #11;
    rst = 0;

end



endmodule
`timescale 1ns/1ps

module tb;

    reg clk;
    reg rst;
    reg b_write;
    reg [15:0]bus;
    wire [15:0]bout;


    b_register dut(
        .clk(clk),
        .rst(rst),
        .b_write(b_write),
        .bus(bus),
        .bout(bout)
    );

always #5 clk = ~clk ; 

initial begin

{clk,rst,b_write,bus} = 0;
$dumpfile("output.vcd");
$dumpvars(0,tb);

#100 $finish ; 

end

initial begin

    #12;
    rst = 1;

    #7;
    rst = 0;

    #1;
    bus = 16'd400;
    
    #3;
    b_write = 1;

    #10;
    b_write = 0;

    #22;
    rst = 1;

    #4;
    rst = 0;

end


endmodule
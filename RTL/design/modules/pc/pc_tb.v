`timescale 1ns/1ps

module tb;

    reg clk;
    reg rst;
    reg pc_write;
    reg pc_inc;
    reg [15:0]bus;
    wire [15:0]pc_out;


    pc dut(
        .clk(clk),
        .rst(rst),
        .pc_inc(pc_inc),
        .pc_write(pc_write),
        .bus(bus),
        .pc_out(pc_out)
    );

always #5 clk = ~clk ; 

initial
begin
    {clk,rst,pc_write,bus,pc_inc} = 0 ;
    $dumpfile("output.vcd");
    $dumpvars(0,tb);
    #200 $finish ;

end


initial begin

    #2;
    rst <= 1;

    #5;
    rst <= 0 ;

    #2;
    bus <= 4'b0101;

    #3;
    pc_write <= 1;

    #5;
    pc_write <= 0;

    #2;
    pc_inc <= 1 ;

    #20;
    pc_inc <= 0 ;

end


endmodule 




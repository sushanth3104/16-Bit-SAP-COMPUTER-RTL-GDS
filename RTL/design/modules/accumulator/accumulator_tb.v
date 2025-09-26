`timescale 1ns/1ps

module tb;

reg [15:0]bus;
reg clk,rst,acc_write,acc_lower_write;
wire [15:0] aout ;

accumulator dut(
    .clk(clk),
    .rst(rst),
    .acc_write(acc_write),
    .acc_lower_write(acc_lower_write),
    .bus(bus),
    .aout(aout)
);

always #5 clk = ~clk ; 

initial begin

{clk,rst,acc_write,acc_lower_write,bus} = 0;
$dumpfile("output.vcd");
$dumpvars(0,tb);

#100 $finish ; 

end

initial begin

    #12 ;
    rst = 1;

    #5;
    rst = 0;

    #2;
    bus = 16'd300;

    #3;
    acc_write = 1;

    #10;
    acc_write = 0;


    #5;
    rst = 1;

    #3;
    rst = 0;

    #3;
    bus = 16'b1101_1110_1101_1110;

    #2;
    acc_lower_write = 1;

    #13;
    acc_lower_write = 0;


end



endmodule
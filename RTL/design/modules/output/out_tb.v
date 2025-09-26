`timescale 1ns/1ps

module tb;

reg clk,rst,out_write;
reg [15:0]bus;
wire [15:0]_out_;

out dut(
    .clk(clk),
    .rst(rst),
    .out_write(out_write),
    .bus(bus),
    ._out_(_out_)
);

always #5 clk = ~clk ; 

initial begin
    {clk,rst,out_write,bus} = 0 ;
    $dumpfile("output.vcd");
    $dumpvars(0,tb);
    #100 $finish ; 
end

initial begin

#12;
rst  = 1;

#8 ;
rst = 0;

#1;
bus = 16'd74;

#2;
out_write = 1;

#5;
out_write = 0;


end

endmodule
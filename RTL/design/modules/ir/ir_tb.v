`timescale 1ns/1ps

module tb;

reg [15:0]bus; 
reg clk,rst,ir_write;
wire [15:0]ir_out;

ir dut(
    .clk(clk),
    .rst(rst),
    .ir_write(ir_write),
    .bus(bus),
    .ir_out(ir_out)
);

always #5 clk = ~clk ; 

initial begin
    {clk,rst,ir_write,bus} = 0 ;
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
ir_write = 1;

#5;
ir_write = 0;


end
 
endmodule
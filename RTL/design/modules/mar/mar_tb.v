`timescale 1ns/1ps

module tb;

reg [15:0]bus; 
reg clk,rst,mar_write;
wire [7:0]mar_out;

mar dut(
    .clk(clk),
    .rst(rst),
    .mar_write(mar_write),
    .bus(bus),
    .mar_out(mar_out)
);

always #5 clk = ~clk ; 

initial begin
    {clk,rst,mar_write,bus} = 0 ;
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
mar_write = 1;

#5;
mar_write = 0;


end
 
endmodule
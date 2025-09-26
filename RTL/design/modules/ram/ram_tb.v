`timescale 1ns/1ps


module tb;

reg [15:0]bus ;
reg [15:0]addr ;
reg ram_write;
wire [15:0]ram_out ;
integer i;


ram dut(
    .bus(bus),
    .addr(addr),
    .ram_write(ram_write),
    .ram_out(ram_out)
);


initial begin
    {bus,addr,ram_write} = 0 ;
    $dumpfile("output.vcd");
    $dumpvars(0,tb);
    #400 $finish ; 

end

initial begin

// Read Every Memory Word

for(i = 0; i < 16; i ++) begin

    #3;
    addr = i ;
    #12;


end

// Write into Memory 

addr = 2;
bus = 9;

#3;
ram_write = 1;
#12;
ram_write = 0;

#6;


end



endmodule
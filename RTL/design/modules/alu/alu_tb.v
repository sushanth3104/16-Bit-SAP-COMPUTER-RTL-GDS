`timescale 1ns/1ps

module tb;

reg signed [15:0]a,b;
reg [3:0]op;
wire [16:0]res;
wire [1:0]flag;

alu dut(
    .a(a),
    .b(b),
    .op(op),
    .res(res),
    .flag(flag)
);


integer i;

initial begin
    for(i = 0 ; i <= 10 ; i ++) begin

        a = $random%10;
        b = $random%10;
        op = $urandom%8;
        #5;

    end

end

initial begin
    {a,b,op} = 0;
    $dumpfile("output.vcd");
    $dumpvars(0,tb);
    #100 $finish ; 

end


endmodule
module ir(
    input clk,
    input rst,
    input ir_write,
    input [15:0]bus,
    output reg [15:0]ir_out
);

reg [15:0]ir_out_nxt;

////////////// flops
always @(posedge clk) begin
        if(rst)
            ir_out <= 0;
        else
            ir_out <= ir_out_nxt ;
end

///////////// comb
always @(*) begin
    if(ir_write)
        ir_out_nxt = bus;
    else
        ir_out_nxt = ir_out ;
end


endmodule
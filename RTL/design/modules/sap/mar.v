module mar(
    input clk,
    input rst,
    input mar_write,
    input [15:0]bus,
    output reg [15:0]mar_out
);

reg [15:0]mar_out_nxt;


////////////// flops
always @(posedge clk) begin
        if(rst)
            mar_out <= 0;
        else
            mar_out <= mar_out_nxt ;
end

///////////// comb
always @(*) begin
    if(mar_write)
        mar_out_nxt = bus;
    else
        mar_out_nxt = mar_out ;
end


endmodule
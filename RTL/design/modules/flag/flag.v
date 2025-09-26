module flag(
    input clk,
    input rst,
    input flag_write,
    input [1:0]flag_in,
    output reg [1:0]flag_out;
);

reg [1:0]flag_out_nxt;

////////////// flops
always @(posedge clk) begin
        if(rst)
            flag_out <= 0;
        else
            flag_out <= flag_out_nxt ;
end

///////////// comb
always @(*) begin
    if(flag_write)
        flag_out_nxt = flag_in ;
    else
        flag_out_nxt = flag_out ;
end


endmodule
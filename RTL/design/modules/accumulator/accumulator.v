module accumulator(
    input clk,
    input rst,
    input acc_write,
    input acc_lower_write,
    input [15:0]bus,
    output reg [15:0]aout
);

reg [15:0]aout_nxt;


////////////// flops
always @(posedge clk ) begin
        if(rst)
            aout <= 0;
        else
            aout <= aout_nxt ;
end

///////////// comb
always @(*) begin
    if(acc_write)
        aout_nxt = bus;
    else if(acc_lower_write)
        aout_nxt = {8'b0,bus[7:0]};
    else
        aout_nxt = aout ;
end


endmodule
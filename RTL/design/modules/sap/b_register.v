module b_register(
    input clk,
    input rst,
    input b_write,
    input [15:0]bus,
    output reg [15:0]bout
);

reg [15:0]bout_nxt;


////////////// flops
always @(posedge clk ) begin
        if(rst)
            bout <= 0;
        else
            bout <= bout_nxt ;
end

///////////// comb
always @(*) begin
    if(b_write)
        bout_nxt = bus;
    else
        bout_nxt = bout ;
end


endmodule
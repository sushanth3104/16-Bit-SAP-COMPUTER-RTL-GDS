module pc(
    input clk,
    input rst,
    input pc_inc,
    input pc_write,
    input [15:0]bus,
    output reg [15:0]pc_out
);

reg [15:0]pc_out_nxt;


////////////// flops
always @(posedge clk or posedge rst ) begin
        if(rst)
            pc_out <= 16'd10;
        else
            pc_out <= pc_out_nxt; 
end

///////////// comb
always @(*) begin
    if(pc_write)
        pc_out_nxt = {8'b0,bus[7:0]};
    else if(pc_inc)
        pc_out_nxt = pc_out + 1 ;
    else
        pc_out_nxt = pc_out;
end


endmodule
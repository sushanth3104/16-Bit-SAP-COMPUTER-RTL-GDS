module out(
    input clk,
    input rst,
    input [15:0]bus,
    input out_write,
    output reg[15:0]_out_
);

    reg [15:0] _out_nxt;

////////////// flops
always @(posedge clk or posedge rst ) begin
        if(rst)
            _out_ <= 0;
        else
            _out_ <= _out_nxt ;
end

///////////// comb
always @(*) begin
    if(out_write)
        _out_nxt = bus;
    else
        _out_nxt = _out_ ;
end



endmodule
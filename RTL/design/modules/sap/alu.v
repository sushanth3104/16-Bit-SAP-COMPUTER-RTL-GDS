`define ADD_OP 4'd0
`define SUB_OP 4'd1
`define INC_OP 4'd2
`define DEC_OP 4'd3
`define AND_OP 4'd4
`define OR_OP 4'd5
`define XOR_OP 4'd6
`define NOT_OP 4'd7

module alu(
    input signed [15:0]a,
    input signed [15:0]b,
    input [3:0]op,
    output reg signed[15:0]alu_out,
    output reg [1:0]flag
);

    reg [16:0]res;
    always@(*) begin
        case(op)
        `ADD_OP: res = a + b ;
        `SUB_OP: res = a - b ;
        `INC_OP: res = a + $signed(1);
        `DEC_OP: res = a - $signed(1);
        `AND_OP: res = {1'b0, a & b};
        `OR_OP:  res = {1'b0, a | b};
        `XOR_OP: res = {1'b0, a ^ b};
        `NOT_OP: res = {1'b0, ~a};
        default: res = 17'd0;
        endcase

    end


    always @(*) begin
        flag[0] = ~|res[15:0]; // Zero Flag
        flag[1] = res[16]    ; // Overflow flag
        alu_out = res[15:0];
    end
    
endmodule
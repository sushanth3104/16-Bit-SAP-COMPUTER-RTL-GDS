`define ADD 4'd0
`define SUB 4'd1
`define INC 4'd2
`define DEC 4'd3
`define AND 4'd4
`define OR 4'd5
`define XOR 4'd6
`define NOT 4'd7

module alu(
    input signed [15:0]a,
    input signed [15:0]b,
    input [3:0]op,
    output reg signed[16:0]res
);

    always@(*) begin
        case(op)
        `ADD: res = a + b ;
        `SUB: res = a - b ;
        `INC: res = a + $signed(1);
        `DEC: res = a - $signed(1);
        `AND: res = {1'b0, a & b};
        `OR:  res = {1'b0, a | b};
        `XOR: res = {1'b0, a ^ b};
        `NOT: res = {1'b0, ~a};
        default: res = 17'd0;
        endcase

    end
    
endmodule
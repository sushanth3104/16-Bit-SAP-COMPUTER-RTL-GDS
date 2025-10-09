`include "accumulator.v"
`include "alu.v"
`include "b_register.v"
`include "cu.v"
`include "flag.v"
`include "ir.v"
`include "mar.v"
`include "out.v"
`include "pc.v"
`include "ram.v"




module sap(
    input clk,rst,
    output [15:0]debug
);

reg [15:0]bus;


// Accumulator
wire acc_write,acc_lower_write;
wire [15:0]aout;

// ALU
wire [15:0]bout;
wire [3:0]alu_op;
wire [15:0]alu_out;
wire [1:0]flag;

// B-Register
wire b_write;

// Control Unit
wire [7:0]opcode;
wire [13:0]cs;
wire [4:0]bus_cs;

// Flags
wire flag_write;
wire [1:0]flag_out;

// IR
wire ir_write;
wire [15:0]ir_out;

// MAR
wire mar_write;
wire [15:0]mar_out;

//out
wire out_write;
wire [15:0]_out_;

// PC
wire pc_inc;
wire pc_write;
wire [15:0]pc_out;

// RAM
wire ram_write;
wire [15:0]ram_out;

// Bus Control signals

wire acc_to_bus;
wire alu_to_bus;
wire ir_to_bus;
wire pc_to_bus;
wire ram_to_bus;


///// Opcode

assign opcode = ir_out[15:8];


////// Debug Bus
assign debug = bus;

//////// Instrantiation


accumulator accumulator1(
    .clk(clk),
    .rst(rst),
    .acc_write(acc_write),
    .acc_lower_write(acc_lower_write),
    .bus(bus),
    .aout(aout)
);

alu alu1(
    .a(aout),
    .b(bout),
    .op(alu_op),
    .alu_out(alu_out),
    .flag(flag)

);

b_register b_register1(
    .clk(clk),
    .rst(rst),
    .b_write(b_write),
    .bus(bus),
    .bout(bout)
);

cu cu1(
    .clk(clk),
    .rst(rst),
    .flag(flag_out),
    .opcode(opcode),
    .cs(cs),
    .bus_cs(bus_cs)
);

flag flag1(
    .clk(clk),
    .rst(rst),
    .flag_write(flag_write),
    .flag_in(flag),
    .flag_out(flag_out)
);

ir ir1(
    .clk(clk),
    .rst(rst),
    .ir_write(ir_write),
    .bus(bus),
    .ir_out(ir_out)
);

mar mar1(
    .clk(clk),
    .rst(rst),
    .mar_write(mar_write),
    .bus(bus),
    .mar_out(mar_out)
);

out out1(
    .clk(clk),
    .rst(rst),
    .bus(bus),
    .out_write(out_write),
    ._out_(_out_)
);

pc pc1(
    .clk(clk),
    .rst(rst),
    .pc_inc(pc_inc),
    .pc_write(pc_write),
    .bus(bus),
    .pc_out(pc_out)
);

ram ram1(
    .clk(clk),
    .ram_write(ram_write),
    .bus(bus),
    .addr(mar_out),
    .ram_out(ram_out)
);


///////////////// Control Signals

assign {acc_write,acc_lower_write,alu_op,b_write,flag_write, ir_write,mar_write,out_write,pc_inc,pc_write,ram_write} = cs;
assign {acc_to_bus,alu_to_bus,ir_to_bus,pc_to_bus,ram_to_bus} = bus_cs;


////////////// Bus Arbitration Logic
always @(*) begin

    bus = 16'd0;

    case(1'b1)

        acc_to_bus : bus = aout ;
        alu_to_bus : bus = alu_out;
        ir_to_bus  : bus = {8'd0,ir_out[7:0]};
        pc_to_bus : bus = pc_out;
        ram_to_bus : bus = ram_out;


    endcase
    
end




endmodule

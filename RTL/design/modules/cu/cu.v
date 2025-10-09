`define LDA 8'd0
`define STA 8'd1
`define ADD 8'd2
`define SUB 8'd3
`define INCA 8'd4
`define DECR 8'd5
`define JMPZ 8'd6
`define JMPC 8'd7
`define JMP  8'd8
`define NOP 8'd9
`define LDI 8'd10
`define OUT 8'd11
`define HLT 8'd12
`define AND 8'd13
`define OR  8'd14
`define XOR 8'd15
`define NOT 8'd16


`define ADD_OP 4'd0
`define SUB_OP 4'd1
`define INC_OP 4'd2
`define DEC_OP 4'd3
`define AND_OP 4'd4
`define OR_OP 4'd5
`define XOR_OP 4'd6
`define NOT_OP 4'd7


module cu(
    input clk,
    input rst,
    input [1:0]flag,   // flag[0] = Zero Flag , flag[1] = Carry Flag
    input [7:0]opcode,
    output [13:0]cs,
    output [4:0]bus_cs
);

localparam [3:0] 
    idle = 0,

    fetch1 = 1,
    fetch2 = 2,

    lda1 = 3,
    lda2 = 4,

    sta1 = 5,
    sta2 = 6,

    alu1 = 7,
    alu2 = 8,
    alu3 = 9,

    jmp1 = 10,

    ldi1 = 11,
    
    out1 = 12,

    hlt = 13;


reg [3:0]state,state_nxt;


////////////////////////////////
// Control Signals 
reg acc_write;
reg acc_lower_write;
reg [3:0]alu_op;
reg b_write;
reg flag_write;
reg ir_write;
reg mar_write;
reg out_write;
reg pc_inc;
reg pc_write;
reg ram_write;

assign cs = {
                acc_write,
                acc_lower_write,
                alu_op,
                b_write,
                flag_write, 
                ir_write,
                mar_write,
                out_write,
                pc_inc,
                pc_write,
                ram_write
                
                };

////////////////////////////////////
// Bus Control signals

reg acc_to_bus;
reg alu_to_bus;
reg ir_to_bus;
reg pc_to_bus;
reg ram_to_bus;

assign bus_cs = {

                acc_to_bus,
                alu_to_bus,
                ir_to_bus,
                pc_to_bus,
                ram_to_bus

                };

//////////// flops
always @(posedge clk ) begin

    if(rst) state <= idle;
    else    state <= state_nxt;
    
end

/////////// Nxt State logic
always @(*) begin

    state_nxt = idle ;

    case(state)

        //////// Idle
        idle : state_nxt = fetch1 ;

        //////// fetch & decode
        fetch1 : state_nxt = fetch2 ;

        fetch2 : begin
            state_nxt = fetch1;
            case(opcode)
                `LDA : state_nxt = lda1 ;
                `STA : state_nxt = sta1 ;
                `ADD,`SUB,`INCA,`DECR,`AND,`OR,`XOR,`NOT : state_nxt = alu1 ;
                `JMP: state_nxt = jmp1;
                `JMPZ: state_nxt = flag[0]? jmp1 : fetch1;
                `JMPC  : state_nxt = flag[1]? jmp1 : fetch1;
                `NOP :  state_nxt = fetch1 ;
                `LDI :  state_nxt = ldi1 ;
                `OUT :  state_nxt = out1 ;
                `HLT :  state_nxt = hlt ;
                
            endcase


        end

        /////////////////// Load

        lda1 : state_nxt = lda2 ;
        lda2 : state_nxt = fetch1 ;

        ///////////////// Store
        sta1 : state_nxt = sta2 ;
        sta2 : state_nxt = fetch1 ;

        ///////////////// ALU
        alu1 : begin
               state_nxt = fetch1;
                case(opcode)
                    `ADD,`SUB,`AND,`OR,`XOR: state_nxt = alu2;
                    `INCA,`DECR,`NOT : state_nxt = fetch1;
                endcase
                end
        alu2 : begin
            state_nxt = alu3;
        end
        
        alu3 : state_nxt = fetch1 ;


        ////////////////// Jump if Zero
        jmp1 : begin
            state_nxt = fetch1;
        end

        ///////////////////// Load Immediate
        ldi1 : state_nxt = fetch1 ;

        ///////////////////// Output Register
        out1 : state_nxt = fetch1 ;

        ///////////////////////  Halt
        hlt : state_nxt = hlt ;

    endcase
    
end




always @(*) begin

    // Control Signals
    acc_write = 0;
    acc_lower_write = 0;
    alu_op = 0;
    b_write = 0;
    flag_write = 0;
    ir_write = 0;
    mar_write = 0;
    out_write = 0;
    pc_inc = 0;
    pc_write = 0;
    ram_write = 0;

    // Bus Control Signals
    acc_to_bus = 0;
    alu_to_bus = 0;
    ir_to_bus = 0;
    pc_to_bus = 0;
    ram_to_bus = 0;

    

    case(state)
        fetch1 : begin
            mar_write = 1'b1;
            pc_to_bus = 1'b1;
        end

        fetch2 : begin
            ir_write = 1'b1;
            pc_inc = 1'b1;
            ram_to_bus = 1'b1;
        end

        lda1 : begin
            mar_write = 1'b1;
            ir_to_bus = 1'b1;
        end

        lda2 : begin
            acc_write = 1'b1;
            ram_to_bus = 1'b1;
        end

        sta1 : begin
            mar_write = 1'b1;
            ir_to_bus = 1'b1;
        end

        sta2 : begin
            ram_write = 1'b1;
            acc_to_bus = 1'b1;
        end

        alu1: begin
            case(opcode) 

            `INCA: begin
                alu_op = `INC_OP;
                flag_write = 1'b1;
                acc_write = 1'b1;
                alu_to_bus = 1'b1;
            end
            `DECR : begin
                alu_op = `DEC_OP;
                flag_write = 1'b1;
                acc_write = 1'b1;
                alu_to_bus = 1'b1;
            end
            `NOT : begin
                alu_op = `NOT_OP;
                flag_write = 1'b1;
                acc_write = 1'b1;
                alu_to_bus = 1'b1;
            end

            `ADD,`SUB,`AND,`OR,`XOR : begin
                mar_write = 1'b1;
                ir_to_bus = 1'b1;  
            end
                
            endcase
        end

        alu2 : begin
            case(opcode)

            `ADD,`SUB,`AND,`OR,`XOR : begin

                ram_to_bus = 1'b1;
                b_write = 1'b1;
                
            end
            
            endcase
        end

        alu3 : begin
            acc_write = 1'b1;
            alu_to_bus = 1'b1;
            flag_write = 1'b1;
            case(opcode)
                `ADD : alu_op = `ADD_OP;
                `SUB : alu_op = `SUB_OP;
                `AND : alu_op = `AND_OP;
                `OR  : alu_op = `OR_OP ;
                `XOR : alu_op = `XOR_OP;

            endcase

        end

        jmp1 : begin

            pc_write = 1'b1;
            ir_to_bus = 1'b1;

        end

        ldi1 : begin

            acc_lower_write = 1'b1;
            ir_to_bus = 1'b1;

        end

        out1 : begin

            out_write = 1'b1;
            acc_to_bus = 1'b1;

        end


    endcase

    
end


endmodule
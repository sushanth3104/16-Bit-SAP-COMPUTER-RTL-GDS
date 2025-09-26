
module ram(
    input [15:0]bus,
    input [15:0]addr,
    input ram_write,
    output reg [15:0]ram_out
);

reg [15:0]mem[255:0];

initial begin
    $readmemh("./instr.txt",mem);
end


always @(*) begin
        if(ram_write)
            mem[addr[7:0]] = bus;

        ram_out = mem[addr[7:0]];
end



endmodule
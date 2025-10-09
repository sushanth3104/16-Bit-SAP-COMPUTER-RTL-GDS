
module ram(
    input clk,
    input ram_write,
    input [15:0]bus,
    input [15:0]addr,
    output  [15:0]ram_out
);

reg [15:0]mem[255:0];

initial begin
    $readmemh("./instr.txt",mem);
end


always @(posedge clk) begin
        if(ram_write) // Synchronous Write
            mem[addr] <= bus;

        
end

assign ram_out = mem[addr]; // Combinational Read


endmodule
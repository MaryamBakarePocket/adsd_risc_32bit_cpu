module adsd_32_RAM(
    input clk,
    input CS,
    input RW_,
    input [31:0] addr,
    input [31:0] data_in,
    output reg [31:0] data_out
);
reg [7:0] ram[0:255];
wire [7:0] ram_addr = addr[7:0];
always @(posedge clk) begin
    if(CS && !RW_) begin
        ram[ram_addr] <= data_in[31:24];
        ram[ram_addr+1] <= data_in[23:16];
        ram[ram_addr+2] <= data_in[15:8];
        ram[ram_addr+3] <= data_in[7:0];
    end
end
always @(*) begin
    if(CS && RW_) data_out = {ram[ram_addr],ram[ram_addr+1],ram[ram_addr+2],ram[ram_addr+3]};
    else data_out = 32'd0;
end
endmodule
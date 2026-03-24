module adsd_32_REGISTER(
    input clk,
    input rst,
    input write_en,
    input [4:0] rd,
    input [31:0] data_in,
    input [4:0] rs,
    output [31:0] rs_data_out,
    input [4:0] rt,
    output [31:0] rt_data_out,
    output [7:0] r15
);
reg [31:0] reg_array[31:0];
integer i;
always @(posedge clk) begin
    if(!rst) for(i=0;i<32;i=i+1) reg_array[i] <= 32'd0;
    else if(write_en && rd!=0) reg_array[rd] <= data_in;
end
assign rs_data_out = reg_array[rs];
assign rt_data_out = reg_array[rt];
assign r15 = reg_array[31][7:0];
endmodule
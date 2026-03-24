module adsd_32_PIPO(
    output reg [31:0] dout,
    input [31:0] din,
    input ld,
    input clk,
    input rst
);
always @(posedge clk) begin
    if(!rst) dout <= 32'd0;
    else if(ld) dout <= din;
end
endmodule

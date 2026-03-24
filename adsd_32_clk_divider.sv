module adsd_32_clk_divider(
    input clk,
    output clk_slow
);
reg [24:0] cnt;
always @(posedge clk) cnt <= cnt + 1;
assign clk_slow = cnt[20]; // ~1Hz if clk = 50MHz
endmodule
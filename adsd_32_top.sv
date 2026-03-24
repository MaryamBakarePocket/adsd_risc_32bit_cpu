module adsd_32_top(
    input rst,
    input clk,
    output [7:0] LEDport
);

wire [7:0] opcode;
wire pc_ld;
wire ctrl_branch;
wire ctrl_jump;
wire ctrl_i_mem_oe;
wire ctrl_rf_rd_sel;
wire ctrl_rf_write_en;
wire ctrl_alu_in2_sel;
wire ctrl_d_mem_rw_;
wire ctrl_d_mem_cs;
wire ctrl_wdata_sel;
wire [7:0] ctrl_aluop;

wire zero, neg, ovf;
wire clk_slow;

// Slow clock
adsd_32_clk_divider clkdiv(
    .clk(clk),
    .clk_slow(clk_slow)
);

// Datapath
adsd_32_dp dp (
    .clk(clk_slow),
    .rst(rst),
    .pc_ld(pc_ld),
    .ctrl_branch(ctrl_branch),
    .ctrl_jump(ctrl_jump),
    .ctrl_i_mem_oe(ctrl_i_mem_oe),
    .ctrl_rf_rd_sel(ctrl_rf_rd_sel),
    .ctrl_rf_write_en(ctrl_rf_write_en),
    .ctrl_alu_in2_sel(ctrl_alu_in2_sel),
    .ctrl_d_mem_rw_(ctrl_d_mem_rw_),
    .ctrl_d_mem_cs(ctrl_d_mem_cs),
    .ctrl_wdata_sel(ctrl_wdata_sel),
    .ctrl_aluop(ctrl_aluop),
    .opcode(opcode),
    .ctrl_zero(zero),
    .ctrl_neg(neg),
    .ctrl_ovf(ovf),
    .LEDport(LEDport)
);

// Controller
adsd_32_ctrl ctrl(
    .rst(rst),
    .clk(clk_slow),
    .opcode(opcode),
    .pc_ld(pc_ld),
    .ctrl_branch(ctrl_branch),
    .ctrl_jump(ctrl_jump),
    .ctrl_i_mem_oe(ctrl_i_mem_oe),
    .ctrl_rf_rd_sel(ctrl_rf_rd_sel),
    .ctrl_rf_write_en(ctrl_rf_write_en),
    .ctrl_alu_in2_sel(ctrl_alu_in2_sel),
    .ctrl_d_mem_rw_(ctrl_d_mem_rw_),
    .ctrl_d_mem_cs(ctrl_d_mem_cs),
    .ctrl_wdata_sel(ctrl_wdata_sel),
    .ctrl_aluop(ctrl_aluop),
    .zero(zero),
    .neg(neg),
    .ovf(ovf)
);

endmodule
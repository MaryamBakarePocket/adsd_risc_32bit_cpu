module adsd_32_dp (
    input clk,
    input rst,
    input pc_ld,
    input ctrl_branch,
    input ctrl_jump,
    input ctrl_i_mem_oe,
    input ctrl_rf_rd_sel,
    input ctrl_rf_write_en,
    input ctrl_alu_in2_sel,
    input ctrl_d_mem_rw_,
    input ctrl_d_mem_cs,
    input ctrl_wdata_sel,
    input [7:0] ctrl_aluop,

    output [7:0] opcode,
    output ctrl_zero,
    output ctrl_neg,
    output ctrl_ovf,
    output [7:0] LEDport
);

    // ======== Wires ========
    wire [31:0] pc, pc_next, pc_plus1;
    wire [31:0] ir;
    wire [31:0] rf_data_in, rf_rs_data_out, rf_rt_data_out;
    wire [31:0] alu_in2, alu_out;
    wire [31:0] d_mem_data_out;

    wire [4:0] ir_rs, ir_rt, rf_rd;
    wire [15:0] imm16;
    wire [23:0] imm24;
    wire [31:0] imm16_to32, imm24_to32;
    wire [31:0] pc_plus1_plus_imm16;
    wire [31:0] mux_branch_out;

    // ======== Instruction Decode ========
    assign opcode = ir[31:24];
    assign ir_rs = ir[23:19];
    assign ir_rt = ir[18:14];
    assign imm16 = ir[15:0];
    assign imm24 = ir[23:0];

    assign imm16_to32 = {{16{imm16[15]}}, imm16};
    assign imm24_to32 = {{8{imm24[23]}}, imm24};

    assign pc_plus1 = pc + 32'd4;
    assign pc_plus1_plus_imm16 = pc_plus1 + imm16_to32;

    // ======== Program Counter ========
    adsd_32_PIPO PC(
        .dout(pc),
        .din(pc_next),
        .ld(pc_ld),
        .clk(clk),
        .rst(rst)
    );

    // ======== Instruction Memory ========
    adsd_32_ROM IMEM(
        .addr(pc),
        .OE(ctrl_i_mem_oe),
        .data_out(ir)
    );

    // ======== Register File ========
    adsd_32_mux21_5b mux_rf_rd(
        .dout(rf_rd),
        .in0(ir_rt),
        .in1(ir[4:0]),
        .sel(ctrl_rf_rd_sel)
    );

    adsd_32_REGISTER RF(
        .clk(clk),
        .rst(rst),
        .write_en(ctrl_rf_write_en),
        .rd(rf_rd),
        .data_in(rf_data_in),
        .rs(ir_rs),
        .rs_data_out(rf_rs_data_out),
        .rt(ir_rt),
        .rt_data_out(rf_rt_data_out),
        .r15(LEDport)           // connect r31 to LEDs
    );

    // ======== ALU Input Mux ========
    adsd_32_mux21_32b mux_alu_in2(
        .dout(alu_in2),
        .in0(rf_rt_data_out),
        .in1(imm16_to32),
        .sel(ctrl_alu_in2_sel)
    );

    // ======== ALU ========
    adsd_32_ALU ALU1(
        .aluop(ctrl_aluop),
        .operand1(rf_rs_data_out),
        .operand2(alu_in2),
        .imm16(imm16),
        .out(alu_out),
        .zero(ctrl_zero),
        .neg(ctrl_neg),
        .ovf(ctrl_ovf)
    );

    // ======== Data Memory ========
    adsd_32_RAM DMEM(
        .clk(clk),
        .CS(ctrl_d_mem_cs),
        .RW_(ctrl_d_mem_rw_),
        .addr(alu_out),
        .data_in(rf_rt_data_out),
        .data_out(d_mem_data_out)
    );

    // ======== Write Data Mux ========
    adsd_32_mux21_32b mux_rf_data_in(
        .dout(rf_data_in),
        .in0(d_mem_data_out),
        .in1(alu_out),
        .sel(ctrl_wdata_sel)
    );

    // ======== Branch Mux ========
    adsd_32_mux21_32b mux_branch(
        .dout(mux_branch_out),
        .in0(pc_plus1),
        .in1(pc_plus1_plus_imm16),
        .sel(ctrl_branch)
    );

    // ======== Jump Mux ========
    adsd_32_mux21_32b mux_jump(
        .dout(pc_next),
        .in0(mux_branch_out),
        .in1(imm24_to32),
        .sel(ctrl_jump)
    );

endmodule

module adsd_32_ctrl(
    input rst,
    input clk,
    input [7:0] opcode,

    output reg pc_ld,
    output reg ctrl_branch,
    output reg ctrl_jump,
    output reg ctrl_i_mem_oe,
    output reg ctrl_rf_rd_sel,
    output reg ctrl_rf_write_en,
    output reg ctrl_alu_in2_sel,
    output reg ctrl_d_mem_rw_,
    output reg ctrl_d_mem_cs,
    output reg ctrl_wdata_sel,

    output reg [7:0] ctrl_aluop,

    input zero,
    input neg,
    input ovf
);
always @(*) begin
    // Default signals
    pc_ld = 1'b0;
    ctrl_i_mem_oe = 1'b1;
    ctrl_rf_rd_sel = 1'b0;
    ctrl_rf_write_en = 1'b1;
    ctrl_alu_in2_sel = 1'b1;
    ctrl_d_mem_rw_ = 1'b0;
    ctrl_d_mem_cs = 1'b0;
    ctrl_wdata_sel = 1'b1;
    ctrl_branch = 1'b0;
    ctrl_jump = 1'b0;
    ctrl_aluop = opcode;
    
//    if(opcode == 8'h26) begin // ADDI r31
//        pc_ld = 1;
//        ctrl_rf_write_en = 1;
//        ctrl_alu_in2_sel = 1;
//        ctrl_wdata_sel = 1;
//    end
//    else if(opcode == 8'h51) begin // JMP
//        pc_ld = 1;
//        ctrl_jump = 1;
//    end
	 case(opcode)
        8'h26: begin
		  pc_ld = 1'b1;
        ctrl_rf_write_en = 1'b1;
        ctrl_alu_in2_sel = 1'b1;
        ctrl_wdata_sel = 1'b1; 
		  ctrl_aluop = 8'b00100110;// ADDI
		  end
        8'h10: begin
		  pc_ld = 1'b1;
        ctrl_rf_write_en = 1'b1;
        ctrl_alu_in2_sel = 1'b1;
        ctrl_wdata_sel = 1'b1;
		  ctrl_aluop = 8'b00010000;// ADD
		  end
        8'h11: begin
		  pc_ld = 1'b1;
        ctrl_rf_write_en = 1'b1;
        ctrl_alu_in2_sel = 1'b1;
        ctrl_wdata_sel = 1'b1;
		  ctrl_aluop = 8'b00010001;// SUB
		  end
        8'h12: begin 
		  pc_ld = 1'b1;
        ctrl_rf_write_en = 1'b1;
        ctrl_alu_in2_sel = 1'b1;
        ctrl_wdata_sel = 1'b1;
		  ctrl_aluop = 8'b00010010;// OR
		  end
        8'h13: begin
		  pc_ld = 1'b1;
        ctrl_rf_write_en = 1'b1;
        ctrl_alu_in2_sel = 1'b1;
        ctrl_wdata_sel = 1'b1;
		  ctrl_aluop = 8'b00010011;// AND
		  end
		  8'h25: begin
		  pc_ld = 1'b1;
        ctrl_rf_write_en = 1'b1;
        ctrl_alu_in2_sel = 1'b1;
        ctrl_wdata_sel = 1'b1;
		  ctrl_aluop = 8'b00100101;// NOT
		  end
		  8'h31: begin
		  pc_ld = 1'b1;
        ctrl_rf_write_en = 1'b1;
        ctrl_alu_in2_sel = 1'b1;
        ctrl_wdata_sel = 1'b1;
		  ctrl_aluop = 8'b00110001;// BEQ
		  end
        8'h51: begin
		    pc_ld = 1;
       ctrl_jump = 1;
		  ctrl_aluop = 8'b01010001;// JMP
		  end
    endcase
end
endmodule
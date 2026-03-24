module adsd_32_ALU(
input [7:0] aluop,
input [31:0] operand1,
input [31:0] operand2,
input [15:0] imm16,
output reg [31:0] out,
output zero,
output neg,
output ovf
);
wire [31:0] imm32 = {{16{1'b0}},imm16};
always @(*) begin
    case(aluop)
        8'h26: out = operand1 + imm32;   // ADDI
        8'h10: out = operand1 + operand2;// ADD
        8'h11: out = operand1 - operand2;// SUB
        8'h12: out = operand1 | operand2;// OR
        8'h13: out = operand1 & operand2;// AND
        default: out = operand1 + operand2;
    endcase
end
assign zero = (out==0);
assign neg = out[31];
assign ovf = 0;
endmodule
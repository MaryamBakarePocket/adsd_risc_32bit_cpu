module adsd_32_mux21_32b(
output [31:0] dout,
input [31:0] in0,
input [31:0] in1,
input sel
);
assign dout = sel ? in1 : in0;
endmodule
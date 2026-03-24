module adsd_32_mux21_5b(
output [4:0] dout,
input [4:0] in0,
input [4:0] in1,
input sel
);
assign dout = sel ? in1 : in0;
endmodule
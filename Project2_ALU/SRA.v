module SRA(x, ctrl_shiftamt, SRA_result);
	input [31:0] x;
	input [4:0] ctrl_shiftamt;
	
	output [31:0] SRA_result;
	wire [31:0] result0, result1, result2, result3, result4, result5, result6, result7, result8, result9;
	
	// In case MSB is 0
	assign result0 = ctrl_shiftamt[0]? {1'b0, x[31:1]}:x;
	assign result1 = ctrl_shiftamt[1]? {2'b00, result0[31:2]}:result0;
	assign result2 = ctrl_shiftamt[2]? {4'b0000, result1[31:4]}:result1;
	assign result3 = ctrl_shiftamt[3]? {8'b00000000, result2[31:8]}:result2;
	assign result4 = ctrl_shiftamt[4]? {16'b0000000000000000, result3[31:16]}:result3;
	
	// In case MSB is 1
	assign result5 = ctrl_shiftamt[0]? {1'b1, x[31:1]}:x;
	assign result6 = ctrl_shiftamt[1]? {2'b11, result5[31:2]}:result5;
	assign result7 = ctrl_shiftamt[2]? {4'b1111, result6[31:4]}:result6;
	assign result8 = ctrl_shiftamt[3]? {8'b11111111, result7[31:8]}:result7;
	assign result9 = ctrl_shiftamt[4]? {16'b1111111111111111, result8[31:16]}:result8;
	
	// Depending on the MSB's value
	assign SRA_result = x[31]? result9: result4;

endmodule

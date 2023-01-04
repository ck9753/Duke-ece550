module SLL(x, ctrl_shiftamt, SLL_result);
	input [31:0] x;
	input [4:0] ctrl_shiftamt;
	
	output [31:0] SLL_result;
	wire [31:0] result0, result1, result2, result3;
	
	assign result0 = ctrl_shiftamt[0]? {x[30:0], 1'b0}:x;
	assign result1 = ctrl_shiftamt[1]? {result0[29:0], 2'b00}:result0;
	assign result2 = ctrl_shiftamt[2]? {result1[27:0], 4'b0000}:result1;
	assign result3 = ctrl_shiftamt[3]? {result2[23:0], 8'b00000000}:result2;
	assign SLL_result = ctrl_shiftamt[4]? {result3[15:0], 16'b0000000000000000}:result3;

endmodule

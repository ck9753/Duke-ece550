module add(x, y, add_result, cout, of);
	input [31:0] x, y;
	
	output [31:0] add_result;
	output cout, of;
	
	CSA CSA0(x, y, 1'b0, add_result, cout, of);
	
endmodule

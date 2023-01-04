module add(x, y, s, cout, of);
	input [31:0] x, y;
	
	output [31:0] s;
	output cout, of;
	
	cla cla0(x, y, 1'b0, s, cout, of);
	
endmodule

module sub(x, y, sub_result, cout, of);
	input [31:0] x, y;
	wire [31:0] neg_y;
	output [31:0] sub_result;
	output cout, of;
	
	// convert all bits of y 0 to 1, 1 to 0
	genvar i;
	generate
			for (i = 0; i < 32; i = i + 1)
			begin: ones_comp_loop
					not not0(neg_y[i], y[i]);
			end
	endgenerate
	
	CSA CSA1(x, neg_y, 1'b1, sub_result, cout, of);
endmodule

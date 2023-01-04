module sub(x, y, s, cout, of);
	input [31:0] x, y;
	wire [31:0] neg_y;
	output [31:0] s;
	output cout, of;
	
	// convert all bits of y 0 to 1, 1 to 0
	genvar i;
	generate
			for (i=0; i<=31; i=i+1)
			begin: ones_comp_loop
					not not0(neg_y[i], y[i]);
			end
	endgenerate
	
	cla cla1(x, net_y, 1'b1, s, cout, of);
endmodule

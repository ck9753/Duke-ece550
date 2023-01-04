module register(out, in, clk, en, clr);
	
	// inputs
	input [31:0] in;
	input clk, en, clr;
	
	// output
	output [31:0] out;

	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1)
		begin: dffe_loop
			dffe_ref dff_x (out[i], in[i], clk, en, clr);
		end
	endgenerate
	
endmodule

	
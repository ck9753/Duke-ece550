module tristate_buffer_bufif(tribuf_out, data_in, en);
	
	input [31:0] data_in;
	input en;
	
	output [31:0] tribuf_out;
	tri [31:0] tribuf_out;
	
	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1)
		begin: bufif_loop
			bufif1 bufif_n (tribuf_out[i], data_in[i], en); 
		end
	endgenerate
	
endmodule

module pc(next_ins, cur_ins, clock, reset);
	input clock, reset;
	input[11:0] cur_ins;
	
	output[11:0] next_ins;
	
	
	genvar i;
	
	generate
		for (i = 0; i < 12; i = i + 1) begin: dffe_loop
			dffe_ref dffe1(next_ins[i], cur_ins[i], clock, 1'b1, reset);
		end
	endgenerate
	


endmodule
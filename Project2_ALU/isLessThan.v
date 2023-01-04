module isLessThan(sub_result, sub_of, isLessThan);
	input [31:0] sub_result;
	input sub_of;
	
	output isLessThan;
	
	xor xor0(isLessThan, sub_result[31], sub_of);
	
endmodule

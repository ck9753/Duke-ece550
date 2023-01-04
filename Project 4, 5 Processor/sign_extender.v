module sign_extender(result, op);
	input[16:0] op;
	output[31:0] result;
	
	assign result = { {15{op[16]}}, op};
	

endmodule
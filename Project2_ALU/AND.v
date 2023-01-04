module AND(A, B, AND_result);
	input [31:0] A, B;
	output [31:0] AND_result;
	
	genvar i;
	generate
		for (i = 0; i <= 31; i = i + 1) begin: bit_and_loop
			and bit_and(AND_result[i], A[i], B[i]);
		end
	endgenerate

endmodule

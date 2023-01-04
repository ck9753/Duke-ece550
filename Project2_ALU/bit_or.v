module bit_or(A, B, or_result);
	input [31:0] A;
	input [31:0] B;
	output [31:0] or_result;
	
	or or0(or_result[0], A[0], B[0]);
	or or1(or_result[1], A[1], B[1]);
	or or2(or_result[2], A[2], B[2]);
	or or3(or_result[3], A[3], B[3]);
	or or4(or_result[4], A[4], B[4]);
	or or5(or_result[5], A[5], B[5]);
	or or6(or_result[6], A[6], B[6]);
	or or7(or_result[7], A[7], B[7]);
	or or8(or_result[8], A[8], B[8]);
	or or9(or_result[9], A[9], B[9]);
	or or10(or_result[10], A[10], B[10]);
	or or11(or_result[11], A[11], B[11]);
	or or12(or_result[12], A[12], B[12]);
	or or13(or_result[13], A[13], B[13]);
	or or14(or_result[14], A[14], B[14]);
	or or15(or_result[15], A[15], B[15]);
	or or16(or_result[16], A[16], B[16]);
	or or17(or_result[17], A[17], B[17]);
	or or18(or_result[18], A[18], B[18]);
	or or19(or_result[19], A[19], B[19]);
	or or20(or_result[20], A[20], B[20]);
	or or21(or_result[21], A[21], B[21]);
	or or22(or_result[22], A[22], B[22]);
	or or23(or_result[23], A[23], B[23]);
	or or24(or_result[24], A[24], B[24]);
	or or25(or_result[25], A[25], B[25]);
	or or26(or_result[26], A[26], B[26]);
	or or27(or_result[27], A[27], B[27]);
	or or28(or_result[28], A[28], B[28]);
	or or29(or_result[29], A[29], B[29]);
	or or30(or_result[30], A[30], B[30]);
	or or31(or_result[31], A[31], B[31]);

endmodule

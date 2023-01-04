module isNotEqual(sub_result, cout, isNotEqual);
	input [31:0] sub_result;
	input cout;
	output isNotEqual;
	
	wire x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29;
	wire bit_or_result, neg_bit_or_result, isEqual;
	
	or or0(x0, sub_result[0], sub_result[1]);
	or or1(x1, sub_result[2], x0);
	or or2(x2, sub_result[3], x1);
	or or3(x3, sub_result[4], x2);
	or or4(x4, sub_result[5], x3);
	or or5(x5, sub_result[6], x4);
	or or6(x6, sub_result[7], x5);
	or or7(x7, sub_result[8], x6);
	or or8(x8, sub_result[9], x7);
	or or9(x9, sub_result[10], x8);
	or or10(x10, sub_result[11], x9);
	or or11(x11, sub_result[12], x10);
	or or12(x12, sub_result[13], x11);
	or or13(x13, sub_result[14], x12);
	or or14(x14, sub_result[15], x13);
	or or15(x15, sub_result[16], x14);
	or or16(x16, sub_result[17], x15);
	or or17(x17, sub_result[18], x16);
	or or18(x18, sub_result[19], x17);
	or or19(x19, sub_result[20], x18);
	or or20(x20, sub_result[21], x19);
	or or21(x21, sub_result[22], x20);
	or or22(x22, sub_result[23], x21);
	or or23(x23, sub_result[24], x22);
	or or24(x24, sub_result[25], x23);
	or or25(x25, sub_result[26], x24);
	or or26(x26, sub_result[27], x25);
	or or27(x27, sub_result[28], x26);
	or or28(x28, sub_result[29], x27);
	or or29(x29, sub_result[30], x28);
	or or30(bit_or_result, sub_result[31], x29);
	
	not not0(neg_bit_or_result, bit_or_result);
	and and0(isEqual, neg_bit_or_result, cout); 
	
	not not1(isNotEqual,isEqual);	
	
endmodule
	
	
	
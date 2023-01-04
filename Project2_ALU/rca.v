module rca(in1, in2, cin, sum, cout);
	input[15:0] in1, in2;
	input cin;
	output[15:0] sum;
	output cout;
	
	wire cout0, cout1, cout2, cout3, cout4, cout5, cout6, cout7, cout8, cout9, cout10, cout11, cout12, cout13, cout14, cout15;
	//, cout16, cout17, cout18, cout19, cout20, cout21, cout22, cout23, cout23, cout24, cout25, cout26, cout27, cout28, cout29, cout30, cout31;

	full_adder full_adder1(in1[0], in2[0], cin, sum[0], cout0);
	full_adder full_adder2(in1[1], in2[1], cout0, sum[1], cout1);
	full_adder full_adder3(in1[2], in2[2], cout1, sum[2], cout2);
	full_adder full_adder4(in1[3], in2[3], cout2, sum[3], cout3);
	full_adder full_adder5(in1[4], in2[4], cout3, sum[4], cout4);
	full_adder full_adder6(in1[5], in2[5], cout4, sum[5], cout5);
	full_adder full_adder7(in1[6], in2[6], cout5, sum[6], cout6);
	full_adder full_adder8(in1[7], in2[7], cout6, sum[7], cout7);
	full_adder full_adder9(in1[8], in2[8], cout7, sum[8], cout8);
	full_adder full_adder10(in1[9], in2[9], cout8, sum[9], cout9);
	full_adder full_adder11(in1[10], in2[10], cout9, sum[10], cout10);
	full_adder full_adder12(in1[11], in2[11], cout10, sum[11], cout11);
	full_adder full_adder13(in1[12], in2[12], cout11, sum[12], cout12);
	full_adder full_adder14(in1[13], in2[13], cout12, sum[13], cout13);
	full_adder full_adder15(in1[14], in2[14], cout13, sum[14], cout14);
	full_adder full_adder16(in1[15], in2[15], cout14, sum[15], cout);
	/*
	full_adder full_adder17(in1[16], in2[16], cout15, sum[0], cout16);
	full_adder full_adder18(in1[17], in2[17], cout16, sum[0], cout17);
	full_adder full_adder19(in1[18], in2[18], cout17, sum[0], cout18);
	full_adder full_adder20(in1[19], in2[19], cout18, sum[0], cout19);
	full_adder full_adder21(in1[20], in2[20], cout19, sum[0], cout20);
	full_adder full_adder22(in1[21], in2[21], cout20, sum[0], cout21);
	full_adder full_adder23(in1[22], in2[22], cout21, sum[0], cout22);
	full_adder full_adder24(in1[23], in2[23], cout22, sum[0], cout23);
	full_adder full_adder25(in1[24], in2[24], cout23, sum[0], cout24);
	full_adder full_adder26(in1[25], in2[25], cout24, sum[0], cout25);
	full_adder full_adder27(in1[26], in2[26], cout25, sum[0], cout26);
	full_adder full_adder28(in1[27], in2[27], cout26, sum[0], cout27);
	full_adder full_adder29(in1[28], in2[28], cout27, sum[0], cout28);
	full_adder full_adder30(in1[29], in2[29], cout28, sum[0], cout29);
	full_adder full_adder31(in1[30], in2[30], cout29, sum[0], cout30);
	full_adder full_adder32(in1[31], in2[31], cout30, sum[0], cout31);
	*/
	
endmodule 
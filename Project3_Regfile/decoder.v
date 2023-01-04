module decoder(out, ctrl_writeReg);
	// inputs
	input [4:0] ctrl_writeReg;
	
	// output
	output [31:0] out;
	
	
	and and0 (out[0], ~ctrl_writeReg[4], ~ctrl_writeReg[3], ~ctrl_writeReg[2], ~ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and1 (out[1], ~ctrl_writeReg[4], ~ctrl_writeReg[3], ~ctrl_writeReg[2], ~ctrl_writeReg[1], ctrl_writeReg[0]);
	and and2 (out[2], ~ctrl_writeReg[4], ~ctrl_writeReg[3], ~ctrl_writeReg[2], ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and3 (out[3], ~ctrl_writeReg[4], ~ctrl_writeReg[3], ~ctrl_writeReg[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	and and4 (out[4], ~ctrl_writeReg[4], ~ctrl_writeReg[3], ctrl_writeReg[2], ~ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and5 (out[5], ~ctrl_writeReg[4], ~ctrl_writeReg[3], ctrl_writeReg[2], ~ctrl_writeReg[1], ctrl_writeReg[0]);
	and and6 (out[6], ~ctrl_writeReg[4], ~ctrl_writeReg[3], ctrl_writeReg[2], ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and7 (out[7], ~ctrl_writeReg[4], ~ctrl_writeReg[3], ctrl_writeReg[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	
	and and8 (out[8], ~ctrl_writeReg[4], ctrl_writeReg[3], ~ctrl_writeReg[2], ~ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and9 (out[9], ~ctrl_writeReg[4], ctrl_writeReg[3], ~ctrl_writeReg[2], ~ctrl_writeReg[1], ctrl_writeReg[0]);
	and and10 (out[10], ~ctrl_writeReg[4], ctrl_writeReg[3], ~ctrl_writeReg[2], ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and11 (out[11], ~ctrl_writeReg[4], ctrl_writeReg[3], ~ctrl_writeReg[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	and and12 (out[12], ~ctrl_writeReg[4], ctrl_writeReg[3], ctrl_writeReg[2], ~ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and13 (out[13], ~ctrl_writeReg[4], ctrl_writeReg[3], ctrl_writeReg[2], ~ctrl_writeReg[1], ctrl_writeReg[0]);
	and and14 (out[14], ~ctrl_writeReg[4], ctrl_writeReg[3], ctrl_writeReg[2], ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and15 (out[15], ~ctrl_writeReg[4], ctrl_writeReg[3], ctrl_writeReg[2], ctrl_writeReg[1], ctrl_writeReg[0]);

	
	and and16 (out[16], ctrl_writeReg[4], ~ctrl_writeReg[3], ~ctrl_writeReg[2], ~ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and17 (out[17], ctrl_writeReg[4], ~ctrl_writeReg[3], ~ctrl_writeReg[2], ~ctrl_writeReg[1], ctrl_writeReg[0]);
	and and18 (out[18], ctrl_writeReg[4], ~ctrl_writeReg[3], ~ctrl_writeReg[2], ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and19 (out[19], ctrl_writeReg[4], ~ctrl_writeReg[3], ~ctrl_writeReg[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	and and20 (out[20], ctrl_writeReg[4], ~ctrl_writeReg[3], ctrl_writeReg[2], ~ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and21 (out[21], ctrl_writeReg[4], ~ctrl_writeReg[3], ctrl_writeReg[2], ~ctrl_writeReg[1], ctrl_writeReg[0]);
	and and22 (out[22], ctrl_writeReg[4], ~ctrl_writeReg[3], ctrl_writeReg[2], ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and23 (out[23], ctrl_writeReg[4], ~ctrl_writeReg[3], ctrl_writeReg[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	
	and and24 (out[24], ctrl_writeReg[4], ctrl_writeReg[3], ~ctrl_writeReg[2], ~ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and25 (out[25], ctrl_writeReg[4], ctrl_writeReg[3], ~ctrl_writeReg[2], ~ctrl_writeReg[1], ctrl_writeReg[0]);
	and and26 (out[26], ctrl_writeReg[4], ctrl_writeReg[3], ~ctrl_writeReg[2], ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and27 (out[27], ctrl_writeReg[4], ctrl_writeReg[3], ~ctrl_writeReg[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	and and28 (out[28], ctrl_writeReg[4], ctrl_writeReg[3], ctrl_writeReg[2], ~ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and29 (out[29], ctrl_writeReg[4], ctrl_writeReg[3], ctrl_writeReg[2], ~ctrl_writeReg[1], ctrl_writeReg[0]);
	and and30 (out[30], ctrl_writeReg[4], ctrl_writeReg[3], ctrl_writeReg[2], ctrl_writeReg[1], ~ctrl_writeReg[0]);
	and and31 (out[31], ctrl_writeReg[4], ctrl_writeReg[3], ctrl_writeReg[2], ctrl_writeReg[1], ctrl_writeReg[0]);
	
	
endmodule

	
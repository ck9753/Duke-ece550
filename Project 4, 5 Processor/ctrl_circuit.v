module ctrl_circuit (ctrl_Rwe, ctrl_Rdst, ctrl_DMwe, ctrl_Rwd, ctrl_ALUinB, ctrl_bne, ctrl_blt, JP, ctrl_rd, ctrl_rstatus, ctrl_wreg, opcode);
	input [4:0]opcode;
	output ctrl_Rwe, ctrl_Rdst, ctrl_DMwe, ctrl_Rwd, ctrl_ALUinB,
	ctrl_bne, ctrl_blt, JP, ctrl_rd, ctrl_rstatus, ctrl_wreg;
	
	// negate each bits of opcode
	not not0 (n_s0, opcode[0]);
	not not1 (n_s1, opcode[1]);
	not not2 (n_s2, opcode[2]);
	not not3 (n_s3, opcode[3]);
	not not4 (n_s4, opcode[4]);
	
	// get each bits of opcode
	and and0 (s0, opcode[0], 1'b1);
	and and1 (s1, opcode[1], 1'b1);
	and and2 (s2, opcode[2], 1'b1);
	and and3 (s3, opcode[3], 1'b1);
	and and4 (s4, opcode[4], 1'b1);
	
	// Rwe (updated for j and b)
	and and5 (Rwe_1, n_s4, n_s3, n_s2, n_s1, n_s0);
	and and6 (Rwe_2, n_s4, n_s3, s2, n_s1, s0);
	and and7 (Rwe_3, n_s4, s3, n_s2, n_s1, n_s0);
	and and8 (Rwe_4, n_s4, n_s3, n_s2, s1, s0);
	and and9 (Rwe_5, s4, n_s3, s2, n_s1, s0);
	
	or or0 (ctrl_Rwe, Rwe_1, Rwe_2, Rwe_3, Rwe_4, Rwe_5);
	
	// Rdst
	and and10 (ctrl_Rdst, n_s4, n_s3, n_s2, n_s1, n_s0);
	
	// DMwe
	and and11 (ctrl_DMwe, n_s4, n_s3, s2, s1, s0);
	
	// Rwd
	and and12 (ctrl_Rwd, n_s4, s3, n_s2, n_s1, n_s0);
	
	// ALUinB
	and and13 (ALUinB_1, n_s4, n_s3, s2, n_s1, s0);
	and and14 (ALUinB_2, n_s4, n_s3, s2, s1, s0);
	and and15 (ALUinB_3, n_s4, s3, n_s2, n_s1, n_s0);
	
	or or1 (ctrl_ALUinB, ALUinB_1, ALUinB_2, ALUinB_3);
	
	// BR
	and and16 (ctrl_bne, n_s4, n_s3, n_s2, s1, n_s0);
	and and17 (ctrl_blt, n_s4, n_s3, s2, s1, n_s0);
	
	
	// JP (removed setX insns)
	and and18 (jp_1, n_s4, n_s3, n_s2, n_s1, s0);
	and and19 (jp_2, n_s4, n_s3, n_s2, s1, s0);
	and and20 (jp_3, n_s4, n_s3, s2, n_s1, n_s0);
	and and21 (jp_4, s4, n_s3, s2, s1, n_s0);
	//and and22 (jp_5, s4, n_s3, s2, n_s1, s0);
	
	//or or3 (JP, jp_1, jp_2, jp_3, jp_4, jp_5);
	or or3 (JP, jp_1, jp_2, jp_3, jp_4);

	// ctrl_rd
	//and and23 (ctrl_rd_1, n_s4, n_s3, n_s2, s1, n_s0); bne
	and and24 (ctrl_rd, n_s4, n_s3, s2, n_s1, n_s0); //jr
	//and and25 (ctrl_rd_3, n_s4, n_s3, s2, s1, n_s0); blt
	
	//or or4 (ctrl_rd, ctrl_rd_1, ctrl_rd_2, ctrl_rd_3);
	
	// ctrl_rstatus
	and and26 (ctrl_rstatus, s4, n_s3, s2, s1, n_s0);
	
	// ctrl_wreg
	and and27 (ctrl_wreg_1, n_s4, n_s3, n_s2, s1, s0);
	and and28 (ctrl_wreg_2, s4, n_s3, s2, n_s1, s0);
	
	or or5 (ctrl_wreg, ctrl_wreg_1, ctrl_wreg_2);
	

endmodule

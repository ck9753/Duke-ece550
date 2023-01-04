module control(alu_opCtrl, opcode);
	input[4:0]opcode;
	output alu_opCtrl;
	
	or or1(alu_opCtrl, opcode[4], opcode[3], opcode[2], opcode[1], opcode[0]);

endmodule
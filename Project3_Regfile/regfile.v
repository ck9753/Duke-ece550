module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;

   /* YOUR CODE HERE */

	// write port
	wire [31:0] select_bits;
	
	wire [31:0] reg_out0, reg_out1, reg_out2, reg_out3, reg_out4, reg_out5, reg_out6, reg_out7, reg_out8, reg_out9, 
	reg_out10, reg_out11, reg_out12, reg_out13, reg_out14, reg_out15, reg_out16, reg_out17, reg_out18, reg_out19,
	reg_out20, reg_out21, reg_out22, reg_out23, reg_out24, reg_out25, reg_out26, reg_out27, reg_out28, reg_out29,
	reg_out30, reg_out31;
	
	writePort wP0(select_bits, ctrl_writeReg, ctrl_writeEnable);
	
	register reg0(reg_out0, 32'h00000000, clock, select_bits[0], ctrl_reset);
	register reg1(reg_out1, data_writeReg, clock, select_bits[1], ctrl_reset);
	register reg2(reg_out2, data_writeReg, clock, select_bits[2], ctrl_reset);
	register reg3(reg_out3, data_writeReg, clock, select_bits[3], ctrl_reset);
	register reg4(reg_out4, data_writeReg, clock, select_bits[4], ctrl_reset);
	register reg5(reg_out5, data_writeReg, clock, select_bits[5], ctrl_reset);
	register reg6(reg_out6, data_writeReg, clock, select_bits[6], ctrl_reset);
	register reg7(reg_out7, data_writeReg, clock, select_bits[7], ctrl_reset);
	register reg8(reg_out8, data_writeReg, clock, select_bits[8], ctrl_reset);
	register reg9(reg_out9, data_writeReg, clock, select_bits[9], ctrl_reset);
	register reg10(reg_out10, data_writeReg, clock, select_bits[10], ctrl_reset);
	register reg11(reg_out11, data_writeReg, clock, select_bits[11], ctrl_reset);
	register reg12(reg_out12, data_writeReg, clock, select_bits[12], ctrl_reset);
	register reg13(reg_out13, data_writeReg, clock, select_bits[13], ctrl_reset);
	register reg14(reg_out14, data_writeReg, clock, select_bits[14], ctrl_reset);
	register reg15(reg_out15, data_writeReg, clock, select_bits[15], ctrl_reset);
	register reg16(reg_out16, data_writeReg, clock, select_bits[16], ctrl_reset);
	register reg17(reg_out17, data_writeReg, clock, select_bits[17], ctrl_reset);
	register reg18(reg_out18, data_writeReg, clock, select_bits[18], ctrl_reset);
	register reg19(reg_out19, data_writeReg, clock, select_bits[19], ctrl_reset);
	register reg20(reg_out20, data_writeReg, clock, select_bits[20], ctrl_reset);
	register reg21(reg_out21, data_writeReg, clock, select_bits[21], ctrl_reset);
	register reg22(reg_out22, data_writeReg, clock, select_bits[22], ctrl_reset);
	register reg23(reg_out23, data_writeReg, clock, select_bits[23], ctrl_reset);
	register reg24(reg_out24, data_writeReg, clock, select_bits[24], ctrl_reset);
	register reg25(reg_out25, data_writeReg, clock, select_bits[25], ctrl_reset);
	register reg26(reg_out26, data_writeReg, clock, select_bits[26], ctrl_reset);
	register reg27(reg_out27, data_writeReg, clock, select_bits[27], ctrl_reset);
	register reg28(reg_out28, data_writeReg, clock, select_bits[28], ctrl_reset);
	register reg29(reg_out29, data_writeReg, clock, select_bits[29], ctrl_reset);
	register reg30(reg_out30, data_writeReg, clock, select_bits[30], ctrl_reset);
	register reg31(reg_out31, data_writeReg, clock, select_bits[31], ctrl_reset);
	
	
	// read port
	readPort rp0(data_readRegA, ctrl_readRegA, reg_out0, reg_out1, reg_out2, reg_out3, reg_out4, reg_out5, reg_out6,
	reg_out7, reg_out8, reg_out9, reg_out10, reg_out11, reg_out12, reg_out13, reg_out14, reg_out15, reg_out16, 
	reg_out17, reg_out18, reg_out19, reg_out20, reg_out21, reg_out22, reg_out23, reg_out24, reg_out25, reg_out26, 
	reg_out27, reg_out28, reg_out29, reg_out30, reg_out31);
	
	
	readPort rp1(data_readRegB, ctrl_readRegB, reg_out0, reg_out1, reg_out2, reg_out3, reg_out4, reg_out5, reg_out6,
	reg_out7, reg_out8, reg_out9, reg_out10, reg_out11, reg_out12, reg_out13, reg_out14, reg_out15, reg_out16, 
	reg_out17, reg_out18, reg_out19, reg_out20, reg_out21, reg_out22, reg_out23, reg_out24, reg_out25, reg_out26, 
	reg_out27, reg_out28, reg_out29, reg_out30, reg_out31);
	
	
endmodule

module data_writePort(data_writeReg, ctrl_writeReg, ctrl_Rwd, ctrl_overflow, JP, ctrl_Rwe, q_dmem, alu_out, pc_out, target, alu_op, imem_op, dest_reg);
	input ctrl_Rwd, ctrl_overflow, JP, ctrl_Rwe;
	input[31:0] q_dmem, alu_out, pc_out, target;
	input[4:0] alu_op, imem_op, dest_reg;
	
	output[31:0] data_writeReg;
	output[4:0] ctrl_writeReg;

	wire rstatus_add, rstatus_addi, rstatus_sub, ctrl_rstatus, ctrl_jal, ctrl_setx, ra, f_rstatus;
	wire [31:0] add_overflow, sub_overflow, addi_overflow, temp_regData, rtype_overflow;
	wire [31:0] result;
		
	sign_extender ext1(add_overflow, { {16{1'b0}}, 1'b1 });
	sign_extender ext2(addi_overflow, { {15{1'b0}}, 2'b10 });
	sign_extender ext3(sub_overflow, { {15{1'b0}}, 2'b11 });
	
	 
	///Overflow handler
	
	assign rstatus_add = ~alu_op[4] & ~alu_op[3] & ~alu_op[2] & ~alu_op[1] & ~alu_op[0]; //00000
	assign rstatus_sub = ~alu_op[4] & ~alu_op[3] & ~alu_op[2] & ~alu_op[1] & alu_op[0]; //00001
	assign rstatus_addi = ~imem_op[4] & ~imem_op[3] & imem_op[2] & ~imem_op[1] & imem_op[0];
	///Final result
	and final_status(ctrl_rstatus, ctrl_overflow, (rstatus_add | rstatus_sub | rstatus_addi));
	
	assign rtype_overflow = rstatus_add ? add_overflow : rstatus_sub ? sub_overflow : 32'b0;
	assign temp_regData = rstatus_addi ? addi_overflow : rtype_overflow;
	
	//Jal and setx instructions
	assign ctrl_jal = ~imem_op[4] & ~imem_op[3] & ~imem_op[2] & imem_op[1] & imem_op[0];
	assign ctrl_setx = imem_op[4] & ~imem_op[3] & imem_op[2] & ~imem_op[1] & imem_op[0];
		
	
	assign f_rstatus = ctrl_rstatus | ctrl_setx;
	assign ra = JP & ctrl_jal & ctrl_Rwe; 
	
	//set destination register to 30 if ctrl_rstatus is 1
	assign ctrl_writeReg = f_rstatus ? 5'b11110 : ( ra ? 5'b11111: dest_reg );
	
	assign result = ctrl_rstatus ? temp_regData : alu_out;
	assign data_writeReg = ctrl_Rwd ? q_dmem : (ctrl_setx ? target : (ctrl_jal ? pc_out : result));
	
	

endmodule
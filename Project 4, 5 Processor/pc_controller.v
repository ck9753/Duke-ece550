module pc_controller(next_ins, ra_ins, cur_ins, clock, reset, 
abs_address, offset, ctrl_branch, ctrl_jump);

	input clock, reset, ctrl_branch, ctrl_jump;
	input[11:0] cur_ins;
	input[31:0] abs_address, offset;
	output[11:0] next_ins, ra_ins;

	wire[31:0] temp_ins, input_ins, ext_offset, branch_address;
	wire pc_isNotEqual, pc_isLessThan, pc_overflow;
	wire[11:0] pc_address, pc_address_temp;
	
	
	assign input_ins = cur_ins;
	
	alu pc_alu(
		input_ins, 
		32'h1, 
		5'b00000, 
		5'b00000, 
		temp_ins,
		pc_isNotEqual, 
		pc_isLessThan, 
		pc_overflow
		);
		
	alu pc_alu2(
		temp_ins, 
		offset, 
		5'b00000, 
		5'b00000, 
		branch_address,
		pc_isNotEqual, 
		pc_isLessThan, 
		pc_overflow
		);
		
		assign ra_ins = temp_ins[11:0];
		assign pc_address_temp = ctrl_branch ? branch_address[11:0] : temp_ins[11:0];
		assign pc_address = ctrl_jump ? abs_address[11:0] : pc_address_temp;
		pc pc_reg(next_ins, pc_address, clock, reset);
		

endmodule
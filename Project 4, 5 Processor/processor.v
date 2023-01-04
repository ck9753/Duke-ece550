/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;
	 
	 //internal wires
	 wire isNotEqual, isLessThan, overflow;
	 wire[31:0] alu_out, ext_immediate, temp_opB, target_addr, pc_extended;
	 wire[11:0] temp_ins, ra_address;
	 wire ctrl_Rdst,ctrl_Rwd, ctrl_ALUinB, temp_op;
	 wire ctrl_b, ctrl_j, ctrl_bne, ctrl_blt, JP, ctrl_rd, ctrl_rstatus, ctrl_wreg, temp_ctrl_readRegB, c_bex;
	 wire[4:0] alu_op, shift_amt, temp_addr;
	 
	 assign c_jr = JP & ctrl_rd;
	 assign target_addr = c_jr ? data_readRegB: { {5{q_imem[26]}}, q_imem[26:0]};
	 
	 assign c_bex = JP & ctrl_rstatus;
	 assign ctrl_j = (c_bex & ~isNotEqual) ? 1'b0 : JP;
	 
	 //PC + 1 address to be passed to data_writePort
	 assign pc_extended = { {20{1'b0}}, ra_address};
	 
	 //bne: set ctrl_bne signal to 1 if BR and isNotEqual are 1
	 //blt: set ctrl_b signal to 1 if BR and isLessThan are 1
	 //set ctrl_b signal in PC controller if either ctrl_bne or ctrl_blt is 1
	 and and_bne(br_1, ctrl_bne, isNotEqual);
	 and and_blt(br_2, ctrl_blt, isLessThan);
	 
	 or or_b(ctrl_b, br_1, br_2);
	 
	 
	//Initialize pc controller
	assign temp_ins = reset ? { 12{1'b0} } : address_imem;
	 pc_controller controller(
		.next_ins (address_imem),
		.ra_ins   (ra_address),
		.cur_ins  (temp_ins),
		.clock    (clock),
		.reset    (reset),
		.abs_address (target_addr),
		.offset   (ext_immediate),
		.ctrl_branch  (ctrl_b),
		.ctrl_jump    (ctrl_j)
	 );
	
	 //sets the control signals
	 ctrl_circuit ctrl(ctrl_writeEnable, 
		ctrl_Rdst, 
		wren, 
		ctrl_Rwd, 
		ctrl_ALUinB,  
		ctrl_bne,
		ctrl_blt,	
		JP, 
		ctrl_rd, 
		ctrl_rstatus, 
		ctrl_wreg, 
		q_imem[31:27]);
	 
	 //sign-extend immediate
	 sign_extender sign_ext(ext_immediate, q_imem[16:0]);
	 
	 //control for determining if ALU operandB is the extended immediate or value from the register
	 assign temp_opB = ctrl_ALUinB ? ext_immediate : data_readRegB;
	 
	 control alu_ctrl(temp_op, q_imem[31:27]);
	 assign alu_op = temp_op ? 5'b00000 : q_imem[6:2]; 
	 assign shift_amt = q_imem[11:7];

	 alu processor_alu(
		data_readRegA, 
		temp_opB, 
		alu_op, 
		shift_amt, 
		alu_out, 
		isNotEqual, 
		isLessThan, 
		overflow
		);
		
		//ctrl_readRegA:
		//rs => default
		//rd => bne, blt
		//$0 => bex
		assign ctrl_readRegA = c_bex ? 5'b00000 : ( (ctrl_blt | ctrl_bne) ? { q_imem[26:22] } : { q_imem[21:17] } );
		
		//ctrl_readRegB:
		// $31 => bex
		// rd => sw(wren), jr
		// rs => bne, blt(BR)
		// rt => default
		assign temp_addr = (ctrl_blt | ctrl_bne) ? { q_imem[21:17] } : { q_imem[16:12] };
		or or0(temp_ctrl_readRegB, wren, c_jr);
		assign ctrl_readRegB = temp_ctrl_readRegB ? { q_imem[26:22] } : ( c_bex ? 5'b11110 : temp_addr ); 
		
		//address_dmem == rs + N
		assign address_dmem = { alu_out[11:0] };

		//Set data_writeReg
		data_writePort writeRes(data_writeReg, 
			ctrl_writeReg, 
			ctrl_Rwd, 
			overflow, 
			JP, 
			ctrl_writeEnable, 
			q_dmem, 
			alu_out, 
			pc_extended,
			target_addr,
			alu_op, 
			q_imem[31:27], 
			q_imem[26:22]);
		//Data to write to memory
		assign data = { data_readRegB };
		
		
		//Update ctrl_writeReg to reg 30
		//Update data_writeReg to:
		//   1: rstatus_add and overflow
		//   2: rstatus_addi and overflow
		//   3: rstatus_sub and overflow
		
		

endmodule
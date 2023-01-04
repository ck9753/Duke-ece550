module writePort(select_bits, ctrl_writeReg, writeEn);
	input [4:0] ctrl_writeReg;
	input writeEn;
	
	output [31:0] select_bits;
	
	wire [31:0] temp_select_bits;
	
	decoder decoder0 (temp_select_bits, ctrl_writeReg);
	
	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1)
		begin: and_loop
			and and0(select_bits[i], temp_select_bits[i], writeEn);
		end
	endgenerate
	
endmodule
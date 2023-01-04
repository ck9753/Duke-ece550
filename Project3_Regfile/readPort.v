module readPort
(
output [31:0] data_out, 
input [4:0] ctrl_readReg,
input [31:0] reg_in0, reg_in1, reg_in2, reg_in3, reg_in4, reg_in5, reg_in6, reg_in7, reg_in8, reg_in9, reg_in10,
reg_in11, reg_in12, reg_in13, reg_in14, reg_in15, reg_in16, reg_in17, reg_in18, reg_in19, reg_in20, reg_in21,
reg_in22, reg_in23, reg_in24, reg_in25, reg_in26, reg_in27, reg_in28, reg_in29, reg_in30, reg_in31);
	
	wire [31:0] select_bits;
	
	decoder decode1(select_bits, ctrl_readReg);
	
	tristate_buffer_bufif tsb0 (data_out, reg_in0, select_bits[0]);
	tristate_buffer_bufif tsb1 (data_out, reg_in1, select_bits[1]);
	tristate_buffer_bufif tsb2 (data_out, reg_in2, select_bits[2]);
	tristate_buffer_bufif tsb3 (data_out, reg_in3, select_bits[3]);
	tristate_buffer_bufif tsb4 (data_out, reg_in4, select_bits[4]);
	tristate_buffer_bufif tsb5 (data_out, reg_in5, select_bits[5]);
	tristate_buffer_bufif tsb6 (data_out, reg_in6, select_bits[6]);
	tristate_buffer_bufif tsb7 (data_out, reg_in7, select_bits[7]);
	tristate_buffer_bufif tsb8 (data_out, reg_in8, select_bits[8]);
	tristate_buffer_bufif tsb9 (data_out, reg_in9, select_bits[9]);
	tristate_buffer_bufif tsb10 (data_out, reg_in10, select_bits[10]);
	tristate_buffer_bufif tsb11 (data_out, reg_in11, select_bits[11]);
	tristate_buffer_bufif tsb12 (data_out, reg_in12, select_bits[12]);
	tristate_buffer_bufif tsb13 (data_out, reg_in13, select_bits[13]);
	tristate_buffer_bufif tsb14 (data_out, reg_in14, select_bits[14]);
	tristate_buffer_bufif tsb15 (data_out, reg_in15, select_bits[15]);
	tristate_buffer_bufif tsb16 (data_out, reg_in16, select_bits[16]);
	tristate_buffer_bufif tsb17 (data_out, reg_in17, select_bits[17]);
	tristate_buffer_bufif tsb18 (data_out, reg_in18, select_bits[18]);
	tristate_buffer_bufif tsb19 (data_out, reg_in19, select_bits[19]);
	tristate_buffer_bufif tsb20 (data_out, reg_in20, select_bits[20]);
	tristate_buffer_bufif tsb21 (data_out, reg_in21, select_bits[21]);
	tristate_buffer_bufif tsb22 (data_out, reg_in22, select_bits[22]);
	tristate_buffer_bufif tsb23 (data_out, reg_in23, select_bits[23]);
	tristate_buffer_bufif tsb24 (data_out, reg_in24, select_bits[24]);
	tristate_buffer_bufif tsb25 (data_out, reg_in25, select_bits[25]);
	tristate_buffer_bufif tsb26 (data_out, reg_in26, select_bits[26]);
	tristate_buffer_bufif tsb27 (data_out, reg_in27, select_bits[27]);
	tristate_buffer_bufif tsb28 (data_out, reg_in28, select_bits[28]);
	tristate_buffer_bufif tsb29 (data_out, reg_in29, select_bits[29]);
	tristate_buffer_bufif tsb30 (data_out, reg_in30, select_bits[30]);
	tristate_buffer_bufif tsb31 (data_out, reg_in31, select_bits[31]);

endmodule

	
	
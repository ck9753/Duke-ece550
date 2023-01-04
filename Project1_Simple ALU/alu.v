module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	
	wire [31:0] add_result, sub_result;
	wire add_cout, add_of, sub_cout, sub_of;
	
	// addition
	add add0(data_operandA, data_operandB, add_result, add_cout, add_of);
	
	// subtraction
	sub sub0(data_operandA, data_operandB, sub_result, sub_cout, sub_of);
	
	assign data_result = ctrl_ALUopcode[0]? sub_result:add_result;
	assign overflow = ctrl_ALUopcode[0]? sub_of:add_of;

endmodule

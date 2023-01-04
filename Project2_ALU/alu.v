module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	
	wire [31:0] add_result, sub_result;
	wire [31:0] and_result, or_result, SLL_result, SRA_Result;
	wire add_cout, add_of, sub_cout, sub_of;
	wire sub_isNotEqual, sub_isLessThan;
	
	// addition
	add add0(data_operandA, data_operandB, add_result, add_cout, add_of);
	
	// subtraction
	sub sub0(data_operandA, data_operandB, sub_result, sub_cout, sub_of);
	isNotEqual isNotEqual0(sub_result, sub_cout, sub_isNotEqual);
	isLessThan isLessThan0(sub_result, sub_of, sub_isLessThan);
	
	// bitwise or & and operation
	bit_and bit_and0(data_operandA, data_operandB, and_result);
	bit_or bit_or0(data_operandA, data_operandB, or_result);

	SLL SLL0(data_operandA, ctrl_shiftamt, SLL_result);
	SRA SRA0(data_operandA, ctrl_dhiftamt, SRA_result);

	
	assign data_result = ctrl_ALUopcode[2]? (ctrl_ALUopcode[0]? SRA_result:SLL_result):(ctrl_ALUopcode[1]? (ctrl_ALUopcode[0]? or_result:and_result):(ctrl_ALUopcode[0]? sub_result:add_result));
	assign overflow = ctrl_ALUopcode[2]? 1'b0:(ctrl_ALUopcode[1]? 1'b0:(ctrl_ALUopcode[0]? sub_of:add_of));
	
	//isNotEqual
	assign isNotEqual = ctrl_ALUopcode[2]? 1'b0:(ctrl_ALUopcode[1]? 1'b0:(ctrl_ALUopcode[0]? sub_isNotEqual:1'b0));
	
	//isLessThan
	assign isLessThan = ctrl_ALUopcode[2]? 1'b0:(ctrl_ALUopcode[1]? 1'b0:(ctrl_ALUopcode[0]? sub_isLessThan:1'b0));
endmodule

`timescale 1ns/1ps
`define CLK_PERIOD 20

module skeleton_tb();
	// inputs to the DUT are reg type
	reg clock, reset;
	
	// outputs from the DUT are wire type
	wire imem_clock, dmem_clock, processor_clock, regfile_clock;
	
	// instantiate the DUT
	
	skeleton skeleton_ut (clock, 
	reset, imem_clock, dmem_clock, processor_clock, regfile_clock);
	
	initial
	begin
		$display($time, " << Starting the simulation >>");
		clock = 1'b0; // at time 0
		
		reset = 1'b1;
		@(posedge clock);
		@(posedge clock);
		
		reset = 1'b0;
		
		
	end
	
	always 
		#10     clock = ~clock;


endmodule

`timescale 1 ns / 100 ps
module rca_tb();

	reg[15:0] a, b;
	reg cain;
	
	wire[15:0] s;
	wire caout;
	
	reg rca_clock;
	integer num_of_errors;
	
	rca test_rca(a, b, cain, s, caout);
	
	initial begin 
		$display($time, " simulation start");
		rca_clock = 1'b0;
		num_of_errors = 0;
		
		@(negedge rca_clock);
		a = 16'b0000000000000001;
		b = 16'b0000000000000010;
		cain = 1'b0;
		
		@(negedge rca_clock);
		if (s != 16'b0000000000000011 && caout != 1'b0) begin
				$display ("sum is %b and cout is %b Error: Expected 0000000000000011 for sum and 0 for cout", s, caout);
				
				num_of_errors = num_of_errors + 1;
				
		end
		
		@(negedge rca_clock);
		a = 16'b1000000000000001;
		b = 16'b1000000000000010;
		cain = 1'b0;
		
		@(negedge rca_clock);
		if (s != 16'b0000000000000011 && caout != 1'b1) begin
				$display ("sum is %b and cout is %b Error: Expected 0000000000000011 for sum and 1 for cout", s, caout);
				
				num_of_errors = num_of_errors + 1;
				
		end
		
		@(negedge rca_clock);
		a = 16'b0000000000000000;
		b = 16'b0000000000000010;
		cain = 1'b1;
		
		@(negedge rca_clock);
		if (s != 16'b0000000000000011 && caout != 1'b0) begin
				$display ("sum is %b and cout is %b Error: Expected 0000000000000011 for sum and 0 for cout", s, caout);
				
				num_of_errors = num_of_errors + 1;
				
		end
		
		
	
		
		
		if (num_of_errors == 0) begin
				$display("Simulation succeeded with no errors.");
		end else begin
				$display("Simulation failed with %d error(s).", num_of_errors);
		end
		
		$stop;
	end
	
	always
			#10 rca_clock = ~rca_clock;
			
endmodule
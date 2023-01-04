module clock_divider(out_clock, clock, reset);
	input clock;
	input reset;
	output out_clock;
 
	reg [2:0] r_reg;
	wire [2:0] r_nxt;
	reg clk_track;
 
	always @(posedge clock or posedge reset)
	
	begin
		if (reset) begin
			r_reg <= 3'b0;
			clk_track <= 1'b0;
     end
 
		else if (r_nxt == 2'b10) begin
	     r_reg <= 0;
	     clk_track <= ~clk_track;
	   end
 
     else 
       r_reg <= r_nxt;
   end
 
 assign r_nxt = r_reg+1;   	      
 assign out_clock = clk_track;

endmodule
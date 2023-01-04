`timescale 1 ns / 100 ps
module pc_controller_tb();

    reg clock, reset, ctrl_branch, ctrl_jump;
    reg [11:0] data_in;
	 reg [31:0] abs_address, offset;

    wire [11:0] ra_out, data_out;

    integer errors;

    pc_controller test_pc_controller(data_out, ra_out, data_in, clock, reset,
	abs_address, offset, ctrl_branch, ctrl_jump);

    initial begin
        $display($time, " << Starting the Simulation >>");
        clock = 1'b0;    // at time 0
        errors = 0;

        reset = 1'b1;    // assert reset
        @(posedge clock);    // wait until next negative edge of clock

        reset = 1'b0;    // de-assert reset
        @(posedge clock);    // wait until next negative edge of clock
		  writeAddress(12'h0);
		  
		  @(posedge clock)
		  readAddress(12'h1, 12'h1);

		  @(posedge clock);
		  readAddress(12'h2, 12'h2);
		  
		  @(posedge clock);
		  readAddress(12'h3, 12'h3);
		  
		  @(posedge clock);
		  readAddress(12'h4, 12'h4);
		  
		  //On the next positive edge, intiate a branch instruction 
		  @(posedge clock);
		  ctrl_branch = 1'b1;
		  offset = 32'h3;
		  
		  //At Pc 4, branch by offset 3 => 4 + 1 + 3 = 8
		  //return address stays at PC + 1 == PC 4 + 1 = 5
		  @(posedge clock);
		  readAddress(12'h8, 12'h5);
		  ctrl_branch = 1'b0;
		  
		  //return address == PC 8 + 1 = 9
		  @(posedge clock);
		  readAddress(12'h9, 12'h9);
		  
		  @(posedge clock);
		  ctrl_branch = 1'b1;
		  offset = 32'h5;
		  
		  @(posedge clock);
		  readAddress(12'h15, 12'h10);
		  ctrl_branch = 1'b0;
		  
		  @(posedge clock);
		  ctrl_jump = 1'b1;
		  abs_address = 32'h1E;
		  
		  @(posedge clock);
		  readAddress(12'h1E, 12'h10);
		  
		 
		  
        if (errors == 0) begin
            $display("The simulation completed without errors");
        end
        else begin
            $display("The simulation failed with %d errors", errors);
        end

        $stop;
    end



    // Clock generator
    always
         #10     clock = ~clock;    // toggle

    // Task for writing
    task writeAddress;
        input [11:0] value;

        begin
            @(posedge clock);    // wait for next posedge of clock
            $display($time, " << current address to pc reg %h >>", value);

            data_in = value;

        end
    endtask

    // Task for reading
    task readAddress;
        input [11:0] exp;
		  input [11:0] exp_ra;

        begin				
            @(posedge clock); // wait for next posedge, read should be done
				
            if(data_out !== exp) begin
                $display("**Error on data out: read %h but expected %h.", data_out, exp);
                errors = errors + 1;
            end
				else if(ra_out !== exp_ra) begin
                $display("**Error on ra out: read %h but expected %h.", ra_out, exp);
                errors = errors + 1;
            end
				
				
				@(posedge clock);
				data_in = exp;
        end
    endtask
endmodule
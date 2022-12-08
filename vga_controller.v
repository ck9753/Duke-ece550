module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data,
							 up,
							 reset,
							 start);

	
input iRST_n;
input iVGA_CLK;
input up, reset, start;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;                        
///////// ////                     
reg [18:0] ADDR;
reg [23:0] bgr_data;
reg trigger, start_helper;
wire VGA_CLK_n;
wire [7:0] index;
wire [23:0] bgr_data_raw;
wire cBLANK_n,cHS,cVS,rst;
////
assign rst = ~iRST_n;
video_sync_generator LTM_ins (.vga_clk(iVGA_CLK),
                              .reset(rst),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS));
////
////Addresss generator
always@(posedge iVGA_CLK,negedge iRST_n)
begin
  if (!iRST_n)
     ADDR<=19'd0;
  else if (cHS==1'b0 && cVS==1'b0)
     ADDR<=19'd0;
  else if (cBLANK_n==1'b1)
     ADDR<=ADDR+1;
end
//////////////////////////
//////INDEX addr.
assign VGA_CLK_n = ~iVGA_CLK;
img_data	img_data_inst (
	.address ( ADDR ),
	.clock ( VGA_CLK_n ),
	.q ( index )
	);
	
/////////////////////////

///counter block
reg[31:0] counter;
initial begin
counter <= 32'd0;
end

//////Add switch-input logic here
reg [9:0] x, x_pipe, x_pipe2, ADDRx;
reg [8:0] y, y_pipe, y_pipe2, ADDRy;
reg [1:0] score;

initial begin
 x <= 10'd100;
 y <= 9'd240;
 x_pipe <= 10'd590;
 y_pipe <= 9'd150;
 score <= 2'd0;

// x_pipe2 <= 10'd640;
// y_pipe2 <= 9'd200;
 trigger <= 0;
 start_helper <= 1;
 end

always@(posedge iVGA_CLK)
begin
	if (!start && start_helper) begin
		trigger <= 1;
		start_helper <=0;
	end
	if (!reset) begin
		x <= 10'd100;
		y <= 9'd240;
		x_pipe <= 10'd590;
		y_pipe <= 9'd150;
		trigger <= 0;
		start_helper <= 1;
		score <= 2'd0;
	end
	
	if (trigger) begin
	counter <= counter + 1; 
   if(counter % 32'd250000 == 0)begin	  
//	 if(x < 10'd610 && x > 10'd0)	  
//    x<=x + right - left;  //x
//	 else if (x == 10'd610)
//	 x<=x - left;
//	 else if(x == 0)
//	 x<= x + right;

//		if(x_pipe <= 10'd320)begin
//		x_pipe2 <= x_pipe2 - 1;
//		end
		x_pipe <= x_pipe - 1;
		if (x_pipe-30 <= x && x_pipe + 50 >= x) begin
			if (y_pipe > y ||  y_pipe + 180 - 30 < y) begin // gap: 180, bird height: 30
//					x <= 10'd100;
//					y <= 9'd240;
//					x_pipe <= 10'd590;
//					y_pipe <= 9'd150;
					trigger <= 0;
			end
		end
		
		// the case when the pipe passed the bird
		if (x_pipe + 50 < x) begin
			score <= score + 1;
		end
		
		if (y >= 9'd450 || y <= 0)begin
//				x <= 10'd100;
//				y <= 9'd240;
//				x_pipe <= 10'd590;
//				y_pipe <= 9'd150;
				trigger <= 0;	 //lose
	   end
	  
		
	 if(y < 9'd450 && y > 9'd0) begin
		y <= y - 4; // falling down
	 end
	 if (up) begin
		y <= y + 1;
	 end
	 
	  
	 end
	 end
	//counter <= counter + 1;	
//	if(x < 10'd610 || right != 1'b1) 
//   x<=x + right;
//	if(x >= 10'd0 || left != 1'b1) 
//   x<=x - left;
//	if(y >= 9'd0 || up != 1'b1) 
//   y<=y - up; 
//	if(y < 9'd450 || down != 1'b1) 
//   y<=y + down;
//	else if(counter % 32'd25000 == 0 && x <= 10'd640 && x >=10'd0 && y >= 9'd0 && y <= 9'd480)begin	  
//   //if(x < 10'd640 && x >10'd0 && y > 9'd0 && y < 9'd480)begin	  
//     x<=x + right - left;  //x
//	  y<=y + up - down;	  //y
//	  end
	//counter <= counter + 1;	
	
end
	

	
//////Color table output
img_index	img_index_inst (
	.address ( index ),
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw)
	);	
//////


//////latch valid data at falling edge;
always@(posedge iVGA_CLK)begin
//convert_addr convert1(ADDR, ADDRx, ADDRy);
	ADDRx <= ADDR % 19'd640;
	ADDRy <= ADDR / 19'd640;
end

always@(posedge VGA_CLK_n) begin
	// score
	if(score >= 2'd1 && ADDRx >= 20 && ADDRx < 30 && ADDRy < 30 && ADDRy > 20) begin
		bgr_data <= 24'h6A0DAD;
	end
	
//	if (score >= 2'd2) begin
//		if(ADDRx >= 20 && ADDRx < 30 && (ADDRy < 60 && ADDRy > 50)) begin
//				bgr_data <= 24'h6A0DAD;
//		end
//	end
//	
//	if (score >= 2'd3) begin
//		if(ADDRx >= 20 && ADDRx < 30 && (ADDRy < 90 && ADDRy > 80)) begin
//				bgr_data <= 24'h6A0DAD;
//		end
//	end
//	

	
	// bird (block)
	else if(ADDRx >= x && ADDRx < x + 30 && ADDRy < y + 30 && ADDRy > y)begin
		bgr_data <= 24'h6A0DAD;
	end
	
		// exclamation mark gan tan hao
	else if(!start_helper && !trigger && ADDRx >= 295 && ADDRx < 345 && ((ADDRy < 300 && ADDRy > 50) || (ADDRy < 430 && ADDRy > 380))) begin
		bgr_data <= 24'h000ABC;
	end
	
	// first pipe
	else if(ADDRx >= x_pipe && ADDRx < x_pipe + 50 && ((ADDRy < y_pipe && ADDRy > 0) || (ADDRy < 480 && ADDRy > y_pipe + 180))) begin
		bgr_data <= 24'hFFFF00;
	end
	
	
//	
//	// second pipe
//	else if(ADDRx >= x_pipe2 && ADDRx < x_pipe2 + 50 && ((ADDRy < y_pipe2 && ADDRy > 0) || (ADDRy < 480 && ADDRy > y_pipe2 + 180))) begin
//		bgr_data <= 24'hFFFF00;
//	end 
	// background
	else begin
		bgr_data <= bgr_data_raw;
	end
end

assign b_data = bgr_data[23:16];
assign g_data = bgr_data[15:8];
assign r_data = bgr_data[7:0]; 
///////////////////
//////Delay the iHD, iVD,iDEN for one clock cycle;
always@(negedge iVGA_CLK)
begin
  oHS<=cHS;
  oVS<=cVS;
  oBLANK_n<=cBLANK_n;
end

endmodule
 	
















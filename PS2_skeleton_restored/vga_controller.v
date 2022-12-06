module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
							 right,
							 left,
							 up,
							 down,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data);

	
input iRST_n;
input iVGA_CLK;
input right, left, up, down;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;                        
///////// ////                     
reg [18:0] ADDR;
reg [23:0] bgr_data;
reg [18:0] x_cor;
reg [18:0] y_cor;
reg [18:0] refX;
reg [18:0] refY;
reg [30:0] counter;
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
  if (!iRST_n) begin
     ADDR<=19'd0;
	  //refX <= 19'd0;
	  //refY <= 19'd0;
  end
  else if (cHS==1'b0 && cVS==1'b0) begin
     ADDR<=19'd0;
  end
  else if (cBLANK_n==1'b1) begin
     ADDR<=ADDR+1;
  end
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
//////Add switch-input logic here
always@(posedge iVGA_CLK) 
begin
	x_cor = ADDR/19'd640;
	y_cor = ADDR%19'd640;
	if ((x_cor < refX + 20 && x_cor > refX) && (y_cor < refY + 20 && y_cor > refY)) begin
		bgr_data <= 24'hFFC0CB;
		
	//(ADDR < y_cor && ADDR > refY)
	end
	
	else begin
		bgr_data <= bgr_data_raw;
	end
end

//initial 
//begin  
//	counter <= 30'd0;
//	//refX <= 19'd0;
//	//refY <= 19'd0;
//end

always@(posedge iVGA_CLK,negedge iRST_n)
begin
	if (!iRST_n) begin
	  counter <= 30'd0;
	  refX <= 19'd0;
	  refY <= 19'd0;

  end
	
  else if (counter == 30'd200000) begin
    
	if (right == 1'b1 && refX < 480 - 20) begin
		refX <= refX + 1;
		
	end
	
	else if (left == 1'b1 && refX > 0) begin
		refX <= refX - 1;
		
	end
	
	else if (up == 1'b1 && refY > 0 ) begin
		refY <= refY - 1;
		
	end
	
	else if (down == 1'b1 && refY < 640 -20) begin
		refY <= refY + 1;
		
	end
	
		counter <= 30'd0;
  end
	
	else begin
		$display("otherwise %d", counter);
		counter <= counter + 1;
	end
end

//
//always@(posedge iVGA_CLK)
//begin
//
//  counter <= counter + 1;
//	//counter <= counter + 1;
//	refX <= 19'd0;
//	refY <= 19'd0;
//
//	if (counter == 30'd20000) begin
//
//		if (right == 1'b1) begin
//			refX <= refX + 1;
//			
//		end
//		
//		else if (left == 1'b1) begin
//			refX <= refX - 1;
//		end
//		
//		else if (up == 1'b1) begin
//			refY <= refY + 1;
//		end
//		
//		else if (down == 1'b1) begin
//			refY <= refY - 1;
//		end
//		counter <= 30'd0;
//	
//	end
//	
//end

	
	
//////Color table output
img_index	img_index_inst (
	.address ( index ),
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw)
	);	
//////
//////latch valid data at falling edge;
//always@(posedge VGA_CLK_n)
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
 	
















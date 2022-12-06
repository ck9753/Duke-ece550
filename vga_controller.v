module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data,
							 up,down,left,right);

	
input iRST_n;
input iVGA_CLK;
input up,down,left,right;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;                        
///////// ////                     
reg [18:0] ADDR;
reg [23:0] bgr_data;
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
reg [9:0] x,ADDRx;
reg [8:0] y, ADDRy;
initial begin
 x <= 10'd0;
 y <= 9'd0;
 end

always@(posedge iVGA_CLK)
begin

	counter <= counter + 1; 
   if(counter % 32'd25000 == 0)begin	  
	 if(x < 10'd610 && x > 10'd0)	  
    x<=x + right - left;  //x
	 else if (x == 10'd610)
	 x<=x - left;
	 else if(x == 0)
	 x<= x + right;
	 if(y < 9'd450 && y > 9'd0)	  
    y<=y - up + down;  //x
	 else if (y == 9'd450)
	 y<=y - up;
	 else if(y == 0)
	 y<= y + down;
	
	  
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

	if(ADDRx >= x && ADDRx < x + 30 && ADDRy < y + 30 && ADDRy > y)begin
		bgr_data <= 24'h000ABC;
	end
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
 	
















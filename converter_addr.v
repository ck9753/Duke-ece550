module convert_addr(ADDR, x, y);
input [19:0] ADDR;
output [9:0] x;
output [8:0] y;

assign x = ADDR % 10'd640;
assign y = ADDR / 9'd640;

endmodule

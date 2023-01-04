module CSA(a, b, cin, sum, cout, of);
	input [31:0] a, b;
	input cin;
	
	output [31:0] sum;
	output cout, of;
	
	wire [15:0] sum2, sum3;
	
	rca rca0(a[15:0], b[15:0], cin, sum[15:0], c15);
	
	rca rca1(a[31:16], b[31:16], 1'b0, sum2[15:0], c31_1);
	rca rca2(a[31:16], b[31:16], 1'b1, sum3[15:0], c31_2);
	
	assign sum[31:16] = c15 ? sum3[15:0]:sum2[15:0];
	assign cout = c15 ? c31_2: c31_1;
	
	xor xor0(of_sub1, a[31], b[31]); // 0 if a[31] = b[31] , both MSB are same
	xor xor1(of_sub2, sum[31], a[31]); // 1 if a[31] != sum[31]
	assign of = of_sub1? 1'b0:(of_sub2? 1'b1:1'b0);

endmodule
	
	
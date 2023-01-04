module cla(x, y, c0, s, cout, of);
		input [31:0] x, y;
		input c0;
		
		output[31:0] s;
		output cout, of;
		
		wire P0c0;
		wire P1G0, P1P0c0;
		wire P2G1, P2P1G0, P2P1P0c0;
		wire P3G2, P3P2G1, P3P2P1G0, P3P2P1P0c0;
		
		wire c8, c16, c24;
		wire c7, c15, c23, c31;
		
		// get components for c8-c32
		and and0(P0c0, P0, c0);
		and and1(P1G0, P1, G0);
		and and2(P1P0c0, P1, P0c0);
		and and3(P2G1, P2, G1);
		and and4(P2P1G0, P2, P1G0);
		and and5(P2P1P0c0, P2, P1P0c0);
		and and6(P3G2, P3, G2);
		and and7(P3P2G1, P3, P2G1);
		and and8(P3P2P1G0, P3, P2P1G0);
		and and9(P3P2P1P0c0, P3, P2P1P0c0); 
		
		
		// c8, c16, c24, c32
		or or0(c8, G0, P0c0);
		or or1(c16, G1, P1G0, P1P0c0);
		or or2(c24, G2, P2G1, P2P1G0, P2P1P0c0);
		or or3(cout, G3, P3G2, P3P2G1, P3P2P1G0, P3P2P1P0c0);
		
		
		block block0(x[7:0], y[7:0], c0, G0, P0, s[7:0], c7);
		block block1(x[15:8], y[15:8], c8, G1, P1, s[15:8], c15);
		block block2(x[23:16], y[23:16], c16, G2, P2, s[23:16], c23);
		block block3(x[31:24], y[31:24], c24, G3, P3, s[31:24], c31);
		
		xor xor0 (of, cout, c31);
		
endmodule

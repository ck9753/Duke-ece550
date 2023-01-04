module full_adder(in1, in2, cin, sum, cout);
	input in1, in2, cin;
	
	//final outputs
	output cout, sum;
	
	//intermediate outputs of the gates
	wire wireX, wireY, wireZ;
	
	xor xor1(wireX, in1, in2);
	and and1(wireY, wireX, cin);
	and and2(wireZ, in1, in2);
	
	xor xor2(sum, wireX, cin);
	or or1(cout, wireY, wireZ);
	
endmodule
	
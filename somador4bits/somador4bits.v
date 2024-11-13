module somador4bits(input  [3:0]A,B,	 
						  output [3:0]S,
						  output C4			);

	wire C1,C2,C3;
	
	full_adder FA1(.A(A[0]),
						.B(B[0]),
						.Cin(1'b0),
						.S(S[0]),
						.Cout(C1)
					   );
						
	// full_adder FA1(A[0],B[0],1'b0,,C1,S[0]);
	
	full_adder FA2(.A(A[1]),
						.B(B[1]),
						.Cin(C1),
						.S(S[1]),
						.Cout(C2)
					   );
	
		
	full_adder FA3(.A(A[2]),
						.B(B[2]),
						.Cin(C2),
						.S(S[2]),
						.Cout(C3)
					   );
						
	full_adder FA4(.A(A[3]),
						.B(B[3]),
						.Cin(C3),
						.S(S[3]),
						.Cout(C4)
					   );					
endmodule

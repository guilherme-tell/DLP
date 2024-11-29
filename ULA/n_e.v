module n_e (input [3:0]a,b,
			   output [3:0] out
			 );
			 
		assign out = ~(a & b);
	
endmodule
				
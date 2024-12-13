module orr (input signed [3:0]a,b,
			    output signed [3:0] out
			   );
			 
		assign out = a | b;
	
endmodule

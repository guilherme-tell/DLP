module nott (input signed [3:0]a,
			    output signed [3:0] out
			   );
			 
		assign out = ~a;
	
endmodule

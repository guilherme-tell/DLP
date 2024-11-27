module mymux (input [3:0] a,b,
				  input  [1:0] s, 
				  output [3:0] out );
				  
	assign out = (s == 1'b1) ? b : a;
	//									1   0
					
endmodule

module times (input [3:0]a,b,
							output [3:0] out
				);
				
				/*wire [7:0] out1 = a * b;
				
				assign out = out1[3:0];*/
				
				assign out = a*b;
endmodule
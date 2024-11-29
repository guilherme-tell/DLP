module times (input [3:0]a,b,
				  output [3:0] out,
				  output ov
				);
				
				/*wire [7:0] out1 = a * b;
				
				assign out = out1[3:0];*/
				
				wire [7:0] out1 = a * b;
				
				assign ov = (out1 > 5'd15) ? 1'b1 : 1'b0;
				
				assign out = out1;
endmodule
module sum (input signed[3:0]a,b,
				output  signed [3:0] out
				//output ov
				);
				
				wire [4:0] out1 = a + b;
				
				//assign ov = (out1 > 5'd15) ? 1'b1 : 1'b0;
				
				assign out = out1;
endmodule

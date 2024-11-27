module bigger (input [3:0]a,b,
					output [3:0] out
				);
				
				assign out = (a > b) ? 4'd1 : 4'd0;
						
endmodule

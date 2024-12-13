module shift_e ( input signed  [3:0] a,b,
					 output signed [3:0] out);

	assign out = b <<< a;
					
endmodule

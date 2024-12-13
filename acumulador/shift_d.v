module shift_d ( input signed [3:0] a,b,
					output signed [3:0] out);

	assign out = b >>> a;
					
endmodule

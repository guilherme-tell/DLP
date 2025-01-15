module comparador (  input [7:0] a,b,
							output y		);

assign y = (a == b) ? 1'b1 : 1'b0;
			
endmodule

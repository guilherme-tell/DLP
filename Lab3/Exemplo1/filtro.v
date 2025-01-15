module filtro (input 		clk, 
					input 		[15:0] x,
					output reg	[15:0] y); 				
				
	reg [15:0] x1, x2,x3;
	
	always @ (posedge clk) begin
	
	y <= x1 + x2+ x3;

// deslocamento dos buffers

	x3 <= x2;			// '=>' indica liações, nao faz diferença a ordem
	x2 <= x1;
	x1 <= x;

	end

endmodule

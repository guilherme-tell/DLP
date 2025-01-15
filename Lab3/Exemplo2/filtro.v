module filtro (input 		clk, 
					input 		[15:0] x,
					output 		[15:0] y); 				
				
//	reg [15:0] x1, x2,x3;
//	
//	always @ (posedge clk) begin
//	
//	y <= x1 + x2+ x3;
//
//// deslocamento dos buffers
//
//	x3 <= x2;			// '=>' indica liações, nao faz diferença a ordem
//	x2 <= x1;
//	x1 <= x;
//
//	end

//fir fir_int(.clk(clk), 
//				.reset(0),
//				.entrada(x),
//				.saida(y)
//				);

wire [31:0] Y_q2;
assign y[15:0] = Y_q2[31:16];

firQ fir_int (.clk(clk), 
				.reset(0),
				.entrada({x, 16'd0}),
				.saida(Y_q2)
				);

endmodule

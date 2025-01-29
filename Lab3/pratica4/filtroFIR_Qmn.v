module filtroFIR_Qmn (	input 		clk, 
								input 		[15:0] x,
								output 		[15:0] y); 		

wire [31:0] Y_q2;
assign y[15:0] = Y_q2[31:16];

firQ fir_int (.clk(clk), 
				.reset(0),
				.entrada({x, 16'd0}),
				.saida(Y_q2)
				);

endmodule

module top_level (input clk,
						//input reset,
						input signed [31:0] entrada,
						input amostra_pronta,
						output flag,
						output [8:0] cnt
						);
	wire [31:0] x;
	//assign x_filt = x;
					
	zero_cross  cruza_zero_hmm	(.clk(clk),
										 //.reset(reset),
										 .enable(amostra_pronta),
										 .x(x),
										 .flag(flag),
										 .cnt(cnt)
										);
						
	firQ fir_int (	.clk(clk), 
						//.reset(reset),
						.enable(amostra_pronta),
						.entrada({entrada, 16'd0}),
						.saida(x)
					 );
				
				
						
endmodule

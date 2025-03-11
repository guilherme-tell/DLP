module top_level (input clk,
						input signed [31:0] entrada,
						//output [31:0] x_filt,
						output flag,
						output [9:0] cnt
						);
	wire [31:0] x;
	//assign x_filt = x;
					
	zero_cross  cruza_zero_hmm	(.clk(clk),
										 .x(x),
										 .flag(flag),
										 .cnt(cnt)
										);
						
	firQ fir_int (	.clk(clk), 
						.reset(0),
						.entrada({entrada, 16'd0}),
						.saida(x)
					 );
				
				
						
endmodule

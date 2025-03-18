module top_level (input clk,
						input reset,
						input signed [31:0] entrada,
						input amostra_pronta,
						output flag,
						output reg ctrl,
						output reg [15:0] cnt
						);
	//wire [31:0] x;
	
	//reg ctrl;
	
	zero_cross  cruza_zero_hmm	(.clk(clk),
										 //.reset(reset),
										 .enable(amostra_pronta),
										 .x(entrada),
										 .flag(flag)

										);
										
	
	always @ (posedge clk) begin
	
	if(reset)begin
	
		if(flag) ctrl <= ~ctrl;
	
		if(ctrl) cnt <= cnt + 16'd1;
		
		else cnt <= 16'd0;
	
	end else begin 
					ctrl <= 1'b0;
					cnt <= 16'd0; 
				end
	end
	
	
		/*				
	firQ fir_int (	.clk(clk), 
						//.reset(reset),
						.enable(amostra_pronta),
						.entrada({entrada, 16'd0}),
						.saida(x)
					 );
				
		*/		
						
endmodule
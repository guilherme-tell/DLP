module top_level (input clk,
						input reset,
						input signed [11:0] entrada,
						input amostra_pronta,
						output flag,
						output reg ctrl,
						output reg [15:0] cnt,
						output reg [15:0] contagem_final,
						output [24:0] freq
						);
	//wire [31:0] x;
	
	//reg ctrl;
	
	zero_cross  cruza_zero     (.clk(clk),
										 .reset(reset),
										 .enable(amostra_pronta),
										 .x(entrada),
										 .flag(flag)

										);
										
	
	always @ (posedge clk) begin
	
	if(reset)begin
		
		if(flag) ctrl <= ~ctrl;
	
		if(ctrl) cnt <= cnt + 16'd1;
		
		else cnt <= 16'd0;
	

	end else  begin 
					ctrl <= 1'b0;
					cnt <= 16'd0; 
				end
	end
	
		always @ (negedge ctrl) begin
	
			if(reset) contagem_final <= cnt;
			
			else contagem_final <= 16'd0;
		
		end
	
	wire [24:0] contagem_ext;
	assign contagem_ext = contagem_final;
	
	assign freq = (contagem_ext == 25'd0) ? (25'd1)  : (25'd2000000 / contagem_ext);	
	
		/*				
	firQ fir_int (	.clk(clk), 
						//.reset(reset),
						.enable(amostra_pronta),
						.entrada({entrada, 16'd0}),
						.saida(x)
					 );
				
		*/		
						
endmodule
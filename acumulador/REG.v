module REG  ( input signed [3:0] in	,
				  input clk, clr_n, 
				  output reg signed [3:0] out );
				  
 always @ (posedge clk or negedge clr_n) begin
								

	if(clr_n == 1'b0)		// ativo baixo		
		out <= 4'd0;				
	else
		out <= in;

 end


endmodule
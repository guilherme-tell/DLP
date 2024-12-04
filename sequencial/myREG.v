module myREG( input [7:0] in	,
				  input clk, clr_n, // ativo em nivel logico baixo	
				  output reg [7:0] out );
				  
 always @ (posedge clk or negedge clr_n) begin
								// clear assincrono ativo baixo

	if(clr_n == 1'b0)				// nao precisa de begin end caso seja so uma linha
		out <= 8'd0;				
	else
		out <= in;

 end


endmodule

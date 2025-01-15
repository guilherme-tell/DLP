module acess_ctrl (	input clk, fechou,
							input [7:0] senha_digitada, 
							output resultado);

	
	reg [2:0] cnt = 1'b0;
	wire [7:0] senha_mem;
		
	always @ (posedge clk) begin
	
			if (resultado == 1'b0 )begin
				if (cnt < 3'd7) 
					cnt <= cnt + 3'b1;
				if (cnt > 3'd7 & fechou ==1) 
					cnt <= 0;	
			end
			
			if (resultado == 1'b1 )begin
				if (fechou == 1) 
					cnt <= 3'b0	;
			end
		end
	
						
	comparador comp ( .a(senha_mem),
							.b(senha_digitada),
							.y(resultado));							
	
	single_port_ROM ROM (	.clk(clk),
								   .addr(cnt),
								   .data_out(senha_mem)
							  );
							
endmodule

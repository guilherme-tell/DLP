module cont_mod_10 (input clk, clr_n, en,
						  output reg [3:0] cnt  );

	always @ (posedge clk or negedge clr_n) begin
	
		if(~clr_n)			
			cnt <= 4'd0;				
		else if(en) if (cnt < 4'd9)			// condicao enable e condicao para ser modulo 10
			cnt <= cnt + 4'd1;
		else 
			cnt <= 4'd0;
	end
						  
endmodule

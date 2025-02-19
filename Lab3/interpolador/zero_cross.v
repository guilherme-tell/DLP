module zero_cross # (N = 3)
						(input clk, enable,
						input signed [31:0] x,
						output reg [2**3:0] out
						);
	
	reg [2**3:0] cnt;
	reg flag = 1'b0; 
	reg signed [31:0] x_atual, x_anterior;
	
	always @ (posedge clk) begin
		x_atual <= x;
		
		if ((x_atual <= 0) & (x_anterior >= 0))
		begin
			flag = ~flag;
		end
	
		x_anterior <= x_atual;
	end
	
	always @ (posedge enable) begin		// enable de mudança de amostra
		
		if (flag) begin
				
				cnt = cnt + 1'b1;
				
			end else begin
				out = cnt;
				cnt <= 1'b0;
				end
	end
	
	
								
endmodule

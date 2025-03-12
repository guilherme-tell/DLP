module zero_cross 
						(input clk,
						//input reset,
						input enable,
						input signed [31:0] x,
						output reg flag,
						output reg [8:0] cnt
						);
	
	reg signed [31:0] x_anterior, x_atual;
	
	reg [8:0] atraso;
	
	
	
	always @ (posedge clk ) begin
	

		if (enable)begin 
	
			x_atual <= x;
			
			cnt <= atraso;
		
			if((x_atual[31] == 1) &(x_anterior[31] == 0)) begin
			
				flag <= 1'b1;
				atraso <= 9'd0;
				
			end else begin 
			
				atraso <= atraso + 9'd1;
				flag <= 1'b0;
				
				end
				
			x_anterior <= x_atual;
			
		end else begin
					cnt <= 9'd0;
					flag <= 1'b0;
				end
	end
								
endmodule

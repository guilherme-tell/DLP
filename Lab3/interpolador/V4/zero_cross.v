module zero_cross 
						(input clk,
						input reset,
						input enable,
						input signed [11:0] x,
						output reg flag
						);
	
	reg signed [11:0] x_anterior, x_atual;
	
	
	
	
	always @ (posedge clk ) begin
	

		if (enable)begin 
	
			x_atual <= x;
			
		
			if((x_atual[11] == 1) &(x_anterior[11] == 0)) begin
			
				flag <= 1'b1;
				
			end else begin 
			
				flag <= 1'b0;
				
				end
				
			x_anterior <= x_atual;
			
		end else begin
					flag <= 1'b0;
					end
	end
								
endmodule
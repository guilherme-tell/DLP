module zero_cross 
						(input clk,
						input reset,
						input signed [31:0] x,
						output reg flag,
						output reg [8:0] cnt
						);
	
	reg signed [31:0] x_anterior, x_atual;
	
	always @ (posedge clk) begin
	
	if(reset)begin
		cnt <= 9'd0;
		flag <= 1'b0;
		end else begin
	
			x_atual <= x;
		
			if((x_atual[31] == 1) &(x_anterior[31] == 0)) begin
			
				flag <= 1'b1;
				cnt <= 9'd0;
				
			end else begin 
			
				cnt <= cnt + 9'd1;
				flag <= 1'b0;
				
				end
				
			x_anterior <= x_atual;
			
		end
	end
								
endmodule

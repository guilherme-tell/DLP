module cont_10     (input clk, clr_n, en, up_d,
						  output reg [3:0] cnt,
						  output  TC  );			  
	
	assign TC = (((cnt == 4'd9) & up_d == 1'b1) | ((cnt == 4'd0)) & up_d == 1'b0) ? (1'b1) : (1'b0);
	
	always @ (negedge clk or negedge clr_n) begin
	
		if(~clr_n)			
			cnt <= 4'd0;				
		else if(en & up_d) begin 					
			if (cnt < 4'd9) 						
				cnt <= cnt + 4'd1;
				else 
					cnt <= 4'd0;
			end
			else if (en & ~up_d) begin 			
				if(cnt > 4'd0)	  					
					cnt <= cnt - 4'd1;	
					else 
						cnt <= 4'd9;
				end
					else 
					cnt <= 4'd0;	
	end
						  
endmodule

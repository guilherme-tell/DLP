module calc_freq (input clk,
						input zer0,
						input [8:0] cnt,
						output reg [24:0] freq
						);


always @ (posedge clk )begin
	if(zer0)begin
	
		//freq = 15'd125000 / cnt;
		
		freq = 15'd125000 / (cnt/16);
	
	end

end

endmodule
module PC  (
			  input clk, rst, ena, load,
			  input [3:0] PC_load,
			  output reg [3:0] PC_out 
			  );
	  
always @ (posedge clk or posedge rst)
begin
	if(rst)
		PC_out <= 4'd0;
	else
	begin
		if(ena)
		begin
			if(load)
				PC_out <= PC_load;
			else
				PC_out <= PC_out + 4'd1;
		end
	end
end

endmodule 
module mycnt #(
			parameter N = 0
			)
			(
			input clk, clr_n, ena,
			output reg [N-1:0] cnt
			);
			
always @ (posedge clk or negedge clr_n)
begin
	if(~clr_n)
		cnt <= 0;
	else
		if(ena)
			cnt <= cnt + 1;
end
			
endmodule 
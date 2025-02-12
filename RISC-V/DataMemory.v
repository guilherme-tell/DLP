module DataMemory #	(parameter addr_w=5)
							(input clk,WE,
							 input [addr_w-1:0] A,
							 input [31:0] WD,
							 output reg [31:0] RD);
		
	reg [31:0] mem [0:2**addr_w-1];
	
	always @ (posedge clk)begin
	
		if(WE)								
			mem [A] <=  WD;	
		else
			RD <= mem[A];
	end
							
endmodule

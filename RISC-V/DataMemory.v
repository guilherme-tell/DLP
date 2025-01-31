module DataMemory #	(parameter data_w=32, addr_w=5)
							(input clk,WE,
							 input [addr_w-1:0] A,
							 input [data_w-1:0] WD,
							 output reg [data_w-1:0] RD);
		
	reg [data_w-1:0] mem [0:2**addr_w-1];
	
	always @ (posedge clk)begin
	
		RD <= mem[A];
		
		if(WE)								
			mem [A] <=  WD;		
	end
							
endmodule

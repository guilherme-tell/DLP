module DataMemory #	(parameter addr_w=5)
							(input clk,WE,rst,
							 input [addr_w-1:0] A,
							 input [31:0] WD,
							 output reg [31:0] RD);
		
	reg [31:0] mem [0:2**addr_w-1];
	
	initial begin
	
		$readmemh("datamem_init.txt",mem);			

	end
	
	
	always @ (posedge clk or posedge rst)begin
	
	if(rst)begin
	
		RD <= 32'd0;
	
	end else begin
		if(WE)								
			mem [A] <=  WD;	
		else
			RD <= mem[A];
	end
	end
							
endmodule

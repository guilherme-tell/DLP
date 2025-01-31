module InstructionMemory #(parameter data_w = 32, addr_w = 5)
								  (input clk,
									input [addr_w-1:0] A,
									output reg [data_w-1:0] RD);

	reg [data_w-1:0] mem [0:2**addr_w-1];
	
	initial begin
	
		$readmemb("init.txt",mem);			

	end
	
	always @ (posedge clk)begin
	
		RD <= mem[A];
	
	end
									
									
endmodule

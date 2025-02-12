module InstructionMemory #(parameter  addr_w = 4)
								  (input clk,
									input [addr_w-1:0] A,
									output reg [31:0] RD);

	reg [31:0] mem [2**addr_w-1:0];
	
	initial begin
	
		$readmemh("programa.txt",mem);			

	end
	
	always @ (posedge clk)begin
	
		RD <= mem[A];
	
	end
									
									
endmodule

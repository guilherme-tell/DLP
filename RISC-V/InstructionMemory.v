module InstructionMemory #(parameter  addr_w = 4)
								  (input clk,rst,
									input [addr_w-1:0] A,
									output reg [31:0] RD);

	reg [31:0] mem [2**addr_w-1:0];
	
	initial begin
	
		$readmemh("programa.txt",mem);			

	end
	
	always @ (posedge clk or posedge rst)begin
	
	if(rst) begin
		RD <= 32'd0;
	end else begin
	
		RD <= mem[A];
	
	end
	end
									
									
endmodule

module RegisterFile
(
	input [31:0] WD3,
	input [4:0] A1, A2, A3,
	input WE3, clk,
	output reg [31:0] RD1, RD2
);


	reg [31:0] ram[31:0];

	initial begin
	
		$readmemh("regfile_init.txt",ram);			

	end
	

	always @ (posedge clk)
	begin
		if (WE3) 
			ram[A3] <= WD3;

		RD1 <= ram[A1];
		RD2 <= ram[A2];
	end 

endmodule

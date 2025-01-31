// Quartus II Verilog Template
// True Dual Port RAM with single clock

module RegisterFile
#(parameter DATA_WIDTH=32, ADDR_WIDTH=5)
(
	input [(DATA_WIDTH-1):0] WD3,
	input [(ADDR_WIDTH-1):0] A1, A2, A3,
	input WE3, clk,
	output reg [(DATA_WIDTH-1):0] RD1, RD2
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Port A 
	always @ (posedge clk)
	begin
		if (WE3) 
			ram[A3] <= WD3;
		else 
			RD1 <= ram[A1];
	end 

	// Port B 
	always @ (posedge clk)
	begin
		if (~WE3) 
			RD2 <= ram[A2];
	end

endmodule

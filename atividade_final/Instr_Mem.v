module Instr_Mem
#(parameter ADDR_WIDTH=4)
(
	input [(ADDR_WIDTH-1):0] A,
	input clk,
	output [31:0] RD
);

	reg [31:0] rom[2**ADDR_WIDTH-1:0];

	initial
	begin
		$readmemh("programa.txt", rom);
	end

	assign RD = rom[A];

endmodule

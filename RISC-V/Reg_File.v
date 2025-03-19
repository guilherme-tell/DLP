module Reg_File
(
	input [31:0] WD3,
	input [4:0] A1, A2, A3,
	input clk, WE3,
	output [31:0] RD1, RD2
);

reg [31:0] ram[2**5 -1:0];

initial
begin
	$readmemh("regfile_init.txt", ram);
end

always @ (posedge clk)
begin
	if(WE3)
		ram[A3] <= WD3;
end

assign RD1 = ram[A1];
assign RD2 = ram[A2];

endmodule

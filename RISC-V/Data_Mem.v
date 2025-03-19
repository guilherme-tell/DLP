module Data_Mem 
#(parameter ADDR_WIDTH=4)
(
	input [31:0] WD,
	input [(ADDR_WIDTH-1):0] A,
	input we, clk,
	output [31:0] RD
);

reg [31:0] ram[2**ADDR_WIDTH-1:0];

initial
begin
	$readmemh("datamem_init.txt", ram);
end

always @ (posedge clk)
begin
	if (we)
		ram[A] <= WD;			
end

assign RD = ram[A];
endmodule

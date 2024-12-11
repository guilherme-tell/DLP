`timescale 1ns/10ps 

module mycnttb();

parameter N = 4;

reg clk, clr_n, ena;
wire [N-1:0] cnt;

initial 
fork
	clr_n = 1'b0;
	ena = 1'b1;
	clk = 1'b0;
	
	#100 clr_n = 1'd1;
	#1000 ena = 1'b0;
	#1100 ena = 1'b1;
	#1500 clr_n = 1'b0;
	#1600	clr_n = 1'b1;
	
	forever 
	#10 clk = ~clk;


join

mycnt #(.N(N)) DUT
						(
							.clk(clk),
							.clr_n(clr_n),
							.ena(ena),
							.cnt(cnt)
						);

endmodule

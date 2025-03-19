`timescale 1ns/10ps // Escala de 
module tb();

wire signed[31:0] ALUResult,OUT;
reg clk, rst;
reg signed [31:0] IN = 32'd20;

initial
fork
	clk = 1'b0;
	rst = 1'b1;
	
	#100 rst = 1'b0;
	
	#120 IN = 32'd25;
	
	#140 IN = 32'd15;
	
	#160 IN = 32'd40;
	
	forever #10 clk = ~clk;
join

SC_RISCV SC_RISCV  ( 
						 .INPUT(IN),
						 .clk(clk), 
						 .rst(rst),
						 .ALUResult(ALUResult),
						 .OUTPUT(OUT)
						 );

endmodule 
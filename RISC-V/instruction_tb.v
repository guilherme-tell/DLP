`timescale 1ns/10ps 
module instruction_tb ();

	reg clk,rst;
	//wire [31:0] Inst;
	wire signed [31:0] ALUResult;


	initial fork
		clk = 1'b0;
		rst = 1'b1;
		
		#100 rst = 1'b0;
		
		forever #10 clk = ~clk;
	join

	SC_RISCV riscv( .clk(clk),
						 .rst(rst),
						 .ImmSRC(1'b10),
						 .ALUSrc(1'b0),
						 .ResultSrc(1'b0),
						 .ALUResult(ALUResult)
				      );


endmodule

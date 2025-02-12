`timescale 1ns/10ps 
module instruction_tb ();

	reg clk,rst;
	wire [31:0] Inst;


	initial fork
		clk = 1'b0;
		rst = 1'b1;
		
		#100 rst = 1'b0;
		
		forever #10 clk = ~clk;
	join

	SC_RISCV riscv( .clk(clk),
						 .rst(rst),
						 .Inst(Inst)
				      );


endmodule

module SC_RISCV (input clk,rst,
					  output [31:0] Inst);

	wire [3:0] PC_out;

	ProgramCounter PC( .clk(clk), 
						    .clr_n(rst), 
						    .load_en(1'b0),
						    .ena(1'b1),
                      .PC_load(4'd0),
					       .PC_out(PC_out)
							);
							
	InstructionMemory #( .addr_w (4)) Inst_Mem
							 ( .clk(clk),
								.A(PC_out),
								.RD(Inst)
							  );


endmodule

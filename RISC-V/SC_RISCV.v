module SC_RISCV (input clk,rst,
					  output signed [31:0] ALUResult);

	wire [3:0] PC_out;

	ProgramCounter PC( .clk(clk), 
						    .clr_n(rst), 
						    .load_en(1'b0),
						    .ena(1'b1),
                      .PC_load(4'd0),
					       .PC_out(PC_out)
							);
							
		wire [31:0] Inst;
	
	InstructionMemory #( .addr_w (4)) Inst_Mem
							 ( .clk(clk),
								.A(PC_out),
								.RD(Inst)
							  );

	wire signed [11:0] Imm;
	wire signed [31:0] ImmExt;
	wire signed [31:0] RD1;
										// extensão do sinal de 12 para 32 bits
										
	wire signed [31:0] ReadData;	
		
	assign Imm = Inst[31:20];
	assign ImmExt = Imm;
	
	RegisterFile RegFile (  .WD3(ReadData),
									.A1(Inst[19:15]),
									.A2(), 
									.A3(Inst[11:7]),
									.WE3(1'b1), 
									.clk(clk),
									.RD1(RD1),
									.RD2()
								);					
 
 ALU ALU ( .SrcA(RD1),
			  .SrcB(ImmExt),
			  .ALUCOntrol(3'b000),
			  .ALUResult(ALUResult) 
			 );
			 
DataMemory #(  .addr_w(5))  Data_Mem
				(  .clk(clk),
					.WE(1'b0),
					.A(ALUResult[4:0]),					// truncado pq a memoria tem so 32 bits
					.WD(),
					.RD(ReadData)
				);

endmodule

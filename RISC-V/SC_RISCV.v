module SC_RISCV (input clk,rst,ALUSrc,ResultSrc,
					  input [1:0] ImmSRC,
					  output signed [31:0] ALUResult);

	wire [3:0] PC_out;
	wire zero;
	
	wire[31:0] PC_Target;
	assign PC_target = Pc_out + ImmExt;	

	ProgramCounter PC( .clk(clk), 
						    .clr_n(rst), 
						    .load_en(1'b0),
						    .ena(1'b1),
                      .PC_load(PC_Target[3:0]),
					       .PC_out(PC_out)
							);
							
		wire [31:0] Inst;
	
	InstructionMemory #( .addr_w (4)) Inst_Mem
							 ( .clk(clk),
								.A(PC_out),
								.RD(Inst)
							  );

// extensão do sinal de 12 para 32 bits
//--------------------------------------------	
	wire signed [11:0] Imm_lw,Imm_sw,Imm_b;
	reg signed [31:0] ImmExt;
	
	assign Imm_lw = Inst[31:20];
	assign Imm_sw = {Inst[31:25],Inst[11:7]};		// concatena os 2 segmentos para formar o imediato de sw
	
	assign Imm_b = {Inst[31],Inst[7],Inst[30:25],Inst[11:8]};		// concatena os 4 segmentos de imediato p/ instrução do tipo B
	
	// mux para habilitar lw ou sw com sinal de controle SRC
	always @(*) begin
		case(ImmSRC)
			2'b00: ImmExt = Imm_lw;
			2'b01: ImmExt = Imm_sw;
			2'b10: ImmExt = Imm_b;
			2'b11: ImmExt = 32'd0;
		endcase		
	end

	//assign ImmExt = (ImmSRC == 1'b1) ? Imm_sw : Imm_lw;
//--------------------------------------------		

								
	wire signed [31:0] RD1,RD2,WD3;									
	wire signed [31:0] ReadData;	
		
	
	RegisterFile RegFile (  .WD3(WD3),
									.A1(Inst[19:15]),
									.A2(Inst[24:20]), 
									.A3(Inst[11:7]),
									.WE3(1'b1), 
									.clk(clk),
									.RD1(RD1),
									.RD2(RD2)
								);					
 
//--------------------------------------------	
	wire signed [31:0] SrcB;
	
	// mux para habilitar RD2 ou imediato extendido na entrada da ULA
	assign SrcB = (ALUSrc == 1'b0) ? RD2 : ImmExt; 
//--------------------------------------------	 
 
 ALU ALU ( .SrcA(RD1),
			  .SrcB(SrcB),
			  .ALUCOntrol(3'b011),
			  .ALUResult(ALUResult),
			  .Zero(zero) 
			 );
			 
//--------------------------------------------
	// mux para decidir se sera escrito no regfile o resultado da ULA ou o conteudo selecionado da DataMemory
	assign WD3 = (ResultSrc == 1'b0) ? ALUResult : ReadData; 
//--------------------------------------------			 
			 
DataMemory #(  .addr_w(5))  Data_Mem
				(  .clk(clk),
					.WE(1'b1),
					.A(ALUResult[4:0]),					// truncado pq a memoria tem so 32 bits
					.WD(RD2),
					.RD(ReadData)
				);

endmodule

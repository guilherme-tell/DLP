module SC_RISCV (input clk,rst,
					  output signed [31:0] ALUResult);

	wire [3:0] PC_out;
	wire zero;
	
	wire Rslt_source_w, Mem_write_w, ALU_source, REG_write_w, PCSrc_w;
	reg signed [31:0] ImmExt;
	wire[31:0] PC_target;
	assign PC_target = PC_out + ImmExt;	
	wire [3:0] PC_load_in;
	assign PC_load_in = (PCSrc_w == 1'b0) ? PC_out : PC_target[3:0]; 

	wire[2:0] ALU_ctrl_w;

	wire [1:0] Imm_source_w;
	
	wire [31:0] Inst;	
	
	// extensão do sinal de 12 para 32 bits
//--------------------------------------------	
	wire signed [11:0] Imm_lw,Imm_sw,Imm_b;

	assign Imm_lw = Inst[31:20];
	assign Imm_sw = {Inst[31:25],Inst[11:7]};		// concatena os 2 segmentos para formar o imediato de sw
	
	assign Imm_b = {Inst[31],Inst[7],Inst[30:25],Inst[11:8]};		// concatena os 4 segmentos de imediato p/ instrução do tipo B
	
	wire signed [31:0] RD1,RD2,WD3;									
	wire signed [31:0] ReadData;	
	
	ProgramCounter PC( .clk(clk), 
						    .clr_n(rst), 
						    .load_en(PCSrc_w),
						    .ena(1'b1),
                      .PC_load(PC_load_in),
					       .PC_out(PC_out)
							);
							

	
	InstructionMemory #( .addr_w (4)) Inst_Mem
							 ( .clk(clk),
								.rst(rst),
								.A(PC_out),
								.RD(Inst)
							  );


	
	// mux para habilitar lw ou sw com sinal de controle SRC
	always @(*) begin
		//case(ImmSRC)
		case(Imm_source_w)
			2'b00: ImmExt = Imm_lw;
			2'b01: ImmExt = Imm_sw;
			2'b10: ImmExt = Imm_b;
			2'b11: ImmExt = 32'd0;
		endcase		
	end

	//assign ImmExt = (ImmSRC == 1'b1) ? Imm_sw : Imm_lw;
//--------------------------------------------		

								

		
	
	RegisterFile RegFile (  .WD3(WD3),
									.rst(rst),
									.A1(Inst[19:15]),
									.A2(Inst[24:20]), 
									.A3(Inst[11:7]),
									//.WE3(1'b1), 
									.WE3(REG_write_w),
									.clk(clk),
									.RD1(RD1),
									.RD2(RD2)
								);					
 
//--------------------------------------------	
	wire signed [31:0] SrcB;
	
	// mux para habilitar RD2 ou imediato extendido na entrada da ULA
	//assign SrcB = (ALUSrc == 1'b0) ? RD2 : ImmExt; 
	  assign SrcB = (ALU_source == 1'b0) ? RD2 : ImmExt;
//--------------------------------------------	 
 
 ALU ALU ( .SrcA(RD1),
			  .SrcB(SrcB),
			  //.ALUCOntrol(3'b011),
			  .ALUCOntrol(ALU_ctrl_w),
			  .ALUResult(ALUResult),
			  .Zero(zero) 
			 );
			 
//--------------------------------------------
	// mux para decidir se sera escrito no regfile o resultado da ULA ou o conteudo selecionado da DataMemory
	assign WD3 = (Rslt_source_w == 1'b0) ? ALUResult : ReadData; 
//--------------------------------------------			 
			 
DataMemory #(  .addr_w(5))  Data_Mem
				(  .clk(clk),
					//.WE(1'b1),
					.WE(Mem_write_w),
					.rst(rst),
					.A(ALUResult[4:0]),					// truncado pq a memoria tem so 32 bits
					.WD(RD2),
					.RD(ReadData)
				);

//---------------------------------------------------------------------------

				
CTRL_unit Control_Unit(	.clk(clk), 
								.op(Inst[6:0]),
								.funct3(Inst[14:12]),
								.funct7(Inst[30]),
								.Zero(zero),
								.ALUControl(ALU_ctrl_w),
								.ResultSrc(Rslt_source_w),
								.ImmSrc(Imm_source_w),
								.MemWrite(Mem_write_w),
								.ALUSrc(ALU_source),
								.RegWrite(REG_write_w),
								.PCSrc(PCSrc_w)
						);

endmodule

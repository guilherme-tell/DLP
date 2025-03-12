module SC_RISCV(
					input clk, rst, 
					input signed [31:0] INPUT,
					output signed [31:0] ALUResult
					);

wire [3:0] PC_out;
wire [31:0] PC_Next;
wire [31:0] Instr;
wire Zero;
wire [6:0] op = Instr[6:0];
wire [2:0] funct3 = Instr[14:12];
wire funct7_5 = Instr[30];
wire PCSrc;
wire ResultSrc;
wire MemWrite;
wire ALUSrc;
wire [1:0] ImmSrc;
wire RegWrite;
wire [2:0] ALUControl;
wire signed [11:0] Imm_lw, Imm_sw, Imm_b;		
reg signed [31:0] ImmExt;
wire signed [31:0] RD1, RD2, WD3;
wire signed [31:0] ReadData;
wire signed [31:0] SrcB;
wire InputSRC;
wire signed [31:0] Result;


assign PC_Next = PC_out + ImmExt;

//---------------------------------------------------	
//	mux do input
//---------------------------------------------------	

assign WD3 = (InputSRC == 1'b1) ? INPUT : Result; 

//---------------------------------------------------	
					
PC PC (
		.clk(clk), 
		.rst(rst), 
		.ena(1'b1), 
		.load(PCSrc),
		.PC_load(PC_Next[3:0]),
		.PC_out(PC_out) 
	   );	



Instr_Mem #(.ADDR_WIDTH(4)) Instr_Mem
			  (
			  .A(PC_out),
			  .clk(clk), 
			  .RD(Instr)
			  );

// ImmExt
//---------------------------------------------------  


assign Imm_lw = Instr[31:20];
assign Imm_sw = {Instr[31:25] , Instr[11:7]};
assign Imm_b  = {Instr[31], Instr[7], Instr[30:25], Instr[11:8],1'b0};


always @ (*)
begin
	case(ImmSrc)
		2'b00: ImmExt = Imm_lw;
		2'b01: ImmExt = Imm_sw;
		2'b10: ImmExt = Imm_b;
		2'b11: ImmExt = 32'd0;
	endcase
		
end 

//---------------------------------------------------		 

assign Result = (ResultSrc == 1'b0) ? ALUResult	: ReadData; 
			 
Reg_File Reg_File (
						 .WD3(WD3),
						 .A1(Instr[19:15]), 
						 .A2(Instr[24:20]), 
						 .A3(Instr[11:7]),
						 .clk(clk), 
						 .WE3(RegWrite),
						 .RD1(RD1), 
						 .RD2(RD2)
						); 
						


assign SrcB = (ALUSrc == 1'b0) ? RD2 : ImmExt;						
						
ALU ALU ( 
			.SrcA(RD1), 
			.SrcB(SrcB),
			.ALUControl(ALUControl),
			.ALUResult(ALUResult),
			.Zero(Zero)
			);
			

Data_Mem #(.ADDR_WIDTH(5)) Data_Mem
			(
			.WD(RD2),
			.A(ALUResult[4:0]),
			.we(MemWrite), 
			.clk(clk),
			.RD(ReadData)
			);
			

			
				
ControlUnit ControlUnit(
						      .Zero(Zero),
						      .op(op),
						      .funct3(funct3),
						      .funct7_5(funct7_5),
						      .PCSrc(PCSrc),
						      .ResultSrc(ResultSrc),
						      .MemWrite(MemWrite),
						      .ALUSrc(ALUSrc),
						      .ImmSrc(ImmSrc),
						      .RegWrite(RegWrite),
						      .ALUControl(ALUControl),
								.InputSRC(InputSRC)
						     );
					
endmodule 
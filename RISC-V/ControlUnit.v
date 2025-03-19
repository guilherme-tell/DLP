module ControlUnit(
						input Zero,
						input [6:0] op,
						input [2:0] funct3,
						input funct7_5,
						output PCSrc,
						output reg ResultSrc,
						output reg MemWrite,
						output reg ALUSrc,
						output reg [1:0] ImmSrc,
						output reg RegWrite,
						output reg [2:0] ALUControl,
						output reg InputSRC,
						output reg OutputSRC
						);

reg Branch;
reg [1:0] ALUOp;

always @ (*)
begin
	case(op)
		7'b0000011: // lw
		begin
			RegWrite  = 1'b1;
			ImmSrc    = 2'b00;
			ALUSrc    = 1'b1;
			MemWrite  = 1'b0;
			ResultSrc = 1'b1;
			Branch    = 1'b0;
			ALUOp     = 2'b00;
			InputSRC  = (funct3 == 3'b111) ? 1'b1 : 1'b0;			// caso op seja d3 e funct3 seja d7
			OutputSRC = 1'b0;
		end
		7'b0100011: // sw
		begin
			RegWrite  = 1'b0;
			ImmSrc    = 2'b01;
			ALUSrc    = 1'b1;
			MemWrite  = funct3 == (3'b111) ? 1'b0 : 1'b1;			// nao escreve na memoria caso seja pra usar barramento OUTPUT
			ResultSrc = 1'bx;
			Branch    = 1'b0;
			ALUOp     = 2'b00;
			InputSRC	 = 1'b0;
			OutputSRC = (funct3 == 3'b111) ? 1'b1 : 1'b0;			// caso op seja d3 -> output <= RD2
		end
		7'b0110011: //R-Type
		begin
			RegWrite  = 1'b1;
			ImmSrc    = 2'bxx;
			ALUSrc    = 1'b0;
			MemWrite  = 1'b0;
			ResultSrc = 1'b0;
			Branch    = 1'b0;
			ALUOp     = 2'b10;
			InputSRC	 = 1'b0;
			OutputSRC = 1'b0;
		end
		7'b1100011: // beq
		begin
			RegWrite  = 1'b0;
			ImmSrc    = 2'b10;
			ALUSrc    = 1'b0;
			MemWrite  = 1'b0;
			ResultSrc = 1'bx;
			Branch    = 1'b1;
			ALUOp     = 2'b01;
			InputSRC	 = 1'b0;
			OutputSRC = 1'b0;
		end
		default:
		begin
			RegWrite  = 1'bx;
			ImmSrc    = 2'bxx;
			ALUSrc    = 1'bx;
			MemWrite  = 1'bx;
			ResultSrc = 1'bx;
			Branch    = 1'bx;
			ALUOp     = 2'bxx;
			InputSRC	 = 1'bx;
			OutputSRC = 1'bx;
		end
	endcase
end	

always @ (*)
begin
	case(ALUOp)
		2'b00:
		begin
			ALUControl = 3'b000;
		end
		2'b01:
		begin
			ALUControl = 3'b001;
		end
		2'b10:			// R-type
		begin
			case(funct3)
				3'b000:
				begin
					ALUControl = ({op[5],funct7_5} == 2'b11) ? 3'b001 : 3'b000;
				end
				3'b010:
				begin
					ALUControl = 3'b101;
				end
				3'b110:
				begin
					ALUControl = 3'b011;
				end
				3'b111:
				begin
					ALUControl = 3'b010;
				end
				3'b101:
				begin
					ALUControl = (funct7_5 == 1'b1) ? 3'b110 : 3'bxxx;		//shift aritmetico direita
				end
				default:
				begin
					ALUControl = 3'bxxx;
				end
			endcase
		end
		default:
		begin
			ALUControl = 3'bxxx;
		end
	
	endcase

end					

assign PCSrc = Branch & Zero;						

endmodule 
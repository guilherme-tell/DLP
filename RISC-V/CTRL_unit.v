module CTRL_unit( input clk,
						input [6:0] op,
						input [2:0] funct3,
						input funct7, Zero,
						output reg [2:0] ALUControl,
						output reg  [1:0] ImmSrc,
						output reg  MemWrite,ALUSrc,RegWrite,ResultSrc,
						output PCSrc
						
						);
	wire ALU_Decoder_in; 
	reg [1:0] ALUOp; 
	reg Branch;
	assign ALU_Decoder_in = {op[5], funct7};
	
	
//								Main Decoder
	always @(*) begin	
		
		
		case(op)
		7'b0000011:	begin									//lw
								RegWrite <= 1'b1;
								ImmSrc <= 2'b00;
								ALUSrc <= 1'b1;
								MemWrite <= 1'b0;
								ResultSrc <= 1'b1;
								Branch <= 1'b0;
								ALUOp <= 2'b00;
						end
						
		7'b0100011:	begin									//sw
								RegWrite <= 1'b0;
								ImmSrc <= 2'b01;
								ALUSrc <= 1'b1;
								MemWrite <= 1'b1;
								ResultSrc <= 1'bx;
								Branch <= 1'b0;
								ALUOp <= 2'b00;
						end
						
		7'b0110011:	begin									//R-Type
								RegWrite <= 1'b1;
								ImmSrc <= 2'bxx;								
								ALUSrc <= 1'b0;
								MemWrite <= 1'b0;
								ResultSrc <= 1'b0;
								Branch <= 1'b00;
								ALUOp <= 2'b10;
						end
						
		7'b1100011:	begin									//beq
								RegWrite <= 1'b0;
								ImmSrc <= 2'b10;
								ALUSrc <= 1'b0;
								MemWrite <= 1'b0;
								ResultSrc <= 1'bx;
								Branch <= 1'b1;
								ALUOp <= 2'b01;
						end
		default : begin
								RegWrite <= 1'bx;
								ImmSrc <= 2'bxx;
								ALUSrc <= 1'bx;
								MemWrite <= 1'bx;
								ResultSrc <= 1'bx;
								Branch <= 1'bx;
								ALUOp <= 2'bxx;
		
					 end
	
	endcase
	
	
	end
	
	assign PCSrc = (Branch & Zero);

//								ALU Decoder
	always @ (*) begin
	
	case(ALUOp)
	2'b00: ALUControl <= 3'b000;

	2'b01: ALUControl <= 3'b001;
	
	2'b10:	begin
					case(funct3)
					3'b000: ALUControl <= (ALU_Decoder_in == 2'b11) ? 3'b001: 3'b000;
					
					3'b010: ALUControl <= 3'b101;
					
					3'b110: ALUControl <= 3'b011;
					
					3'b111: ALUControl <= 3'b010;
					
					default : ALUControl <= 3'bxxx;
					endcase
				end
	default : ALUControl <= 3'bxxx;
	endcase
	end
	
						
endmodule


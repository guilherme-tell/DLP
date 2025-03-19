module ALU (
				input signed [31:0] SrcA, SrcB,
				input [2:0] ALUControl,
				output reg signed [31:0] ALUResult,
				output Zero
			  );

always @ (*)
begin
	case(ALUControl)
		3'b000: ALUResult = SrcA + SrcB;
		3'b001: ALUResult = SrcA - SrcB;
		3'b010: ALUResult = SrcA & SrcB;
		3'b011: ALUResult = SrcA |	SrcB;
		3'b101: ALUResult = SrcA < SrcB;
		3'b110: ALUResult = SrcA >>> SrcB;			// shift aritimetico direita
		default: ALUResult = 32'd0;
	endcase
end

assign Zero = (ALUResult == 32'd0);
endmodule 
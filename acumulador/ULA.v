module ULA( input signed [3:0] A,B,
		    input [3:0] op,
			output reg signed  [3:0] out);

    
always @ (*)begin
   case(op)
        4'd0 : out = A + B;
        4'd1 : out = B - A;
        4'd2 : out = A & B;
        4'd3 : out = A | B;
        4'd4 : out = A ^ B;
        4'd5 : out = ~ B;
        4'd6 : out = B <<< A;
        4'd7 : out = B >>> A;
        4'd8 : out = A;
        default: out = 4'd0;
	endcase
end


endmodule
module mux9 (	input signed [3:0] soma, sub, andd, orr, excl, nott, shift_e, shift_d , bufff,
					input [3:0] op,
					output reg  signed [3:0] out );
					
		always @ (*)begin
		
			case(op)
			4'd0 : out = soma;
			4'd1 : out = sub;
			4'd2 : out = andd;
			4'd3 : out = orr;
			4'd4 : out = excl;
			4'd5 : out = nott;
			4'd6 : out = shift_e;
			4'd7 : out = shift_d;
			4'd8 : out = bufff;
			default: out = 4'd0;
			endcase
		
		end
					
endmodule

module mux8 (	input [3:0] soma, sub, mult, div, igual, maior, menor, dif,
					input [2:0] op,
					output reg [3:0] out
				);
				
				always @(*)
				begin
					case(op)
					3'd0 : out = soma;
					3'd1 : out = sub;
					3'd2 : out = mult;
					3'd3 : out = div;
					3'd4 : out = igual;
					3'd5 : out = maior;
					3'd6 : out = menor;
					3'd7 : out = dif;
					endcase
				end
				
endmodule

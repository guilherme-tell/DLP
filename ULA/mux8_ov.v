module mux8 (	input [3:0] soma, sub, mult, div, igual, maior, menor, dif, e, n_e, ou, n_ou, excl, n_excl, n_a, n_b, 
					input ov_sum, ov_multi,
					input [3:0] op,
					output reg [3:0] out,
					output ov
				);
				
  assign ov = ((ov_sum | ov_multi) & (op == (4'd0; | 4'd2; )) ? 1'b1 : 1'b0;    // teste para overflow errado
							
				always @(*)
				begin
					case(op)
					4'd0 : out = soma;
					4'd1 : out = sub;
					4'd2 : out = mult;
					4'd3 : out = div;
					4'd4 : out = igual;
					4'd5 : out = maior;
					4'd6 : out = menor;
					4'd7 : out = dif;
					4'd8 : out = e;
					4'd9 : out = n_e;
					4'd10 : out = ou;
					4'd11 : out = n_ou;
					4'd12 : out = excl;
					4'd13 : out = n_excl;
 					4'd14 : out = n_a;
					4'd15 : out = n_b;
					endcase
				end
				
endmodule

module mymux4 ( input  a,b,c,d,
					 input  [1:0] s,
					 output reg out );		// sempre que estiver dentro de um always o out tem q ser reg;
	
/*	
	wire x0 = (s[0]) ? b : a;
	wire x1 = (s[0]) ? d : c;

	assign out = (s[1]) ? x1 : x0;	
*/

	always @(*) begin				// descricao de um circuito combinacional com always;
	
		case(s)	
			2'b00 : out = a;
			2'b01 : out = b;
			2'b10 : out = c;
			2'b11 : out = d;
		endcase	
	
	end
	
endmodule

module gerador_clk (input clr_n, clk,in,
					     output reg out);
/* moore
	
	reg [1:0] state;
	parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
	
	always @ (posedge clk or negedge clr_n) begin
		if (~clr_n)
			state <= S0;
		else 
			case (state)
				S0: 
					if (in)
						state <= S1;
				S1:
					state <= S2;
				S2:
					if(~in)
						state <= S0;
			default: state <= S0;
		endcase
	end

	always @ (state) begin
		case(state)
			
			S0: out <= 1'b0;
			S1: out <= 1'b1;
			S2: out <= 1'b0;
			default: out <= 1'b0;	
		endcase
	end
*/ 

/* meleay 
				gera glitch na saida, pq muda a entrada nao é sincrona com o clock
*/

	reg [1:0] state;
	parameter S0 = 2'b00, S1 = 2'b01;

	always @ (posedge clk or negedge clr_n) begin
		if (~clr_n)
			state <= S0;
		else 
			case (state)
				S0: 
					if (in)
						state <= S1;
				S1:
					if(~in)
					state <= S0;
			default: state <= S0;
		endcase
	end

	always @ (state or in) begin
		case(state)
			S0: out <= in;
			S1: out <= 1'b0;
			default: out <= 1'b0;	
		endcase
	end
	
endmodule

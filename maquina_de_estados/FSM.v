module FSM (input clk,clr_n,in,
				output reg [1:0] out);
							
	reg [1:0] state;
	parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
	
// Transição dos Estados

	always @(posedge clk or negedge clr_n)
	begin
		if(~clr_n)
			state <= S0;
			else 
				case(state)
					S0:
						state <= S1;
					S1:
						if(in)
							state <= S2;
						else 					// implicito
							state <= S1;
					S2:
						if(in)
							state <= S0;
					default : 
						state <= S0;
				endcase
	
	end

// Decodificação das Saídas

	always @ (state) // maquina de moore (depende apenas dos estados)
	begin
		case(state)
			S0: out <= 2'b01;
			S1: out <= 2'b10;
			S2: out <= 2'b11;
			default: out <= 2'b00;
		endcase
	end


endmodule

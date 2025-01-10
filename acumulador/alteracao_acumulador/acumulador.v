module acumulador (	input signed [3:0] A,
				   	input [8:0] in,
				   	input clk, clr_n, 
					output signed [3:0] out );

		wire signed [3:0] out_ula,out_reg;	
		wire [3:0] op;
        wire en;
		
		ULA ula (A, out_reg, op, out_ula);
		
		REG ACC (out_ula,clk,clr_n, en, out_reg);
		
		cod codificador (in,op);

        FSM gerador_enable (1, clk, |in, en);
		
		assign out = out_reg;
			 
endmodule
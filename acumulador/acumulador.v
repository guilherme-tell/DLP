module acumulador (input signed [3:0] A,op,
						 input clk, clr_n,
						 output signed [3:0] out );

		wire [3:0] out_ula,out_reg;	
		
		signed_ULA ula (A, out_reg, op, out_ula);
		
		REG ACC (out_ula,clk,clr_n, out);
		
		assign out = out_reg;
						 
endmodule

	
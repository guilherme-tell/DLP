module signed_ULA (input signed [3:0] A,B,
						 input [3:0] op,
						 output signed [3:0] out);
	
	wire [3:0] out_soma;
	sum somaULA(A, B, out_soma);
	
	wire [3:0] out_sub;
	sub subULA(A, B, out_sub);
	
	wire [3:0] out_and;
	andd andULA(A,B,out_and);
	
	wire [3:0] out_or;
	orr orULA(A,B,out_or);
	
	wire [3:0] out_xor;
	excl xorULA(A,B,out_xor);
	
	wire [3:0] out_not;
	nott not_aULA(B,out_not);
	
	wire [3:0] out_shift_E;
	shift_e shift_eULA (A,B, out_shift_E);
	
	wire [3:0] out_shift_D;
	shift_d shift_dULA (A,B, out_shift_D);
	
	wire [3:0] out_buff;
	carrg buffULA (A, out_buff);
	
	
	mux9 muxULA (	.soma(out_soma), 
						.sub(out_sub), 
						.andd(out_and), 
						.orr(out_or),
						.excl(out_xor),
						.nott(out_not),
						.shift_e(out_shift_E),
						.shift_d(out_shift_D),
						.bufff(out_buff),
						.op(op),
						.out(out)
					);
						 
endmodule

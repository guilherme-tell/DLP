module ula4 (	input [3:0] A, B,
					input [3:0] op,
					output [3:0] out,
					output ov		);

//SOMA
wire [3:0] out_soma;
wire ov1;
/*instancia por lista
	a ordem precisa ser a mesma*/
sum somaULA(A, B, out_soma, ov1);
//=================================

//SUBTRACAO
wire [3:0] out_sub;
minus subULA(A, B, out_sub);
//=================================

//MULTIPLICACAO
wire [3:0] out_mult;
wire ov2;
times multULA(A, B, out_mult, ov2);
//=================================

//DIVISAO
wire [3:0] out_div;
div divULA(A, B, out_div);
//=================================

//IGUALDADE
wire [3:0] out_eq;
equals eqULA(A, B, out_eq);
//=================================

//MAIOR
wire [3:0] out_maior;
bigger maiorULA(A, B, out_maior);
//=================================

//MENOR
wire [3:0] out_menor;
smaller menorULA(A, B, out_menor);
//=================================

//DIFERENTE
wire [3:0] out_dif;
diff difULA(A, B, out_dif);
//=================================

// AND
wire [3:0] out_and;
e andULA(A,B,out_and);
//=================================

// NAND
wire [3:0] out_nand;
n_e nandULA(A,B,out_nand);
//=================================

// OR
wire [3:0] out_or;
ou orULA(A,B,out_or);
//=================================

// NOR
wire [3:0] out_nor;
n_ou norULA(A,B,out_nor);
//=================================

// XOR
wire [3:0] out_xor;
excl xorULA(A,B,out_xor);
//=================================

// XOR
wire [3:0] out_xnor;
n_excl xnorULA(A,B,out_xnor);
//=================================

// NOT_A
wire [3:0] out_not_a;
n_a not_aULA(A,out_not_a);
//=================================

// NOT_B
wire [3:0] out_not_b;
n_b not_bULA(B,out_not_b);
//=================================

//MULTIPLEXADOR
/*Instancia por nome*/
mux8 muxULA(.soma(out_soma),
            .sub(out_sub),
            .mult(out_mult),
            .div(out_div), 
            .igual(out_eq), 
            .maior(out_maior),
            .menor(out_menor), 
            .dif(out_dif),
				.e(out_and),
				.n_e(out_nand),
				.ou(out_or),
				.n_ou(out_nor),
				.excl(out_xor),
				.n_excl(out_xnor),
				.n_a(out_not_a), 
				.n_b(out_not_b),
				.op(op),
				.ov_sum(ov1),
				.ov_multi(ov2),
				.ov(ov),
				.out(out));
				

	
endmodule

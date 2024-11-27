module ula4 (	input [3:0] A, B,
					input [2:0] op,
					output [3:0] out);

//SOMA
wire [3:0] out_soma;
/*instancia por lista
	a ordem precisa ser a mesma*/
sum somaULA(A, B, out_soma);
//=================================

//SUBTRACAO
wire [3:0] out_sub;
minus subULA(A, B, out_sub);
//=================================

//MULTIPLICACAO
wire [3:0] out_mult;
times multULA(A, B, out_mult);
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
				.op(op),
				.out(out));

	
endmodule

/*module ula4 (	input [3:0]a,b, 
					input [2:0]op,
					output reg [3:0] out
				);
				
				
				always @(*) begin
					case(op)
					3'b000 : out = a + b;
					3'b001 : out = a - b;
					3'b010 : out = a * b;
					3'b011 : out = a / b;
					
					3'b100 : if(a == b) begin
								out = 4'b0001;
								end else begin
								out = 4'b0000;
								end
								
								
					3'b101 : if(a > b) begin
								out = 4'b0001;
								end else begin
								out = 4'b0000;
								end
								
					3'b110 : if(a < b) begin
								out = 4'b0001;
								end else begin
								out = 4'b0000;
								end
								
					3'b111 : if(a != b) begin
								out = 4'b0001;
								end else begin
								out = 4'b0000;
								end
								
					default : out = 4'b0000;
					endcase
				end
endmodule*/

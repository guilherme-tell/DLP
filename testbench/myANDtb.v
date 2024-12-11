`timescale 1ns/10ps // Escala de tempo - A cada 1n ele MOSTRA um valor, e a cada 10ps ele simula o circuito

module myANDtb();


reg inA, inB;
wire outX;

initial 
begin
			inA = 1'b0;			//A referencia desse cara aqui é a linha anterior
	#50	inA = 1'b1;
	#50	inA = 1'b0;
	#50	inA = 1'b1;
	#50	inA = 1'b0;
	
end

initial 
fork
			inB = 1'b0;			//A referencia de tempo é absoluta
	//#50	inB = 1'b1;
	#100	inB = 1'b1;
	//#150	inB = 1'b1;
	
join

	myAND DUT(.A(inA),
				.B(inB),
				.X(outX)
				);
endmodule

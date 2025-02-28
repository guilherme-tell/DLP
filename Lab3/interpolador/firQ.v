module firQ (input clk, reset,
				input signed [31:0] entrada,
				output reg signed [31:0] saida
				);

	parameter N = 4;
	
	reg signed [31:0] coef 		[0: N-1];
	reg signed [31:0] sample	[0:N-1];
	reg signed [63:0] acumulada;
	integer i;
	
	initial begin
//		coef[0] = 32'd65536;		//Menor valor inteiro 2^(Bq/2) ; Bq = 32
//		coef[1] = 32'd65536;
//		coef[2] = 32'd65536;

		coef[0] = 32'd16384;		//Menor valor inteiro 2^(Bq/2) ; Bq = 32
		coef[1] = 32'd16384;
		coef[2] = 32'd16384;
		coef[3] = 32'd16384;
	end
	
	
	always @(posedge clk or posedge reset) begin 
		if (reset) begin 
			for (i = 0; i < N; i=i+1) begin
				sample[i] <= 32'b0; 
				
			end
				saida <= 32'd0; 
		end 
		else begin
			for (i = N-1; i > 0; i=i-1) begin
				sample[i] <= sample[i-1]; 
			end
			sample[0] <= entrada; 
			
			acumulada  = 64'b0;
			for (i = 0; i < N; i=i+1) begin
				acumulada = acumulada + sample[i]*coef[i];
			end
			
			saida <= acumulada[47:16];
		end
	end
				
endmodule

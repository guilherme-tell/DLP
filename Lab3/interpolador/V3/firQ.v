module firQ (input clk, //reset,
				input signed [31:0] entrada,
				input enable,
				output reg signed [31:0] saida
				);

	parameter N = 8;
	
	reg signed [31:0] coef 		[0: N-1];
	reg signed [31:0] sample	[0:N-1];
	reg signed [63:0] acumulada;
	integer i;
	
	initial begin

		coef[0] = 32'd15085;		// coeficientes b gerados pela funcao remez python
		coef[1] = 32'd1104;
		coef[2] = 32'd1102;
		coef[3] = 32'd1123;
		coef[4] = 32'd1123;
		coef[5] = 32'd1102;
		coef[6] = 32'd1104;
		coef[7] = 32'd15085; 
		
		//coef[0] = 32'd8192;		
		//coef[1] = 32'd8192;
		//coef[2] = 32'd8192;
		//coef[3] = 32'd8192;
		//coef[4] = 32'd8192;
		//coef[5] = 32'd8192;
		//coef[6] = 32'd8192;
		//coef[7] = 32'd8192;
		
		
		
	end
	// 15085  1104  1102  1123  1123  1102  1104 15085
	
	
	always @(posedge clk ) begin 
	if(enable)begin
			for (i = N-1; i > 0; i=i-1) begin
				sample[i] <= sample[i-1]; 
			end
			sample[0] <= entrada; 
			
			acumulada  = 64'b0;
			for (i = 0; i < N; i=i+1) begin
				acumulada = acumulada + sample[i]*coef[i];
			end
			
			saida <= acumulada[47:16];
		end else begin
		for (i = 0; i < N; i=i+1) begin
				sample[i] <= 32'b0; 
				
			end
				saida <= 32'd0; 
		end
	end
				
endmodule
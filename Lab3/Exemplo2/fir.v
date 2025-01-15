module fir (input clk, reset,
				input signed [15:0] entrada,
				output reg signed [15:0] saida
				);

	parameter N = 3;
	
	reg [15:0] coef [0: N-1];
	reg [15:0] sample	[0:N-1];
	reg [15:0] acumulada;
	integer i;
	
	initial begin
		coef[0] = 16'h1;
		coef[1] = 16'h1;
		coef[2] = 16'h1;
	end
	
	
	always @(posedge clk or posedge reset) begin 
		if (reset) begin 
			for (i = 0; i < N; i=i+1) begin
				sample[i] <= 16'b0; 
				
			end
				saida <= 16'd0; 
		end 
		else begin
			for (i = N-1; i > 0; i=i-1) begin
				sample[i] <= sample[i-1]; 
			end
			sample[0] <= entrada; 
			
			acumulada  = 16'b0;
			for (i = 0; i < N; i=i+1) begin
				acumulada = acumulada + sample[i]*coef[i];
			end
			
			saida <= acumulada;
		end
	end
				
endmodule

`timescale 1ns/1ps

module exemplo1_tb ();

// criando clock
reg clk;
reg amostra_pronta;

integer i = 0;

always #10 clk <= ~clk;  

 reg signed [31:0] x;
 //wire signed [31:0] y;
 wire flag;
 wire [15:0] cnt;
 wire ctrl;
 reg rst;

integer data_x = 32'd0;
//integer data_y = 16'd0;


initial fork

	clk <= 1'b0;
	rst <= 1'b0;
	data_x <= $fopen("Sinalx.txt","r");			// r -> read 
//	data_y <= $fopen("Sinaly.txt","w");			// w -> write

	#11 rst <= 1'b1;

join

always @ (posedge clk) begin

	if (i==15) begin	
		$fscanf(data_x, "%d", x);		
		amostra_pronta = 1'b1;
		i = 0;
	end
	else begin
		amostra_pronta = 1'b0;
		i = i + 1;
	end
end
	

top_level  DUT		(.clk(clk),
						 .entrada(x),
						 .amostra_pronta(amostra_pronta),
						 .flag(flag),
						 .reset(rst),
						 .ctrl(ctrl),
						 .cnt(cnt)
						 //.x_filt(y)
						);


endmodule
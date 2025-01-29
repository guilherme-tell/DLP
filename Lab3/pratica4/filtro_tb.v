`timescale 1ns/1ps

module filtro_tb ();

// criando clock
reg clk;

always #10 clk <= ~clk;  

 reg signed [15:0] x;
 wire signed [15:0] y;

integer data_x = 16'd0;
integer data_y = 16'd0;

initial fork

	clk <= 1'b1;
	data_x <= $fopen("Sinalx.txt","r");			// r -> read 
	data_y <= $fopen("Sinaly.txt","w");			// w -> write

join

always @ (negedge clk) begin

	$fscanf(data_x, "%d", x);
	$fwrite(data_y, "%d", y);

end 

filtroFIR_Qmn DUT (	.clk(clk), 
							.x(x),
							.y(y)
				); 


endmodule

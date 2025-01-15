`timescale 1ns/1ps

module exemplo1_tb ();

// criando clock
reg clk;

always #10 clk <= ~clk;  

integer data_x = 16'd0 x;
integer data_y = 16'd0 y;

initial fork

	clk <= 1'b1;
	data_x <= $fopen("Sinalx.txt","r");			// r -> read 
	data_y <= $fopen("Sinaly.txt","w");			// w -> write

join

always @ (negedge clk) begin

	$fscanf(data_x, "%d", x);
	$fwrite(data_y, "%d", y);

end 

filtro DUT (.clk(clk), 
				.x(x),
				.y(y)
				); 


endmodule

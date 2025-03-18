`timescale 1ns/1ps

module exemplo1_tb ();

// criando clock
reg clk;

always #10 clk <= ~clk;  

 reg signed [31:0] x;
 //wire signed [31:0] y;
 wire flag;
 wire [2**3:0] cnt;

integer data_x = 32'd0;
//integer data_y = 16'd0;


initial fork

	clk <= 1'b0;
	data_x <= $fopen("Sinalx.txt","r");			// r -> read 
	//data_y <= $fopen("Sinaly.txt","w");			// w -> write

join

always @ (posedge clk) begin

	$fscanf(data_x, "%d", x);
	//$fwrite(data_y, "%d ", y);
	
end 

top_level  DUT		(.clk(clk),
						 .entrada(x),
						 .flag(flag),
						 .cnt(cnt)
						 //.x_filt(y)
						);


endmodule

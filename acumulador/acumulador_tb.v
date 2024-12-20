`timescale 1ns/10ps 

module acumulador_tb ();

    wire signed [3:0] out;
    reg clk,clr_n,en;
    reg signed [3:0] A;
	 reg [8:0] in;

    initial
    fork
	 
			clk = 1'b0;
			clr_n = 1'b0;
			en = 1'b0;
			A = 4'd0;
			in = 9'd0;
			// expect out = 0;

		  
			#200 clr_n = 1'b1;	
			
			#400 A = 4'd2;
			#420 in = 9'b100000000;
			
			#440 en = 1'b1;
			#480 en = 1'b0;
			
			#500 A = 4'd3;
			#520 in = 9'd0;
			
			#560 en = 1'b1;
			#600 en = 1'b0;	
			
			#620 A = 4'd1;
			
			#640 en = 1'b1;
			#680 en = 1'b0;			

			forever 
				#20 clk = ~clk;

    join


    acumulador U0 (A,in,clk,clr_n,en,out);


endmodule

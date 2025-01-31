`timescale 1ns/10ps 

module programcounter_tb();

	parameter bits = 32;
	
	reg clk, clr_n, load_en;
	reg [bits-1:0] load; 
	wire [bits-1:0] pc;

	initial fork
	
		clk = 1'b0;
		clr_n = 1'b0;
		load_en = 1'b0;
		load = 32'hAA;
	
		#100 clr_n = 1'd1;
		
		#500 load_en = 1'b1;
		#800 clr_n = 1'b0;

		forever 
			#10 clk = ~clk;
	
	join


	ProgramCounter #( 
						  .pcen(bits), 
						  .pcout(bits)
						  )
						  PC
                   (
						  .clk(clk), 
						  .clr_n(clr_n), 
						  .load_en(load_en),
                    .pc_next(0), 
						  .load(load),
					     .pc(pc)	 
						  );



endmodule
`timescale 1ns/10ps

module senhas_tb ();

	reg clk;
	reg [7:0] senha;
	reg rst;
	reg enter;
	wire resultado;

	initial fork
	
		senha = 8'd0;
		clk =   1'b0;
		rst =   1'b1;
		enter = 1'b0;
		
		#100 rst = 1'b0;
		
		#150 senha = 8'd200;		
		
		#155 enter = 1'b1;
		#195 enter = 1'b0;
		
		
		
		#1150 senha = 8'd1;		
		
		#1160 enter = 1'b1;
		#1180 enter = 1'b0;
		
		#2150 senha = 8'd199;		
		
		#2160 enter = 1'b1;
		#2180 enter = 1'b0;
		
		
		forever #10 clk = ~clk;
	
	join
	

	acess_ctrl acesso  (	 .clk(clk),
	                      .rst(rst),
								 .enter(enter),
								 .senha_digitada(senha), 
								 .resultado(resultado));							


endmodule

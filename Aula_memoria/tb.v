`timescale 1ns/10ps

module tb();

/*
	parameter ADDR_W = 4;
	parameter DATA_W = 4;

	reg clk;
	reg [ADDR_W-1:0] addr;
	wire [DATA_W-1:0] data;

	initial begin
	
	clk = 1'b0;
	addr = 4'd0;
	
		forever #20 clk = ~clk;
	
	end
	
	always @ (posedge clk)begin			// contador para incrementar o endereço da memoria
	
		addr<= addr + 4'd1;
	
	end

			single_port_ROM #(	.data_w (DATA_W),
										.addr_w (ADDR_W)
									)
										DUT
									( 	.clk(clk),
										.addr(addr),
										.data_out(data)
									);

*/

	parameter ADDR_W = 4;
	parameter DATA_W = 4;

	reg clk;
	reg we;
	reg [ADDR_W-1:0] addr;
	reg [DATA_W-1:0] in;
	wire [DATA_W-1:0] out;

	initial fork
	
	clk = 1'b0;
	we = 1'b0;
	addr = 4'd0;
	in = 4'd0;
	
	#40 addr = 4'd0;
	#40 in 	= 4'd7;
	#40 we 	= 1'b1;
	#80 we 	= 1'b0;
	
	#200 addr 	= 4'd0;
	#200 in 		= 4'd9;
	#200 we 		= 1'b1;
	#240 we 		= 1'b0;
	
	
		forever #20 clk = ~clk;
	
	join
	
	

			single_port_RAM #(	.data_w (DATA_W),
										.addr_w (ADDR_W)
									)
										DUT
									( 	.clk(clk),
										.we(we),
										.addr(addr),
										.data_in(in),
										.data_out(out)
									);
endmodule

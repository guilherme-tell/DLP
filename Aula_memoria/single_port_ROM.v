module single_port_ROM #(parameter data_w = 8, addr_w = 8)
								(input clk,
								 input [addr_w-1:0] addr,
								 output reg [data_w-1:0] data_out);
		
	reg [data_w-1:0] mem [0:2**addr_w-1];
	
	initial begin
	
		$readmemb("init.txt",mem);			// inicialização de memoria ( nao sintetizável)
													// readmemb -> arquivo binario
	end
	
	always @ (posedge clk)begin
	
		data_out <= mem[addr];
	
	end
	
endmodule


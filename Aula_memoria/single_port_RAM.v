module single_port_RAM #(parameter data_w = 8, addr_w = 8)
								(input clk,we,
								 input [addr_w-1:0] addr,
								 input [data_w-1:0] data_in,
								 output reg [data_w-1:0] data_out);
		
	reg [data_w-1:0] mem [0:2**addr_w-1];
	
	initial begin
	
		$readmemb("init.txt",mem);			
		
	end
	
	always @ (posedge clk)begin
	
		data_out <= mem[addr];
		
		if(we)								// write enable
			mem [addr] <=  data_in;		// addr é o mesmo da escrita (single port)
		
	end
	
endmodule


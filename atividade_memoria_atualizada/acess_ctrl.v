module acess_ctrl (	input clk, rst,enter,
							input [7:0] senha_digitada, 
							output resultado);

wire [4:0] mem_addr;
wire [7:0] out_mem;
wire ena_cnt;
wire FC;

mycontrol mycontrol(
                    .clk(clk),
						  .reset(rst),
						  .enter(enter),
						  .senha(senha_digitada),
						  .out_mem(out_mem),
						  .ena_cnt(ena_cnt),
						  .status(resultado),
						  .FC(FC)
						  );
	
binary_counter #(
                 .WIDTH(5)
					 )
                myCNT
                (
                .clk(clk), 
                .enable(ena_cnt), 
                .reset(rst),
                .count(mem_addr),
					 .FC(FC)
                );						
	
myROM	myROM_inst (
	               .address (mem_addr),
	               .clock (clk),
	               .q (out_mem)
	               );
				
							
endmodule

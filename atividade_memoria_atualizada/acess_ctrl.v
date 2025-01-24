module acess_ctrl (	input clk0, rst,enter,
							input [7:0] senha_digitada, 
							output resultado);

	//rst : SW[17]						// inverter reset caso seja bt e nao sw
	//enter : KEY[3]				
	//senha_digitada: SW[7]:SW[0]
	// resultado : LEDG[0]
	
wire [4:0] mem_addr;
wire [7:0] out_mem;
wire ena_cnt, rst_cnt;
//wire FC_cnt;
wire FC;
wire enter_sync;
wire clk;

//assign FC_cnt = (out_mem == senha_digitada) | FC;

mycontrol mycontrol(
                    .clk(clk),
						  .reset(rst),
						  .enter(enter_sync),
						  .senha(senha_digitada),
						  .out_mem(out_mem),
						  .ena_cnt(ena_cnt),
						  .status(resultado),
						  .reset_cnt(rst_cnt),
						  .FC(FC)
						  );
	
binary_counter #(
                 .WIDTH(5)
					 )
                myCNT
                (
                .clk(clk), 
                .enable(ena_cnt), 
                .reset(rst_cnt),
                .count(mem_addr),
					 .FC(FC)
                );						
	
myROM	myROM_inst (
	               .address (mem_addr),
	               .clock (clk),
	               .q (out_mem)
	               );
				


sincronizador one_shot( .clr_n(~rst), 
								.clk(clk),
								.in(~enter),
								.out(enter_sync)
							  );
							  
PLL	PLL_inst(								// comentar PLL para simular 
					 .areset ( rst ),
					 .inclk0 ( clk0 ),
					 .c0 ( clk )
					);

							
endmodule

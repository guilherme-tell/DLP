module ProgramCounter( input clk, clr_n, load_en,ena,
                       input [3:0] PC_load,
					        output reg [3:0] PC_out);

	//always @ (negedge clk or negedge clr_n) begin
	//
	//	if(~clr_n)			
	//		pc <= 32'd0;				
	//	else if (~load_en)
	//		pc <= pc + 32'd4;
	//		else 
	//			pc <= load;
	//	
	//end
							 
	always @ (posedge clk or posedge clr_n)begin
	
	if(clr_n)
		PC_out <= 4'd0;						// para usar em entradas parametrizadas tem um método sla
	else begin
		if(ena)begin	
			if(load_en)
				PC_out <= PC_load;
			else
				PC_out <= PC_out + 4'd1;
		end
	end
	end
endmodule

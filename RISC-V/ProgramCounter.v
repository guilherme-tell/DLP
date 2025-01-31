module ProgramCounter #(parameter pcen = 32, pcout = 32)
                      (
							  input clk, clr_n, load_en,
                       input [pcen-1:0] pc_next, load,
					        output reg [pcout-1:0] pc		 
							 );

	always @ (negedge clk or negedge clr_n) begin
	
		if(~clr_n)			
			pc <= 32'd0;				
		else begin if (~load_en)
			pc <= pc + 32'd4;
			else 
				pc <= load;
		end
	end
							 

endmodule
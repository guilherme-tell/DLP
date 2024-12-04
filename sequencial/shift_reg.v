module shift_reg (input A,
						input clk,
						output reg D);
	
	reg B,C;
	
	always @ (posedge clk)begin
		
		B <= A ;
		C <= B;
		D <= C;
	
	end
		

// blocking assignment (=): resolvido linha por linha
	
//	nonblocking assignment (<=): sintetiza em 'cadeia'
		
endmodule


module top_cont (input clk, clr_n, en, up_d,
					  output  [6:0]  out1,out2,
					  output  TC );
	
	wire [3:0] cnt1,cnt2;
	wire TC1,TC2;
	
	assign TC = TC1 & TC2;
	
	cont_10 unidade (clk, clr_n, en, up_d, cnt1, TC1 );
	
	cont_10 dezena (TC1, clr_n, en, up_d, cnt2, TC2 );
	
	dec_7seg seg1 (cnt1, out1 );
	
	dec_7seg seg2 (cnt2, out2 );


	 /*en sw0
		up_d sw1 
		clr_n sw2
		clk butao
		TC ledr0
	 */

endmodule

`timescale 1ns/10ps 

module FSM_tb();

reg clk,clr_n;
wire in;
wire out;

initial fork

	clk = 1'b0;
	clr_n = 1'b0;
	
	forever 
		#20 clk = ~clk;
	
	#100 clr_n = 1'b1;

join


reg [4:0] cnt;					// contador para sincronizar o sinal de clock

always @(posedge clk)	
begin
	if(~clr_n)					// contador depende do clock, a entrada depende do contador. na borda em que a entrada é 1, a saida esta ligeiramente atrasada, devido a isso a saida so e atualizada na borda seguinte;
		cnt <= 5'd0;
	else
		cnt <=  cnt + 5'd1;
end

assign in = (cnt > 5'd10) & (cnt<5'd15);

gerador_clk DUT ( .clk(clk),
						.clr_n(clr_n),
						.in(in),
						.out(out)
					 );

endmodule


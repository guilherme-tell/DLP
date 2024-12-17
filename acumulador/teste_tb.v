module acumulador_tb ();

    wire [3:0] out;
    reg clk,clr_n;
    reg [3:0] A,op;

    initial
    fork

        clr_n = 1'b0;
        op = 4'd0;
        clk = 1'b0;
        A = 4'd5;
        // expect out = 0;

        #50 clr_n =1'd1;
        // expect out = 5;


        forever 
	    #10 clk = ~clk;

    join


    acumulador U0 (A,op,clk,clr_n,out);


endmodule

`timescale 1ns/10ps

module mySUMtb();

integer data_inA, data_inB, data_X;

reg signed [3:0] A,B;
wire signed [4:0] X;

initial 
fork
	data_inA <= $fopen("inA.txt", "r");
	data_inB <= $fopen("inB.txt", "r");
	data_X <= $fopen("out.txt", "w");
	
	forever
	begin
		#50	$fscanf(data_inA, "%d", A);
				$fscanf(data_inB, "%d", B);
				$fwrite(data_X, "%d\n", X);
	end

join

mySUM DUT(
				.A(A),
				.B(B),
				.X(X)
				);

endmodule 

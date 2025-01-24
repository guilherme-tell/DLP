// Quartus II Verilog Template
// Binary counter

module binary_counter
#(parameter WIDTH=64)
(
	input clk, enable, reset,
	output reg [WIDTH-1:0] count,
	output reg FC
);

	// Reset if needed, or increment if counting is enabled
	always @ (posedge clk or posedge reset) // or posedge reset_maq
	begin
		if (reset) // | reset_maq
			count <= 0;
		else if (enable == 1'b1)
			count <= count + 1;
	end

	always @ (posedge clk) FC = (count ==5'd31);		// saída registrada FC -> atraso de + 1 clock
endmodule

// Quartus II Verilog Template
// Binary counter

module binary_counter
#(parameter WIDTH=64)
(
	input clk, enable, reset,
	output reg [WIDTH-1:0] count,
	output FC
);

	// Reset if needed, or increment if counting is enabled
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
			count <= 0;
		else if (enable == 1'b1)
			count <= count + 1;
	end

assign FC = (count ==5'd31);
endmodule

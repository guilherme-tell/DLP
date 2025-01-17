module mycontrol (
                  input clk, reset, enter,FC,
						input[7:0] senha,
						input[7:0]out_mem,
						output reg ena_cnt, status, reset_cnt
                  );
											
	// Declare state register
	reg		[1:0]state;

	// Declare states
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;

	// Output depends only on the state
	always @ (state) begin
		case (state)
			S0:
			begin
				ena_cnt = 1'b0;
				status =  1'b0;
				reset_cnt = 1'b1;
			end
			S1:
			begin
				ena_cnt = 1'b1;
				status =  1'b0;
				reset_cnt = 1'b0;				
			end
			S2:
			begin
				ena_cnt = 1'b0;
				status =  1'b1;
				reset_cnt = 1'b0;
			end
			default:
			begin
				ena_cnt = 1'b0;
				status =  1'b0;
				reset_cnt = 1'b0;
			end
		endcase
	end

	// Determine the next state
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else
			case (state)
				S0:
					if(enter==1'b1)
						state <= S1;
				S1:
					if (senha == out_mem)
						state <= S2;
					else
						if(FC==1'b1)
							state <=S0;
				S2:
					state <=S0;
			endcase
	end						
						
endmodule

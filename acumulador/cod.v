module cod (input [8:0] in,
				output reg [3:0] op);
				
	always @ (*) begin
	case(in)
		9'b000000001: op = 4'd0;
		9'b000000010: op = 4'd1;
		9'b000000100: op = 4'd2;
		9'b000001000: op = 4'd3;
		9'b000010000: op = 4'd4;
		9'b000100000: op = 4'd5;
		9'b001000000: op = 4'd6;
		9'b010000000: op = 4'd7;
		9'b100000000: op = 4'd8;
		default: 	  op = 4'd0;
	
	endcase
	end
			
endmodule


//soma,sub,annd,oor,xxor,nott,d_e,d_d,carg,
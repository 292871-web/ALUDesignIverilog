module ALU (input logic [31:0] A, B, input logic [2:0] opCode, statusIn , output logic [31:0] y, output logic statusOut);
	logic [31:0] resultSum, resultSub;
	logic flagSum, flagSub;
	
	adderCLA_32bit fullAdder (A,B,statusIn,resultSum, flagSum);
	subBLA_32bit fullSub (A,B,statusIn,resultSub, flagSub); 
	
	always_comb
	case(opCode)
		4'b0000: begin //add
			y = resultSum;
			statusOut = flagSum;
			end
		4'b0001: begin //sub
			y = resultSub;
			statusOut = flagSub;
			end
		4'b0010: begin //and
			y = A & B;
			statusOut = 0;
			end
		4'b0011: begin //or
			y = A | B;
			statusOut = 0;
			end
		4'b0100: begin //xor
			y = A ^ B;
			statusOut = 0;
			end
		4'b0101: begin //SLT
			
			end
		4'b0110: begin //STLU 
			
			end
		default: begin
			y = '0;
			statusOut = 0;
			end
	endcase

endmodule

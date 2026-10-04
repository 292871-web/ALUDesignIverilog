module ALU (input logic [31:0] A, B, input logic [3:0] opCode, statusIn , output logic [31:0] y, output logic statusOut);
	logic [31:0] resultSum, resultSub;
	logic flagSum, flagSub;
	
	addsub32 fullAdder (A,B,0,resultSum, flagSum, flagSumOverflow);
	addsub32 fullSub (A,B,1,resultSub, flagSub, flagSubOverflow); 
	
	always_comb
	case(opCode)
		4'b0000: y = resultSum; //add addi lw sw auipc
		4'b0001: y = resultSub; //sub beq bne blt bge 
		4'b0010: y = A & B; //and andi
		4'b0011: y = A | B; //or ori
		4'b0100: y = A ^ B; //xor xori
		4'b0101: begin //slt slti
			if (flagSubOverflow)
				y = 32'h0000_0001;
			else 
				y = 32'h0000_0000;
			end
		4'b0110: begin //sltu sltiu 
			if (flagSub == 0) 
				y = 32'h0000_0001;
			else
				y = 32'h0000_0000;
			end
		4'b0111: //sll slli
		B[4:0]
		4'b1000: //srl srli
		4'b1001: //sra srai
		default: begin
			y = 0;
			end
		statusOut = ~(|y);
	endcase

endmodule

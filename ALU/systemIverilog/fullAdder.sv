module adderCLA_4bit(input logic [3:0] A,B, input logic cin, output logic [3:0] S, output logic Gg, Pg);
	logic [3:0] P, G, C;
	always_comb
		begin
		P = A ^ B;
		G = A & B;
		
		C[0] = G[0] | (cin & P[0]);
		C[1] = G[1] | (G[0] & P[1]) | (cin & P[1] & P[0]);
		C[2] = G[2] | (G[1] & P[2]) | (G[0] & P[1] & P[2]) | (cin & P[0] & P[1] & P[2]);
		C[3] = G[3] | (G[2] & P[3]) | (G[1] & P[2] & P[3]) | (G[0] & P[1] & P[2] & P[3]) | (cin & P[0] & P[1] & P[2] & P[3]);
		
		S = P ^ {C[2:0], cin};
		
		Pg = P[0] & P[1] & P[2] & P[3];
		Gg = G[3] | (G[2] & P[3]) | (G[1] & P[3] & P[2]) | (G[0] & P[1] & P[2] & P[3]);
		end
endmodule

module adderCLA_16bit(input logic [15:0] A,B, input logic cin, output logic [15:0] S, output logic GgH, PgH);
	logic [3:0] C, Gg, Pg;
	assign C[0] = cin;
	assign C[1] = Gg[0] | (Pg[0] & C[0]);
	assign C[2] = Gg[1] | (Pg[1] & Gg[0]) | (Pg[1] & Pg[0] & C[0]);
	assign C[3] = Gg[2] | (Pg[2] & Gg[1]) | (Pg[2] & Pg[1] & Gg[0]) | (Pg[2] & Pg[1] & Pg[0] & C[0]);
	
	adderCLA_4bit CLA3_0(A[3:0],B[3:0],C[0],S[3:0], Gg[0], Pg[0]);
	adderCLA_4bit CLA7_4(A[7:4],B[7:4],C[1],S[7:4], Gg[1], Pg[1]);
	adderCLA_4bit CLA11_8(A[11:8],B[11:8],C[2],S[11:8], Gg[2], Pg[2]);
	adderCLA_4bit CLA15_12(A[15:12],B[15:12],C[3],S[15:12], Gg[3], Pg[3]);
	
	assign PgH = Pg[3] & Pg[2] & Pg[1] & Pg[0];
	assign GgH = Gg[3] | (Gg[2] & Pg[3]) | (Gg[1] & Pg[2] & Pg[3]) | (Gg[0] & Pg[1] & Pg[2] & Pg[3]);
endmodule

module adderCLA_32bit(input logic [31:0] A,B, input logic cin, output logic [31:0] S, output logic overflow);
	logic [1:0] C, GgH, PgH;
	
	assign C[0] = cin;
	assign C[1] = GgH[0] | (PgH[0] & C[0]);
	
	adderCLA_16bit CLA15_0 (A[15:0],B[15:0],C[0],S[15:0], GgH[0], PgH[0]);
	adderCLA_16bit CLA31_16 (A[31:16], B[31:16], C[1], S[31:16], GgH[1], PgH[1]);
	
	assign overflow = GgH[1] | (GgH[0] & PgH[1]) | (PgH[0] & PgH[1] & C[0]);
	
endmodule

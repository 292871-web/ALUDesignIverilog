module subBLA_4bit (input logic [3:0] A,B, input logic cin, output logic [3:0] D, output logic Gg, Pg);
	logic [3:0] G,P,C;
	always_comb
		begin
		G = ~A & B;
		P = ~(A ^ B);
		
		C[0] = cin;
		C[1] = G[0] | (P[0] & C[0]);
		C[2] = G[1] | (G[0] & P[1]) | (P[0] & P[1] & C[0]);
		C[3] = G[2] | (G[1] & P[2]) | (G[0] & P[1] & P[2]) | (P[0] & P[1] & P[2] & C[0]); 
		
		D = A ^ B ^ C;
		
		Pg = P[3] & P[2] & P[1] & P[0];
		Gg = G[3] | (G[2] & P[3]) | (G[1] & P[2] & P[3]) | (G[0] & P[1] & P[2] & P[3]);
		end
endmodule

module subBLA_16bit (input logic [15:0] A,B, input logic cin, output logic [15:0] D, output logic GgH, PgH);
	logic [3:0] Pg, Gg, C;
		
	subBLA_4bit BLA3_0 (A[3:0],B[3:0],C[0],D[3:0],Gg[0],Pg[0]);
	subBLA_4bit BLA7_4 (A[7:4],B[7:4],C[1],D[7:4],Gg[1],Pg[1]);
	subBLA_4bit BLA11_8 (A[11:8],B[11:8],C[2],D[11:8],Gg[2],Pg[2]);
	subBLA_4bit BLA15_12 (A[15:12],B[15:12],C[3],D[15:12],Gg[3],Pg[3]);
	
	always_comb
		begin
		C[0] = cin;
		C[1] = Gg[0] | (Pg[0] & C[0]);
		C[2] = Gg[1] | (Gg[0] & Pg[1]) | (Pg[0] & Pg[1] & C[0]);
		C[3] = Gg[2] | (Gg[1] & Pg[2]) | (Gg[0] & Pg[1] & Pg[2]) | (Pg[0] & Pg[1] & Pg[2] & C[0]); 
		
		PgH = Pg[3] & Pg[2] & Pg[1] & Pg[0];
		GgH = Gg[3] | (Gg[2] & Pg[3]) | (Gg[1] & Pg[2] & Pg[3]) | (Gg[0] & Pg[1] & Pg[2] & Pg[3]);
		end

endmodule

module subBLA_32bit (input logic [31:0] A,B, input logic cin, output logic [31:0] D, output logic underflow);
	logic [1:0] PgH, GgH, C;
		
	subBLA_16bit BLA15_0 (A[15:0], B[15:0], C[0], D[15:0], GgH[0], PgH[0]);
	subBLA_16bit BLA31_16 (A[31:16], B[31:16], C[1], D[31:16], GgH[1], PgH[1]);
	
	always_comb
		begin
		C[0] = cin;
		C[1] = GgH[0] | (C[0] & PgH[0]);
		
		underflow = GgH[1] | (GgH[0] & PgH[1]) | (PgH[1] & PgH[0] & C[0]);
		end
	
endmodule

module butterfly_operation(
	input [7:0] w_addr,
	input[63:0] data_a,data_b,
	output[63:0] q_a,q_b
);

	wire signed [31:0] w_Re,w_Im,interA_Re,interA_Im,interB_Re,interB_Im,temp_Re,temp_Im;
	wire signed [63:0] large_tempRe,large_tempIm;

	w_rom TFR(
		.addr(w_addr),
		.data({w_Re,w_Im})
	);
	
	assign {interA_Re,interA_Im} = data_a;
	assign {interB_Re,interB_Im} = data_b;
	
	assign large_tempRe = interB_Re*w_Re+interB_Im*w_Im;
	assign large_tempIm = interB_Im*w_Re-interB_Re*w_Im;

	assign temp_Re = large_tempRe[47:16];
	assign temp_Im = large_tempIm[47:16];
	
	assign q_b[63:32]  = interA_Re - temp_Re;
	assign q_b[31:0]   = interA_Im - temp_Im;	
	
	assign q_a[63:32]  = interA_Re + temp_Re;
	assign q_a[31:0]   = interA_Im + temp_Im;
	
endmodule


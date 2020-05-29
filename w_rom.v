module w_rom(
	input [7:0] addr,
	output reg [63:0] data
	);
	
	always @ (addr)
	begin
		case (addr)
			0  : data = 64'h10000_00000000;
			1  : data = 64'h0ffec_fffff9b8;
			2	: data = 64'h0ffb1_fffff370;
			3	: data = 64'h0ff4e_ffffed2b;
			4	: data = 64'h0fec4_ffffe6e8;
			5	: data = 64'h0fe13_ffffe0aa;
			6	: data = 64'h0fd3b_ffffda70;
			7	: data = 64'h0fc3b_ffffd43c;
			8	: data = 64'h0fb15_ffffce0f;
			9	: data = 64'h0f9c8_ffffc7e9;
			10	: data = 64'h0f854_ffffc1cc;
			11	: data = 64'h0f6ba_ffffbbb9;
			12	: data = 64'h0f4fa_ffffb5b0;
			13	: data = 64'h0f314_ffffafb3;
			14	: data = 64'h0f109_ffffa9c2;
			15	: data = 64'h0eed9_ffffa3de;
			16	: data = 64'h0ec83_ffff9e08;
			17	: data = 64'h0ea0a_ffff9842;
			18	: data = 64'h0e76c_ffff928c;
			19	: data = 64'h0e4aa_ffff8ce6;
			20	: data = 64'h0e1c6_ffff8753;
			21	: data = 64'h0debe_ffff81d1;
			22	: data = 64'h0db94_ffff7c64;
			23	: data = 64'h0d848_ffff770a;
			24	: data = 64'h0d4db_ffff71c6;
			25	: data = 64'h0d14d_ffff6c98;
			26	: data = 64'h0cd9f_ffff6780;
			27	: data = 64'h0c9d1_ffff6280;
			28	: data = 64'h0c5e4_ffff5d98;
			29	: data = 64'h0c1d8_ffff58ca;
			30	: data = 64'h0bdaf_ffff5415;
			31	: data = 64'h0b968_ffff4f7a;
			32	: data = 64'h0b505_ffff4afb;
			33	: data = 64'h0b086_ffff4698;
			34	: data = 64'h0abeb_ffff4251;
			35	: data = 64'h0a736_ffff3e28;
			36	: data = 64'h0a268_ffff3a1c;
			37	: data = 64'h09d80_ffff362f;
			38	: data = 64'h09880_ffff3261;
			39	: data = 64'h09368_ffff2eb3;
			40	: data = 64'h08e3a_ffff2b25;
			41	: data = 64'h088f6_ffff27b8;
			42	: data = 64'h0839c_ffff246c;
			43	: data = 64'h07e2f_ffff2142;
			44	: data = 64'h078ad_ffff1e3a;
			45	: data = 64'h0731a_ffff1b56;
			46	: data = 64'h06d74_ffff1894;
			47	: data = 64'h067be_ffff15f6;
			48	: data = 64'h061f8_ffff137d;
			49	: data = 64'h05c22_ffff1127;
			50	: data = 64'h0563e_ffff0ef7;
			51	: data = 64'h0504d_ffff0cec;
			52	: data = 64'h04a50_ffff0b06;
			53	: data = 64'h04447_ffff0946;
			54	: data = 64'h03e34_ffff07ac;
			55	: data = 64'h03817_ffff0638;
			56	: data = 64'h031f1_ffff04eb;
			57	: data = 64'h02bc4_ffff03c5;
			58	: data = 64'h02590_ffff02c5;
			59	: data = 64'h01f56_ffff01ed;
			60	: data = 64'h01918_ffff013c;
			61	: data = 64'h012d5_ffff00b2;
			62	: data = 64'h00c90_ffff004f;
			63	: data = 64'h00000648_ffff0014;
			64	: data = 64'h00000000_ffff0000;
			65	: data = 64'hfffff9b8_ffff0014;
			66	: data = 64'hfffff370_ffff004f;
			67	: data = 64'hffffed2b_ffff00b2;
			68	: data = 64'hffffe6e8_ffff013c;
			69	: data = 64'hffffe0aa_ffff01ed;
			70	: data = 64'hffffda70_ffff02c5;
			71	: data = 64'hffffd43c_ffff03c5;
			72	: data = 64'hffffce0f_ffff04eb;
			73	: data = 64'hffffc7e9_ffff0638;
			74	: data = 64'hffffc1cc_ffff07ac;
			75	: data = 64'hffffbbb9_ffff0946;
			76	: data = 64'hffffb5b0_ffff0b06;
			77	: data = 64'hffffafb3_ffff0cec;
			78	: data = 64'hffffa9c2_ffff0ef7;
			79	: data = 64'hffffa3de_ffff1127;
			80	: data = 64'hffff9e08_ffff137d;
			81	: data = 64'hffff9842_ffff15f6;
			82	: data = 64'hffff928c_ffff1894;
			83	: data = 64'hffff8ce6_ffff1b56;
			84	: data = 64'hffff8753_ffff1e3a;
			85	: data = 64'hffff81d1_ffff2142;
			86	: data = 64'hffff7c64_ffff246c;
			87	: data = 64'hffff770a_ffff27b8;
			88	: data = 64'hffff71c6_ffff2b25;
			89	: data = 64'hffff6c98_ffff2eb3;
			90	: data = 64'hffff6780_ffff3261;
			91	: data = 64'hffff6280_ffff362f;
			92	: data = 64'hffff5d98_ffff3a1c;
			93	: data = 64'hffff58ca_ffff3e28;
			94	: data = 64'hffff5415_ffff4251;
			95	: data = 64'hffff4f7a_ffff4698;
			96	: data = 64'hffff4afb_ffff4afb;
			97	: data = 64'hffff4698_ffff4f7a;
			98	: data = 64'hffff4251_ffff5415;
			99	: data = 64'hffff3e28_ffff58ca;
			100 : data = 64'hffff3a1c_ffff5d98;
			101 : data = 64'hffff362f_ffff6280;
			102 : data = 64'hffff3261_ffff6780;
			103 : data = 64'hffff2eb3_ffff6c98;
			104 : data = 64'hffff2b25_ffff71c6;
			105 : data = 64'hffff27b8_ffff770a;
			106 : data = 64'hffff246c_ffff7c64;
			107 : data = 64'hffff2142_ffff81d1;
			108 : data = 64'hffff1e3a_ffff8753;
			109 : data = 64'hffff1b56_ffff8ce6;
			110 : data = 64'hffff1894_ffff928c;
			111 : data = 64'hffff15f6_ffff9842;
			112 : data = 64'hffff137d_ffff9e08;
			113 : data = 64'hffff1127_ffffa3de;
			114 : data = 64'hffff0ef7_ffffa9c2;
			115 : data = 64'hffff0cec_ffffafb3;
			116 : data = 64'hffff0b06_ffffb5b0;
			117 : data = 64'hffff0946_ffffbbb9;
			118 : data = 64'hffff07ac_ffffc1cc;
			119 : data = 64'hffff0638_ffffc7e9;
			120 : data = 64'hffff04eb_ffffce0f;
			121 : data = 64'hffff03c5_ffffd43c;
			122 : data = 64'hffff02c5_ffffda70;
			123 : data = 64'hffff01ed_ffffe0aa;
			124 : data = 64'hffff013c_ffffe6e8;
			125 : data = 64'hffff00b2_ffffed2b;
			126 : data = 64'hffff004f_fffff370;
			127 : data = 64'hffff0014_fffff9b8;
			default: data = 64'hxxxxxxxx_xxxxxxxx;
		endcase
	end
endmodule	
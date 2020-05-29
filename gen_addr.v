module gen_addr(
	input clk,rst,en,
	output done,
	output reg[8:0] addr,
	output reg[7:0] re_addr
);

//	reg[8:0] addr;
	reg[3:0] i;
	
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			addr <= 9'h0;
			re_addr <= 8'h0;
		end
		else
		begin
			if (en)
			begin
				if(addr <= 9'd255)
				begin
					for(i=4'h0;i<4'h8;i=i+4'h1)
					begin
						re_addr[i] = addr[4'h7-i];
					end				
					addr=addr+1;	
				end
				else
				begin
					addr <= 9'h0;
					re_addr <= 8'h0;
				end
			end
			else
			begin
				addr <= 9'h0;
				re_addr <= 8'h0;				
			end
		end	
	end
	
	assign done = (addr==9'd256)? 1:0;
	

	
	

endmodule
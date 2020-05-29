module gen_addr2(
	input clk,rst,en,
	input[3:0] stage,
	output done,
	output reg[7:0] q_addrA,q_addrB,q_addrW
);
	parameter N=9'd256;
	wire[8:0] BSep;
	wire[7:0] BWidth;
	reg[8:0] p;
	reg[15:0] j;
	
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			p<=9'h0;
			j<=15'h0;
		end
		else
		begin	
			if(en == 1'b1)
			begin
				if(p<N && BSep)
				begin
					if(j<BWidth)
					begin
						q_addrA<=p+j;
						q_addrB<=p+j+BWidth;
						q_addrW<=((j<<8)>>stage);
						j=j+15'h1;
					end
					if(j==BWidth)
					begin
						j<=15'h0;
						p<=p+BSep;
					end
				end		
			end
			else
			begin
				p<=0;
				j<=15'h0;
			end

		end	
	end
	
	assign BSep = (en)? 9'd1 << stage:9'hx;
	assign BWidth = (en)? BSep >> 1:8'hx;
	assign done = (p==N)? 1:0;

endmodule
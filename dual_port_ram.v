module dual_port_ram(
	input [63:0] data_a, data_b,        //real and imaginary part
	input [7:0] addr_a, addr_b,
	input wr, 									//w=0,r=1;
	input clk,
	output reg [63:0] q_a, q_b
	);
	
	reg [63:0] ram[255:0]; //64*256 bit;
	
	always @ (posedge clk)
	begin
		if(!wr)
		begin
			ram[addr_a] <= data_a;
//			q_a <= 64'hx;
		end
		else
		begin
			q_a <= ram[addr_a];		
		end
	end

	always @ (posedge clk)
	begin
		if(!wr)
		begin
			ram[addr_b] <= data_b;
//			q_b <= 64'hx;
		end
		else
		begin
			q_b <= ram[addr_b];			
		end
	end	

endmodule
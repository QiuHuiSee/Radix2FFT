`timescale 1ns/1ps
module radix2fft(
	input start, clk, rst,
	input [63:0] x_input,
	output done,
	output [63:0] FFT
);

	parameter S0 = 2'b00; 
	parameter S1 = 2'b01; 
	parameter S2 = 2'b10; 
	parameter S3 = 2'b11;
	parameter S4 = 3'b100;

	reg delayGA2_done;
	reg [2:0] FSM_ps,FSM_ns;
	wire arc_S0_S1; 
	wire arc_S1_S2; 
	wire arc_S2_S3; 
	wire arc_S3_S2;
	wire arc_S3_S4;
	wire arc_S4_done;
	wire fftbegin;

	reg  [3:0] stage;
	reg  [7:0] delay_addrA,delay_addrB,delay_addrW,delayaddr_1a;
	reg  [8:0] fft_addrA;
	reg  [63:0] delayx_input;
	wire [7:0] q_addrA,q_addrB,q_addrW;
	wire [7:0] w_addr,addr_1a,addr_1b,addr_2a,addr_2b,re_addr,norm_addr;
	wire [63:0] i_bfuA,i_bfuB,o_bfuA,o_bfuB;
	wire [63:0] i_mem1A,i_mem1B,o_mem1A,o_mem1B;
	wire [63:0] i_mem2A,i_mem2B,o_mem2A,o_mem2B;
	wire Mem1WR,Mem2WR,addr_done,GA2_done,GA2_en,GA1_en;
	
	butterfly_operation BFU(
		.w_addr(w_addr),
		.data_a(i_bfuA),
		.data_b(i_bfuB),
		.q_a(o_bfuA),
		.q_b(o_bfuB)
	);
	
	dual_port_ram DPRAM1(
		.data_a(i_mem1A), 
		.data_b(i_mem1B),       
		.addr_a(addr_1a), 
		.addr_b(addr_1b),
		.wr(Mem1WR), 									
		.clk(clk),
		.q_a(o_mem1A), 
		.q_b(o_mem1B)
	);
	
	dual_port_ram DPRAM2(
		.data_a(i_mem2A), 
		.data_b(i_mem2B),       
		.addr_a(addr_2a), 
		.addr_b(addr_2b),
		.wr(Mem2WR), 									
		.clk(clk),
		.q_a(o_mem2A), 
		.q_b(o_mem2B)
	);
	
	gen_addr GA1(
		.clk(clk),
		.rst(rst),
		.en(GA1_en),
		.done(addr_done),
		.addr(norm_addr),
		.re_addr(re_addr)
	);

	gen_addr2 GA2(
		.clk(clk),
		.rst(rst),
		.en(GA2_en),
		.stage(stage),
		.done(GA2_done),
		.q_addrA(q_addrA),
		.q_addrB(q_addrB),
		.q_addrW(q_addrW)
	);
	
	initial 
	begin
		FSM_ps <= S0;
	end
	
	always @ (posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			FSM_ps <= S0;
		end
		else
		begin
			FSM_ps <= FSM_ns;
			
			delay_addrA <= q_addrA;
			delay_addrB <= q_addrB;
			delay_addrW <= q_addrW;
			delayGA2_done <= GA2_done;
			delayx_input <= x_input;
			
		end
	end

	always @(FSM_ps or arc_S0_S1 or arc_S1_S2 or arc_S2_S3 or arc_S3_S2 or arc_S3_S4 or arc_S4_done)
	begin
		case (FSM_ps)
			S0:
				begin
					if(arc_S0_S1)
					begin
						FSM_ns = S1;
					end
					else
					begin
						FSM_ns = S0;
					end
				end
			S1:
				begin
					if(arc_S1_S2)
					begin
						stage <= stage + 1;
						FSM_ns <= S2;
					end
					else
					begin
						stage <= 0;
						FSM_ns = S1;
					end
				end
			S2:
				begin
					if(arc_S2_S3)
					begin
						stage <= stage + 1;
						FSM_ns = S3;
					end
					else
					begin						
						FSM_ns <= S2;
					end
				end
			S3:
				begin
					if(arc_S3_S2)
					begin
						stage <= stage + 1;
						FSM_ns = S2;
					end
					else if(arc_S3_S4) 
					begin
						FSM_ns <= S4;
					end
					else
					begin
						FSM_ns <= S3;
					end
				end
			S4:
				begin
					if(arc_S4_done)
					begin
						FSM_ns <= S0;
					end
					else
					begin
					end
				end
			default :         
				begin           
					FSM_ns = 3'bxx;         
				end  
		endcase
	end
	
	assign arc_S0_S1 = start & rst & (FSM_ps == S0); //change state when start
	assign arc_S1_S2 = addr_done & (FSM_ps == S1);   //change state after load input
	assign arc_S2_S3 = delayGA2_done & (FSM_ps == S2);	 //change state after load to DPRAM2
	assign arc_S3_S2 = delayGA2_done & (FSM_ps == S3) & (stage < 8);	 //change state after load to DPRAM1
	assign arc_S3_S4 = delayGA2_done & (FSM_ps == S3) & (stage==8);
	assign arc_S4_done = addr_done & (FSM_ps == S4); 
	
	assign Mem1WR = (FSM_ps == S1)? 0:
						 (FSM_ps == S2)? 1:
						 (FSM_ps == S3)? 0:
						 (fftbegin)? 1:1'bx;	
	assign addr_1a = (FSM_ps == S1)? re_addr:
						  (FSM_ps == S2)? q_addrA:
						  (FSM_ps == S3)? delay_addrA:
						  (fftbegin)? norm_addr:8'hxx;
	assign addr_1b = (FSM_ps == S2)? q_addrB:
						  (FSM_ps == S3)? delay_addrB:8'hxx;	
	assign i_mem1A = (FSM_ps == S1)? delayx_input:
						  (FSM_ps == S3)? o_bfuA :64'hx;
	assign i_mem1B = (FSM_ps == S3)? o_bfuB :64'hx;

	assign Mem2WR = (FSM_ps == S1)? 0:
						 (FSM_ps == S2)? 0:
						 (FSM_ps == S3)? 1:1'bx;	
						 
	assign addr_2a = (FSM_ps == S1)? re_addr:
						  (FSM_ps == S2)? delay_addrA:
						  (FSM_ps == S3)? q_addrA:8'hxx;
						  
	assign addr_2b = (FSM_ps == S2)? delay_addrB:
						  (FSM_ps == S3)? q_addrB:8'hxx;						  

	assign i_mem2A = (FSM_ps == S1)? delayx_input:
						  (FSM_ps == S2)? o_bfuA :64'hx;
	assign i_mem2B = (FSM_ps == S2)? o_bfuB :64'hx;
						  
	assign w_addr = (FSM_ps == S2)? delay_addrW:
					    (FSM_ps == S3)? delay_addrW:8'hxx;	
	assign i_bfuA = (FSM_ps == S2)? o_mem1A:
						 (FSM_ps == S3)? o_mem2A:64'hx;						 
	assign i_bfuB = (FSM_ps == S2)? o_mem1B:
						 (FSM_ps == S3)? o_mem2B:64'hx;	
						 
	assign GA1_en = (FSM_ps == S1)? 1:
						 (fftbegin)? 1:0;
	
	assign GA2_en = (GA2_done)?    0:
						 (FSM_ps == S2)? 1:
						 (FSM_ps == S3)? 1:0;
	
	assign FFT = (fftbegin & (addr_1a >= 1) || (fftbegin & (addr_done)))? o_mem1A:64'hx;
	assign fftbegin = (FSM_ps == S4) & (!delayGA2_done); 
	assign done = arc_S4_done;
	
endmodule
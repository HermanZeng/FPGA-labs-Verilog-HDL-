module pipemem(mwmem,malu,mb,clock,mem_clock,mmo,clrn,/*added*/ out_port0,in_port0,in_port1,mem_dataout,io_read_data);
	input mwmem, clock, mem_clock,clrn;
	input[31:0] malu, mb;
	input[3:0] in_port0, in_port1;
	output[31:0] out_port0;
	output[31:0] mmo;
	output [31:0]	mem_dataout;
	output [31:0]	io_read_data;
	wire mem_clk;
	assign mem_clk = ~clock;
	pipe_datamem dmem(malu,mb,mmo,mwmem,clock,mem_clk,clrn,/*added*/ out_port0,in_port0,in_port1,mem_dataout,io_read_data);
endmodule
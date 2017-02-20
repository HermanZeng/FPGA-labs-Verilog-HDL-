
module sc_computer_test(mem_clk, out_port0, in1, in2, in3, in4, in5, in6, in7, in8, resetn);
// constants                                           
// general purpose registers
//reg eachvec;
// test vector input registers
reg clock;
input mem_clk;
input resetn;
// wires                                               
wire [31:0]  aluout;
wire dmem_clk;
wire imem_clk;
wire [31:0]  inst;
wire [31:0]  memout;
wire [31:0]  pc;
output [31:0]  out_port0;
input in1, in2, in3, in4, in5, in6, in7, in8;
wire [31:0]  in_port0;
wire [31:0]  in_port1;
assign in_port0[31:4] = 28'b0;
assign in_port1[31:4] = 28'b0;
assign in_port0[0] = in1;
assign in_port0[1] = in2;
assign in_port0[2] = in3;
assign in_port0[3] = in4;
assign in_port1[0] = in5;
assign in_port1[1] = in6;
assign in_port1[2] = in7;
assign in_port1[3] = in8;
//assign out_port0 = 32'b0;
//assign in_port0 = 32'd6;
//assign in_port1 = 32'd3;
// assign statements (if any)                          
sc_computer i1 (
// port map - connection between master ports and signals/registers   
	.aluout(aluout),
	.clock(clock),
	.dmem_clk(dmem_clk),
	.imem_clk(imem_clk),
	.inst(inst),
	.mem_clk(mem_clk),
	.memout(memout),
	.pc(pc),
	.resetn(resetn),
	.out_port0(out_port0),
	.in_port0(in_port0),
	.in_port1(in_port1)
);

initial
begin
	clock <= 0;
end

always @ (posedge mem_clk)
begin
	clock <= ~clock;
end
                                                                                
endmodule
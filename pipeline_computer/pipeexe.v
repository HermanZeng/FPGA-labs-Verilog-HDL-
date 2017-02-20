module pipeexe(ealuc,ealuimm,ea,eb,eimm,eshift,ern0,epc4,ejal,/*add output*/ern,ealu);
	input ealuimm,eshift,ejal;
	input[4:0] ern0;
	input[3:0] ealuc;
	input[31:0] ea,eb,eimm,epc4;
	output[4:0] ern;
	output[31:0] ealu;

	wire[31:0] epc8,alua,alub,shift_shamt,alu_out;
	assign epc8 = epc4 + 32'h4;
	assign shift_shamt = { 27'b0, eimm[10:6] };
	assign ern = ern0 | {5{ejal}};
	mux2x32 alu_a (ea,shift_shamt,eshift,alua);
	mux2x32 alu_b (eb,eimm,ealuimm,alub);
	alu al_unit (alua,alub,ealuc,alu_out);
	mux2x32 ealu_value (alu_out,epc8,ejal,ealu);
endmodule
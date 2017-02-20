module pipeid(mwreg,mrn,ern,ewreg,em2reg,mm2reg,dpc4,inst, wrn,wdi,ealu,malu,mmo,wwreg,clock,resetn, bpc,jpc,pcsource,wpcir,dwreg,dm2reg,dwmem,daluc, daluimm,da,db,dimm,drn,dshift,djal);
	input mwreg,ewreg,em2reg,mm2reg,wwreg,clock,resetn;
	input[4:0] mrn,ern,wrn;
	input[31:0] dpc4, inst, wdi, ealu, malu, mmo;
	output wpcir,dwreg,dm2reg,dwmem,daluimm,dshift,djal;
	output[1:0] pcsource;
	output[3:0] daluc;
	output[4:0] drn;
	output[31:0] bpc,jpc,da,db,dimm;

	wire sext,regrt,rsrtequ;
	wire[1:0] fwda,fwdb;
	wire[31:0] q1,q2;
	wire          e = sext & inst[15];          // positive or negative sign at sext signal
	wire [15:0]   imm = {16{e}};                // high 16 sign bit
    wire [31:0]   offset = {imm[13:0],inst[15:0],1'b0,1'b0};   //offset(include sign extend)
    wire [31:0]   dimm = {imm,inst[15:0]}; // sign extend to high 16
    wire [31:0] jpc = {dpc4[31:28],inst[25:0],1'b0,1'b0}; // j address 
	assign bpc = dpc4 + offset;
	wire mem_clock;
	assign mem_clock = ~clock;
	regfile rf (inst[25:21],inst[20:16],wdi,wrn,wwreg,mem_clock,resetn, /**/ q1,q2);//read and write registers
	mux4x32 forward_da(q1,ealu,malu,mmo,fwda,da);
	mux4x32 forward_db(q2,ealu,malu,mmo,fwdb,db);
	assign rsrtequ = (da == db);
	mux2x5 reg_write_des (inst[15:11],inst[20:16],regrt,drn);
	pipe_cu control_unit(inst[31:26], inst[5:0], inst[25:21], inst[20:16], rsrtequ, /*input add*/mrn, mm2reg, mwreg, ern, em2reg, ewreg, /*separate input and output*/
		dwmem, dwreg, regrt, dm2reg, daluc, dshift, daluimm, pcsource, djal, sext, /*add output*/fwda, fwdb, wpcir);
endmodule
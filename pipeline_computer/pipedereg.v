module pipedereg(dwreg,dm2reg,dwmem,daluc,daluimm,da,db,dimm,drn,dshift, djal,dpc4,clock,resetn,
	ewreg,em2reg,ewmem,ealuc,ealuimm, ea,eb,eimm,ern0,eshift,ejal,epc4);
	input dwreg,dm2reg,dwmem,daluimm,dshift, djal,clock,resetn;
	input[4:0] drn;
	input[3:0] daluc;
	input[31:0] da,db,dimm,dpc4;
	output ewreg,em2reg,ewmem,ealuimm,eshift,ejal;
	output[4:0] ern0;
	output[3:0] ealuc;
	output[31:0] ea,eb,eimm,epc4;

	reg ewreg,em2reg,ewmem,ealuimm,eshift,ejal;
	reg[4:0] ern0;
	reg[3:0] ealuc;
	reg[31:0] ea,eb,eimm,epc4;

	always @ (negedge resetn or posedge clock)
      if (resetn == 0) 
      	begin
          ewreg <= 0;
    	  em2reg <= 0;
    	  ewmem <= 0;
    	  ealuimm <= 0;
    	  eshift <= 0;
    	  ejal <= 0;
    	  ern0 <= 0;
    	  ealuc <= 0;
    	  ea <= 0;
    	  eb <= 0;
    	  eimm <= 0;
    	  epc4 <= 0;
      	end 
      else
      	begin
          ewreg <= dwreg;
    	  em2reg <= dm2reg;
    	  ewmem <= dwmem;
    	  ealuimm <= daluimm;
    	  eshift <= dshift;
    	  ejal <= djal;
    	  ern0 <= drn;
    	  ealuc <= daluc;
    	  ea <= da;
    	  eb <= db;
    	  eimm <= dimm;
    	  epc4 <= dpc4;
      	end

    initial
    	begin
    	  ewreg <= 0;
    	  em2reg <= 0;
    	  ewmem <= 0;
    	  ealuimm <= 0;
    	  eshift <= 0;
    	  ejal <= 0;
    	  ern0 <= 0;
    	  ealuc <= 0;
    	  ea <= 0;
    	  eb <= 0;
    	  eimm <= 0;
    	  epc4 <= 0;
    	end
endmodule
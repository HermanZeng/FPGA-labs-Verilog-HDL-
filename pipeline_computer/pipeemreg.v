module pipeemreg(ewreg,em2reg,ewmem,ealu,eb,ern,clock,resetn,/*separate*/ mwreg,mm2reg,mwmem,malu,mb,mrn);
	input ewreg,em2reg,ewmem,clock,resetn;
	input[4:0] ern;
	input[31:0] ealu,eb;
	output mwreg,mm2reg,mwmem;
	output[4:0] mrn;
	output[31:0] malu,mb;

	reg mwreg,mm2reg,mwmem;
	reg[4:0] mrn;
	reg[31:0] malu,mb;

	always @ (negedge resetn or posedge clock)
      if (resetn == 0) 
      	begin
          mwreg <= 0;
    	  mm2reg <= 0;
    	  mwmem <= 0;
    	  mrn <= 0;
    	  malu <= 0;
    	  mb <= 0;
      	end 
      else
      	begin
          mwreg <= ewreg;
    	  mm2reg <= em2reg;
    	  mwmem <= ewmem;
    	  mrn <= ern;
    	  malu <= ealu;
    	  mb <= eb;
      	end

    initial
    	begin
    	  mwreg <= 0;
    	  mm2reg <= 0;
    	  mwmem <= 0;
    	  mrn <= 0;
    	  malu <= 0;
    	  mb <= 0;
    	end
endmodule
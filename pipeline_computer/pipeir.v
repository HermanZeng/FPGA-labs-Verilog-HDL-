module pipeir(pc4,ins,wpcir,clock,resetn,dpc4,inst);
	input wpcir, clock, resetn;
	input[31:0] pc4, ins;
	output[31:0] dpc4, inst;
	reg[31:0] dpc4, inst;
	always @ (negedge resetn or posedge clock)
      if (resetn == 0) 
      	begin
          dpc4 <= 0;
    	  inst <= 0;
      	end 
      else if(!wpcir)
      	begin
          dpc4 <= pc4;
    	  inst <= ins;
      	end

    initial
    	begin
    	  dpc4 <= 0;
    	  inst <= 0;
    	end
endmodule
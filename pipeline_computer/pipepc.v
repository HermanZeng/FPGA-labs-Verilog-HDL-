module pipepc ( npc,wpcir,clock,resetn,pc );
	input[31:0] npc;
	input wpcir, clock, resetn;
	output[31:0] pc;
	reg[31:0] pc;
	always @ (negedge resetn or posedge clock)
      if (resetn == 0) 
      	begin
          // q <=0;
          pc <= -4;
      	end 
      else if(!wpcir)
      	begin
          pc <= npc;
      	end
endmodule
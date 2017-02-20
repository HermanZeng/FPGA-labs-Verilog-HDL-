module pipeif(pcsource,pc,bpc,da,jpc,npc,pc4,ins,mem_clock);
	input mem_clock;
	input[31:0] pcsource,pc,bpc,da,jpc;
	output[31:0] npc,pc4,ins;
	assign pc4 = pc + 32'h4;
	mux4x32 nextpc(pc4,bpc,da,jpc,pcsource,npc);
	pipe_instmem  imem (pc,ins,mem_clock);//to be finished
endmodule
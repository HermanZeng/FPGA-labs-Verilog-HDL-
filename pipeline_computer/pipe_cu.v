module pipe_cu (op, func, rs, rt, rsrtequ, /*input add*/mrn, mm2reg, mwreg, ern, em2reg, ewreg, /*separate input and output*/ 
  wmem, wreg, regrt, m2reg, aluc, shift, aluimm, pcsource, jal, sext, /*add output*/fwda, fwdb, wpcir);
   input  [5:0] op,func;
   input        rsrtequ;
   input[4:0] rs,rt,mrn,ern;
   input mm2reg, mwreg, em2reg, ewreg;
   output       wreg,regrt,jal,m2reg,shift,aluimm,sext,wmem;
   output [3:0] aluc;
   output [1:0] pcsource;
   output[1:0] fwda,fwdb;
   output wpcir;
   wire r_type = ~|op;
   wire i_add = r_type & func[5] & ~func[4] & ~func[3] &
                ~func[2] & ~func[1] & ~func[0];          //100000
   wire i_sub = r_type & func[5] & ~func[4] & ~func[3] &
                ~func[2] &  func[1] & ~func[0];          //100010
      
   //  please complete the deleted code.
   
   wire i_and = r_type & func[5] & ~func[4] & ~func[3] &
                func[2] & ~func[1] & ~func[0];          //100100 
   wire i_or  = r_type & func[5] & ~func[4] & ~func[3] &
                func[2] & ~func[1] & func[0];          //100101

   wire i_xor = r_type & func[5] & ~func[4] & ~func[3] &
                func[2] & func[1] & ~func[0];          //100110
   wire i_sll = r_type & ~func[5] & ~func[4] & ~func[3] &
                ~func[2] & ~func[1] & ~func[0];          //000000
   wire i_srl = r_type & ~func[5] & ~func[4] & ~func[3] &
                ~func[2] & func[1] & ~func[0];          //000010
   wire i_sra = r_type & ~func[5] & ~func[4] & ~func[3] &
                ~func[2] & func[1] & func[0];          //000011
   wire i_jr  = r_type & ~func[5] & ~func[4] & func[3] &
                ~func[2] & ~func[1] & ~func[0];          //001000
                
   wire i_addi = ~op[5] & ~op[4] &  op[3] & ~op[2] & ~op[1] & ~op[0]; //001000
   wire i_andi = ~op[5] & ~op[4] &  op[3] &  op[2] & ~op[1] & ~op[0]; //001100
   
   wire i_ori  =  ~op[5] & ~op[4] &  op[3] & op[2] & ~op[1] & op[0]; //001101
   wire i_xori =  ~op[5] & ~op[4] &  op[3] & op[2] & op[1] & ~op[0]; //001110 
   wire i_lw   =  op[5] & ~op[4] &  ~op[3] & ~op[2] & op[1] & op[0]; //100011
   wire i_sw   =  op[5] & ~op[4] &  op[3] & ~op[2] & op[1] & op[0]; //101011
   wire i_beq  =  ~op[5] & ~op[4] &  ~op[3] & op[2] & ~op[1] & ~op[0]; //000100
   wire i_bne  =  ~op[5] & ~op[4] &  ~op[3] & op[2] & ~op[1] & op[0]; //000101
   wire i_lui  =  ~op[5] & ~op[4] &  op[3] & op[2] & op[1] & op[0]; //001111
   wire i_j    =  ~op[5] & ~op[4] &  ~op[3] & ~op[2] & op[1] & ~op[0]; //000010
   wire i_jal  =  ~op[5] & ~op[4] &  ~op[3] & ~op[2] & op[1] & op[0]; //000011
   
  
   assign pcsource[1] = i_jr | i_j | i_jal;
   assign pcsource[0] = ( i_beq & rsrtequ ) | (i_bne & ~rsrtequ) | i_j | i_jal ;
   
   assign wreg = (i_add | i_sub | i_and | i_or   | i_xor  |
                 i_sll | i_srl | i_sra | i_addi | i_andi |
                 i_ori | i_xori | i_lw | i_lui  | i_jal) & ~wpcir;
   
   assign aluc[3] = i_sra;
   assign aluc[2] = i_sub | i_or | i_srl | i_sra | i_ori | i_lui;
   assign aluc[1] = i_xor | i_sll | i_srl | i_sra | i_xori | i_lui;
   assign aluc[0] = i_and | i_or | i_sll | i_srl | i_sra | i_andi | i_ori;
   assign shift   = i_sll | i_srl | i_sra ;

   assign aluimm  = i_addi | i_andi | i_ori | i_xori | i_lw | i_sw | i_lui;
   assign sext    = i_addi | i_lw | i_sw | i_beq | i_bne;
   assign wmem    = (i_sw) & ~wpcir;
   assign m2reg   = i_lw;
   assign regrt   = i_addi | i_andi | i_ori | i_xori | i_lw | i_sw | i_lui;
   assign jal     = i_jal;     /*some problems to solve*/

   /*new added for hazard process*/
   assign wpcir = ewreg & em2reg & ((ern == rs) | (ern == rt));
   //wire ealu = ewreg & (~em2reg) & (ern == rs) | (ern == rt);
   //wire malu = mwreg & (~mm2reg) & (mrn == rs) | (mrn == rt);
   //wire mmo = (mwreg & mm2reg & (mrn == rs));
   assign fwda[0] = (ewreg & (~em2reg) & (ern == rs)) | (mwreg & mm2reg & (mrn == rs));
   assign fwda[1] = (mwreg & (~mm2reg) & (mrn == rs)) | (mwreg & mm2reg & (mrn == rs));
   assign fwdb[0] = (ewreg & (~em2reg) & (ern == rt)) | (mwreg & mm2reg & (mrn == rt));
   assign fwdb[1] = (mwreg & (~mm2reg) & (mrn == rt)) | (mwreg & mm2reg & (mrn == rt));

endmodule
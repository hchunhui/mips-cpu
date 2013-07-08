module EX(ir, tmp_a, tmp_b, tmp_c, regaddr, pc, read, write, excp);
   input [31:0]ir;
   input [31:0] tmp_a;
   input [31:0] tmp_b;
   input [31:0] pc;
   output [31:0] tmp_c;
   output [4:0] regaddr;
   output read, write, excp;

   ALU alu(.ALUResult(tmp_c), .ALUResultRegAddr(regaddr), .IRF2ALU(ir), .RsData(tmp_a), .RtData(tmp_b), .PC(pc),
           .Read(read), .Write(write), .excp(excp));
endmodule

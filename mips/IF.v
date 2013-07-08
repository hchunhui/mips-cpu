module IF(reset, clk, jmp_sig, jmp_addr, pc);
   input reset;
   input clk;
   input jmp_sig;
   input [31:0]jmp_addr;
   output [31:0] pc;

   reg [31:0] 	 pc;
   always @(posedge clk or posedge reset)
     begin
	if(reset)
	  pc <= 32'b0;
	else
	  pc <= (jmp_sig ? jmp_addr : pc) + 4;
     end
endmodule

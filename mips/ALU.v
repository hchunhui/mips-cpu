
module ALU (
   // Outputs
   ALUResult, ALUResultRegAddr, Read, Write,
   // Inputs
   IRF2ALU, RsData, RtData, PC, excp
   );

   output [31:0] ALUResult;
   output [4:0]  ALUResultRegAddr;
   output Read;
   output Write;
   output excp;

   input [31:0] IRF2ALU;

   input [31:0] RsData;
   input [31:0] RtData;
   input [31:0] PC;

   reg [31:0] ALUResult;
   reg [4:0]  ALUResultRegAddr;
   wire       carryp, carrys;
   wire       iIsJALR;
   wire       iIsJAL;
   wire       iIsBR_J;

   wire       iIsLW;
   wire       iIsSW;
   
   wire       iIsADD;
   wire       iIsADDI;
   wire       iIsADDIU;
   wire       iIsADDU;

   wire       iIsAND;
   wire       iIsANDI;
   wire       iIsNOR;
   wire       iIsOR;
   wire       iIsORI;

   wire       iIsLUI;		       
   
   wire       iIsSLL;
   wire       iIsSLLV;

   wire       iIsSLT;
   wire       iIsSLTI;
   wire       iIsSLTIU;
   wire       iIsSLTU;

   wire       iIsSRA;
   wire       iIsSRAV;
   wire       iIsSRL;
   wire       iIsSRLV;

   wire       iIsSUB;
   wire       iIsSUBU;

   wire       iIsXOR;
   wire       iIsXORI;

   wire [15:0] imm;
   wire [31:0] signExtendedImm;
   
   wire [31:0] rsPrt;
   wire [31:0] rsMrt;
   wire [31:0] rsPimm;
   reg [31:0]  addResult;
   wire        iIsSomeAdd;

   reg [31:0]  logResult;
   wire        iIsSomeLog;

   wire [4:0]  leftShiftAmount;
   wire [31:0] leftShiftResult;
   wire [4:0]  rightShiftAmount;
   wire [31:0] rightShiftLogResult;
   wire [31:0] rightShiftArithResult;
   reg [31:0]  shiftResult;
   wire        iIsSomeShift;

   wire [32:0] seSetRs;
   wire [32:0] seSetRt;
   wire [32:0] seSetImm;
   wire [32:0] subSetRes;
   reg [31:0]  setResult;
   wire        iIsSomeSet;

   wire [31:0] i;
   wire [5:0]  op;
   wire [4:0]  rsAddr;
   wire [4:0]  rtAddr;
   wire [4:0]  rdAddr;
   wire [4:0]  sa;
   wire [5:0]  funct;

// renaming
   
   assign i = IRF2ALU;
   assign op = i[31:26];
   assign rsAddr = i[25:21];
   assign rtAddr = i[20:16];
   assign rdAddr = i[15:11];
   assign imm = i[15:0];
   assign sa = i[10:6];
   assign funct = i[5:0];

   assign iIsJALR   = (op == 6'b000000) && (funct == 6'b001001);
   assign iIsJAL    = (op == 6'b000011);
   assign iIsBR_J   = (op[5:1] == 5'b00010) || (op == 6'b000010);

   assign iIsLW     = (op == 6'b100011);
   assign iIsSW     = (op == 6'b101011);
   assign Read      = iIsLW;
   assign Write     = iIsSW;
   
   assign iIsADD    = (op == 6'b000000) && (sa == 5'b00000) && (funct == 6'b100000);
   assign iIsADDI   = (op == 6'b001000);
   assign iIsADDIU  = (op == 6'b001001);
   assign iIsADDU   = (op == 6'b000000) && (sa == 5'b00000) && (funct == 6'b100001);

   assign iIsAND    = (op == 6'b000000) && (sa == 5'b00000) && (funct == 6'b100100);
   assign iIsANDI   = (op == 6'b001100);
   assign iIsNOR    = (op == 6'b000000) && (sa == 5'b00000) && (funct == 6'b100111);
   assign iIsOR     = (op == 6'b000000) && (sa == 5'b00000) && (funct == 6'b100101);
   assign iIsORI    = (op == 6'b001101);

   assign iIsLUI    = (op == 6'b001111) && (rsAddr == 5'b00000);
   
   assign iIsSLL    = (op == 6'b000000) && (rsAddr == 5'b00000) && (funct == 6'b000000);
   assign iIsSLLV   = (op == 6'b000000) && (sa == 5'b00000) && (funct == 6'b000100);

   assign iIsSLT    = (op == 6'b000000) && (sa == 5'b00000) && (funct == 6'b101010);
   assign iIsSLTI   = (op == 6'b001010);
   assign iIsSLTIU  = (op == 6'b001011);
   assign iIsSLTU   = (op == 6'b000000) && (sa == 5'b00000) && (funct == 6'b101011);

   assign iIsSRA    = (op == 6'b000000) && (rsAddr == 5'b00000) && (funct == 6'b000011);
   assign iIsSRAV   = (op == 6'b000000) && (sa == 5'b00000) && (funct == 6'b000111);
   assign iIsSRL    = (op == 6'b000000) && (rsAddr == 5'b00000) && (funct == 6'b000010);
   assign iIsSRLV   = (op == 6'b000000) && (sa == 5'b00000) && (funct == 6'b000110);

   assign iIsSUB    = (op == 6'b000000) && (sa == 5'b00000) && (funct == 6'b100010);
   assign iIsSUBU   = (op == 6'b000000) && (sa == 5'b00000) && (funct == 6'b100011);

   assign iIsXOR    = (op == 6'b000000) && (sa == 5'b00000) && (funct == 6'b100110);
   assign iIsXORI   = (op == 6'b001110);

   assign      signExtendedImm = {{16{imm[15]}}, imm[15:0]};
   assign      {carryp, rsPrt} = RsData + RtData;
   assign      {carrys, rsMrt} = RsData - RtData;
   assign      rsPimm = RsData + signExtendedImm;
   assign      excp = (iIsADD || iIsADDI) ? carryp : (iIsSUB ? carrys : 1'b0);
   
   always @ (/*AUTOSENSE*/iIsADD or iIsADDI or iIsADDIU or iIsADDU
	     or iIsSUB or iIsSUBU or rsMrt or rsPimm or rsPrt)
     begin
	casex ({iIsADD, iIsADDI, iIsADDIU, iIsADDU, iIsSUB, iIsSUBU}) /* $s full_case parallel_case */
	  6'b000000 : addResult = 32'bx;
	  6'b100000 : addResult = rsPrt;
	  6'b010000 : addResult = rsPimm;
	  6'b001000 : addResult = rsPimm;
	  6'b000100 : addResult = rsPrt;
	  6'b000010 : addResult = rsMrt;
	  6'b000001 : addResult = rsMrt;
	  default   : addResult = 32'bx;
	endcase // casex({iIsADD, iIsADDI, iIsADDIU, iIsADDU, iIsSUB, iIsSUBU})
     end // always @ (...

   assign iIsSomeAdd = iIsADD || iIsADDI || iIsADDIU || iIsADDU || iIsSUB || iIsSUBU;

   always @ (/*AUTOSENSE*/RsData or RtData or iIsAND or iIsANDI
	     or iIsNOR or iIsOR or iIsORI or iIsXOR or iIsXORI or imm)
     begin
	casex ({iIsAND, iIsANDI, iIsNOR, iIsOR, iIsORI, iIsXOR, iIsXORI}) /* $s full_case parallel_case */
	  7'b0000000 : logResult = 32'bx;
	  7'b1000000 : logResult = RsData & RtData;
	  7'b0100000 : logResult = {16'b0, imm & RsData[15:0]};
	  7'b0010000 : logResult = ~(RsData | RtData);
	  7'b0001000 : logResult = RsData | RtData;
	  7'b0000100 : logResult = {RsData[31:16], (imm | RsData[15:0])};
	  7'b0000010 : logResult = RsData ^ RtData;
	  7'b0000001 : logResult = {RsData[31:16], (imm ^ RsData[15:0])};
	  default    : logResult = 32'bx;
	endcase // casex({iIsAND, iIsANDI, iIsNOR, iIsOR, iIsORI, iIsXOR, iIsXORI})
     end // always @ (...

   assign iIsSomeLog = iIsAND || iIsANDI || iIsNOR || iIsOR || iIsORI || iIsXOR || iIsXORI;
   
   assign leftShiftAmount = iIsSLL ? sa : RsData[4:0];
   assign leftShiftResult = RtData << leftShiftAmount;

   assign rightShiftAmount = (iIsSRA || iIsSRL) ? sa : RsData[4:0];
   assign rightShiftLogResult = RtData >> rightShiftAmount;
   assign rightShiftArithResult = RtData >>> rightShiftAmount;
   
   always @ (/*AUTOSENSE*/iIsSLL or iIsSLLV or iIsSRA or iIsSRAV
	     or iIsSRL or iIsSRLV or leftShiftResult
	     or rightShiftArithResult or rightShiftLogResult)
     begin
	casex ({iIsSLL, iIsSLLV, iIsSRA, iIsSRAV, iIsSRL, iIsSRLV}) /* $s full_case parallel_case */
	  //6'b000000 : shiftResult = 32'bx;
	  6'b100000 : shiftResult = leftShiftResult;
	  6'b010000 : shiftResult = leftShiftResult;
	  6'b001000 : shiftResult = rightShiftArithResult;
	  6'b000100 : shiftResult = rightShiftArithResult;
	  6'b000010 : shiftResult = rightShiftLogResult;
	  6'b000001 : shiftResult = rightShiftLogResult;
	  default   : shiftResult = 32'bx;
	endcase // casex({iIsSLL, iIsSLLV, iIsSRA, iIsSRAV, iIsSRL, iIsSRLV})
     end // always @ (...

   assign iIsSomeShift = iIsSLL || iIsSLLV || iIsSRA || iIsSRAV || iIsSRL || iIsSRLV;

   assign seSetRs = (iIsSLT || iIsSLTI) ? {RsData[31], RsData[31:0]} : {1'b0, RsData[31:0]};
   assign seSetRt = iIsSLT ? {RtData[31], RtData[31:0]} : {1'b0, RtData[31:0]};
   assign seSetImm = iIsSLTI ? {{17{imm[15]}}, imm[15:0]} : {1'b0, {16{imm[15]}}, imm[15:0]};
   assign subSetRes = (iIsSLT || iIsSLTU) ? (seSetRs - seSetRt) : (seSetRs - seSetImm);

   always @ (/*AUTOSENSE*/iIsSLT or iIsSLTI or iIsSLTIU or iIsSLTU
	     or subSetRes)
     begin
	casex ({iIsSLT, iIsSLTI, iIsSLTIU, iIsSLTU}) /* $s full_case parallel_case */
	  4'b0000 : setResult = 32'bx;
	  4'b1000 : setResult = subSetRes[32] ? {31'b0, 1'b1} : 32'b0;
	  4'b0100 : setResult = subSetRes[32] ? {31'b0, 1'b1} : 32'b0;
	  4'b0010 : setResult = subSetRes[32] ? {31'b0, 1'b1} : 32'b0;
	  4'b0001 : setResult = subSetRes[32] ? {31'b0, 1'b1} : 32'b0;
	  default : setResult = 32'bx;
	endcase // casex({iIsSLT, iIsSLTI, iIsSLTIU, iIsSLTU})
     end // always @ (...

   assign iIsSomeSet = iIsSLT || iIsSLTI || iIsSLTIU || iIsSLTU;

   always @ ( RtData or addResult or iIsLUI
	     or iIsLW or iIsSW or iIsSomeAdd or iIsSomeLog
	     or iIsSomeSet or iIsSomeShift or imm or logResult
	     or rsPimm or setResult or shiftResult or iIsJAL or iIsJALR or PC)
     begin
	casex ({iIsSomeAdd, iIsSomeLog, iIsSomeShift, iIsSomeSet, iIsLUI, iIsLW || iIsSW, iIsJAL || iIsJALR})
	  7'b1000000 : ALUResult <= addResult;
	  7'b0100000 : ALUResult <= logResult;
	  7'b0010000 : ALUResult <= shiftResult;
	  7'b0001000 : ALUResult <= setResult;
	  7'b0000100 : ALUResult <= {imm[15:0], 16'b0};
	  7'b0000010 : ALUResult <= rsPimm;
	  7'b0000001 : ALUResult <= PC + 4;
	  default   : ALUResult <= 32'bx;
	endcase // casex({iIsSomeAdd, iIsSomeLog, iIsSomeShift, iIsSomeSet, iIsLUI})
     end // always@(...

   always @ (iIsADDI or iIsADDIU or iIsANDI or iIsLUI or iIsLW or iIsSW or iIsORI
	     or iIsSLTI or iIsSLTIU or iIsXORI or rdAddr or rtAddr or iIsJAL or iIsJALR or iIsBR_J)
     begin
	if (iIsADDI || iIsADDIU || iIsANDI || iIsORI || iIsLUI || iIsSLTI || iIsSLTIU || iIsXORI || iIsLW)
	  ALUResultRegAddr = rtAddr;
	else if (iIsSW || iIsBR_J)
	  ALUResultRegAddr = 5'b0;
	else if (iIsJAL)
	  ALUResultRegAddr = 5'b11111;
	else
	  ALUResultRegAddr = rdAddr;
    end
   
endmodule // ALU

	    

module regs (read1, read2, readdata1, readdata2, write, writedata, regwrite, clk);
	input regwrite, clk;
	input[4:0] read1, read2, write;
	input[31:0] writedata;
	output[31:0] readdata1, readdata2;
	
	//reg[4:0] read1, read2, write;
	reg[31:0] readdata1, readdata2;
	reg[31:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7;
	reg[31:0] reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15;
	reg[31:0] reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23;
	reg[31:0] reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31;
	
	always @(read1 or read2 or reg1 or reg2 or reg3 or reg4 or reg5 or reg6 or reg7 or reg8 or reg9 or reg10 
	or reg11 or reg12 or reg13 or reg14 or reg15 or reg16 or reg17 or reg18 or reg19 or reg20 or reg21 or reg22
	or reg23 or reg24 or reg25 or reg26 or reg27 or reg28 or reg29 or reg30 or reg31)
	begin
	
	casex (read1) //read data1
		5'b00000: readdata1 = 0;
		5'b00001: readdata1 = reg1;
		5'b00010: readdata1 = reg2;
		5'b00011: readdata1 = reg3;
		5'b00100: readdata1 = reg4;
		5'b00101: readdata1 = reg5;
		5'b00110: readdata1 = reg6;
		5'b00111: readdata1 = reg7;
		5'b01000: readdata1 = reg8;
		5'b01001: readdata1 = reg9;
		5'b01010: readdata1 = reg10;
		5'b01011: readdata1 = reg11;
		5'b01100: readdata1 = reg12;
		5'b01101: readdata1 = reg13;
		5'b01110: readdata1 = reg14;
		5'b01111: readdata1 = reg15;
		5'b10000: readdata1 = reg16;
		5'b10001: readdata1 = reg17;
		5'b10010: readdata1 = reg18;
		5'b10011: readdata1 = reg19;
		5'b10100: readdata1 = reg20;
		5'b10101: readdata1 = reg21;
		5'b10110: readdata1 = reg22;
		5'b10111: readdata1 = reg23;
		5'b11000: readdata1 = reg24;
		5'b11001: readdata1 = reg25;
		5'b11010: readdata1 = reg26;
		5'b11011: readdata1 = reg27;
		5'b11100: readdata1 = reg28;
		5'b11101: readdata1 = reg29;
		5'b11110: readdata1 = reg30;
		5'b11111: readdata1 = reg31;
	endcase
	
	casex (read2) //read data2
		5'b00000: readdata2 = 0;
		5'b00001: readdata2 = reg1;
		5'b00010: readdata2 = reg2;
		5'b00011: readdata2 = reg3;
		5'b00100: readdata2 = reg4;
		5'b00101: readdata2 = reg5;
		5'b00110: readdata2 = reg6;
		5'b00111: readdata2 = reg7;
		5'b01000: readdata2 = reg8;
		5'b01001: readdata2 = reg9;
		5'b01010: readdata2 = reg10;
		5'b01011: readdata2 = reg11;
		5'b01100: readdata2 = reg12;
		5'b01101: readdata2 = reg13;
		5'b01110: readdata2 = reg14;
		5'b01111: readdata2 = reg15;
		5'b10000: readdata2 = reg16;
		5'b10001: readdata2 = reg17;
		5'b10010: readdata2 = reg18;
		5'b10011: readdata2 = reg19;
		5'b10100: readdata2 = reg20;
		5'b10101: readdata2 = reg21;
		5'b10110: readdata2 = reg22;
		5'b10111: readdata2 = reg23;
		5'b11000: readdata2 = reg24;
		5'b11001: readdata2 = reg25;
		5'b11010: readdata2 = reg26;
		5'b11011: readdata2 = reg27;
		5'b11100: readdata2 = reg28;
		5'b11101: readdata2 = reg29;
		5'b11110: readdata2 = reg30;
		5'b11111: readdata2 = reg31;
	endcase
	end
	
	always @ (posedge clk)
	begin
	if (regwrite)	//write data
	casex (write)
		5'b00001: reg1 = writedata;
		5'b00010: reg2 = writedata;
		5'b00011: reg3 = writedata;
		5'b00100: reg4 = writedata;
		5'b00101: reg5 = writedata;
		5'b00110: reg6 = writedata;
		5'b00111: reg7 = writedata;
		5'b01000: reg8 = writedata;
		5'b01001: reg9 = writedata;
		5'b01010: reg10 = writedata;
		5'b01011: reg11 = writedata;
		5'b01100: reg12 = writedata;
		5'b01101: reg13 = writedata;
		5'b01110: reg14 = writedata;
		5'b01111: reg15 = writedata;
		5'b10000: reg16 = writedata;
		5'b10001: reg17 = writedata;
		5'b10010: reg18 = writedata;
		5'b10011: reg19 = writedata;
		5'b10100: reg20 = writedata;
		5'b10101: reg21 = writedata;
		5'b10110: reg22 = writedata;
		5'b10111: reg23 = writedata;
		5'b11000: reg24 = writedata;
		5'b11001: reg25 = writedata;
		5'b11010: reg26 = writedata;
		5'b11011: reg27 = writedata;
		5'b11100: reg28 = writedata;
		5'b11101: reg29 = writedata;
		5'b11110: reg30 = writedata;
		5'b11111: reg31 = writedata;
	endcase
	
	end
endmodule
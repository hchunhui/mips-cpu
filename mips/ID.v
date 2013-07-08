module ID(ir, pc, reg_a, reg_b, jmp_sig, jmp_addr, a_port, b_port);
	input [31:0] ir;
	input [31:0] pc;
	input [31:0] reg_a;
	input [31:0] reg_b;
	output jmp_sig;
	output [31:0] jmp_addr;
	output [4:0] a_port;
	output [4:0] b_port;
	reg jmp_sig;
	reg [31:0]jmp_addr;
	wire is_br, is_jr, is_jj;
	
	assign a_port = ir[25:21];
    assign b_port = ir[20:16];
	assign is_br = (ir[31:27] == 5'b00010);
	assign is_jr = ((ir[31:26] == 6'b000000) && (ir[5:1] == 5'b00100));
	assign is_jj = (ir[31:27] == 5'b00001);
	always@(ir or reg_a or reg_b or pc or is_br or is_jr or is_jj)
	begin
		jmp_sig = 1'b0;
		jmp_addr = 32'b0;
		if(is_br)
		begin
			jmp_sig = ((reg_a == reg_b)^ir[26]);
			jmp_addr = pc + {{14{ir[15]}}, ir[15:0], 2'b00};
		end
		else if(is_jr)
		begin
			jmp_sig = 1'b1;
			jmp_addr = reg_a;
		end
		else if(is_jj)
		begin
			jmp_sig = 1'b1;
			jmp_addr = {pc[31:28], ir[25:0], 2'b00};
		end
	end
endmodule
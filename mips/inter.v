module inter(clk, inter, excp, iret, pc_in, pc_out, pc_en, jmp, reset //reset 有效使得流水线中未执行指令被清空
);

input clk, inter, excp, iret;
input[31:0] pc_in;
input jmp;
output reset, pc_en;
output[31:0] pc_out;

reg[31:0] epc;
reg mask;
reg inter_sync;
reg[31:0] pc_out;
reg reset, pc_en;

always @ (posedge clk) //时序逻辑
begin
	inter_sync <= inter;
	if((inter_sync || excp) && !mask && !jmp && pc_in != 0)
	begin
		epc <= pc_in-4;
		mask <= 1;
	end
	if(iret)
		mask <= 0;
end

always @ (inter_sync or epc or excp or iret or mask or jmp or pc_in) //组合逻辑
begin
	reset = 0;
	pc_en = 0;
	pc_out = 0;
	if(inter_sync && !mask && !jmp && pc_in != 0) //中断来临
	begin
		pc_out = 256*4; //固定地址
		pc_en = 1;
		reset = 1;
	end
	if(excp && !mask && !jmp && pc_in != 0)
	begin
		pc_out = 384*4; //异常固定地址
		pc_en = 1;
		reset = 1;
	end
	if(iret && mask) //中断返回
	begin
		pc_out = epc;
		pc_en = 1;
		reset = 1;
	end
end
endmodule
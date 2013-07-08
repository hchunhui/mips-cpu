module inter(clk, inter, excp, iret, pc_in, pc_out, pc_en, jmp, reset //reset ��Чʹ����ˮ����δִ��ָ����
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

always @ (posedge clk) //ʱ���߼�
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

always @ (inter_sync or epc or excp or iret or mask or jmp or pc_in) //����߼�
begin
	reset = 0;
	pc_en = 0;
	pc_out = 0;
	if(inter_sync && !mask && !jmp && pc_in != 0) //�ж�����
	begin
		pc_out = 256*4; //�̶���ַ
		pc_en = 1;
		reset = 1;
	end
	if(excp && !mask && !jmp && pc_in != 0)
	begin
		pc_out = 384*4; //�쳣�̶���ַ
		pc_en = 1;
		reset = 1;
	end
	if(iret && mask) //�жϷ���
	begin
		pc_out = epc;
		pc_en = 1;
		reset = 1;
	end
end
endmodule
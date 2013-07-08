/*
R-TYPE:
+------+-----+-----+-----+-----+------+
|  op  | rs  | rt  | rd  |shamt| func |
+------+-----+-----+-----+-----+------+
J-TYPE:
+------+-----+-----+------------------+
|  op  | rs  | rt  |      imm16       |
+------+-----+-----+------------------+
R-TYPE:
+------+------------------------------+
|  op  |            addr26            |
+------+------------------------------+
*/

module mips(clk, reset, inte,
_pc, _ir,
_tmp_a, _tmp_b, _tmp_c, _c_port, c_port34, c_port45, _a_port, _b_port, _for_a, _for_b, excp);
input clk;
input reset;
input inte;

//for debug
output [31:0]_pc;
output [31:0]_ir;
output [31:0]_tmp_a;
output [31:0]_tmp_b;
output [31:0]_tmp_c;
output [4:0]_c_port;
output [4:0]c_port34;
output [4:0]c_port45;
output [4:0]_a_port;
output [4:0]_b_port;
output [31:0]_for_a;
output [31:0]_for_b;
output excp;

//pipeline
//1-2: IF_ID
reg [31:0] ir12;
reg [31:0] pc12;

//2-3: ID_EX
reg [31:0] ir23;
reg [31:0] pc23;
reg [31:0] tmp_a;
reg [31:0] tmp_b;
reg jmp_sig23;

//3-4: EX_MEM
reg [31:0] tmp_c;
reg [4:0] c_port34;
reg read, write;
reg jmp_sig34;

//4-5: MEM_WB
reg [31:0] tmp_d;
reg [4:0] c_port45;
reg regwrite;

//wire
wire [31:0] _ir;
wire [31:0] _pc;
wire [31:0] _tmp_a;
wire [31:0] _tmp_b;
wire [31:0] _tmp_c;
wire [31:0] _tmp_d;
wire [31:0] _tmp_dd;
wire        _jmp_sig;
wire [31:0] _jmp_addr;

wire [4:0]  _a_port;
wire [4:0]  _b_port;
wire [4:0]  _c_port;
wire _read, _write;

//wire for forwarding
wire [31:0] _for_a;
wire [31:0] _for_b;
//wire for interrupt
wire [31:0] _pc_inter;
wire _pc_inter_en, _inter_reset;
wire excp;

//interrupt logic
inter inter(
	.clk(clk),
	.inter(inte),
	.excp(excp),
	.iret(ir23 == 32'b01000010000000000000000000011000),
	.pc_in(pc23),
	.pc_out(_pc_inter),
	.pc_en(_pc_inter_en),
	.reset(_inter_reset),
	.jmp(jmp_sig34));

//register file
regs rf(
	.clk(clk),
	.regwrite(regwrite),
	.read1(_a_port),
	.read2(_b_port),
	.readdata1(_tmp_a),
	.readdata2(_tmp_b),
	.write(c_port45),
	.writedata(tmp_d));

//memory
ram_dq icache(
	.clock(clk),
	.address(_jmp_sig ? _jmp_addr[10:2]: _pc_inter_en ? _pc_inter[10:2] : _pc[10:2]),
	.wren(1'b0),
	.q(_ir));
ram_dq_d dcache(
	.clock(clk),
	.address(_tmp_c[10:2]),
	.wren(_write),
	.q(_tmp_d),
	.data(tmp_b));

////
IF  p1(
	//inputs
	.reset(reset),
	.clk(clk),
	.jmp_sig(_jmp_sig || _pc_inter_en),
	.jmp_addr(_pc_inter_en ? _pc_inter : _jmp_addr),
	//outputs
	.pc(_pc));

ID  p2(
	//inputs
	.ir(ir12),
	.pc(pc12),
	.reg_a(_for_a),
	.reg_b(_for_b),
	//ouputs
	.a_port(_a_port),
	.b_port(_b_port),
	.jmp_sig(_jmp_sig),
	.jmp_addr(_jmp_addr));

EX  p3(
	//inputs
	.ir(ir23),
	.pc(pc23),
	.tmp_a(tmp_a),
	.tmp_b(tmp_b),
	//outputs
	.tmp_c(_tmp_c),
	.regaddr(_c_port),
	.read(_read),
	.write(_write),
	.excp(excp));

//MEM p4
assign _tmp_dd = read ? _tmp_d : tmp_c;

//WB p5

//forwarding
/* with forwarding */
forward fa(
		.ra_ex(_c_port), .ra_mem(c_port34), .ra_wb(c_port45), .ra_rf(_a_port),
		.r_ex(_tmp_c), .r_mem(_tmp_dd), .r_wb(tmp_d), .r_rf(_tmp_a), .r(_for_a));
forward fb(
		.ra_ex(_c_port), .ra_mem(c_port34), .ra_wb(c_port45), .ra_rf(_b_port),
		.r_ex(_tmp_c), .r_mem(_tmp_dd), .r_wb(tmp_d), .r_rf(_tmp_b), .r(_for_b));
/* without forwarding */
/*assign _for_b = _tmp_b;assign _for_a = _tmp_a;*/
	
always@(posedge clk)
begin
	//IR
	ir12 <= _inter_reset ? 32'b0 : _ir;
	ir23 <= _inter_reset ? 32'b0 : ir12;
	//PC
	pc12 <= _inter_reset ? 32'b0 : _pc;
	pc23 <= _inter_reset ? 32'b0 : pc12;
	//TMP_AB
	tmp_a <= _inter_reset ? 32'b0 : _for_a;
	tmp_b <= _inter_reset ? 32'b0 : _for_b;
	//TMP_C
	tmp_c <= _tmp_c;
	//TMP_D
	tmp_d <= _tmp_dd;
	c_port34 <= _inter_reset ? 5'b0 :_c_port;
	c_port45 <= c_port34;
	regwrite <= !write;
	read <= _inter_reset ? 1'b0 : _read;
	write <= _inter_reset ? 1'b0 : _write;
	
	jmp_sig23 <= _jmp_sig;
	jmp_sig34 <= jmp_sig23;
end
endmodule

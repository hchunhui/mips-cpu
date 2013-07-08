module forward(ra_ex, ra_mem, ra_wb, ra_rf, r_ex, r_mem, r_wb, r_rf, r);
input [4:0] ra_ex;
input [4:0] ra_mem;
input [4:0] ra_wb;
input [4:0] ra_rf;

input [31:0] r_ex;
input [31:0] r_mem;
input [31:0] r_wb;
input [31:0] r_rf;

output [31:0] r;

wire a, b, c, d;
reg [31:0] r;

assign a = (ra_rf != 0) && (ra_ex == ra_rf);
assign b = (ra_rf != 0) && (ra_mem == ra_rf);
assign c = (ra_rf != 0) && (ra_wb == ra_rf);

always@(a or b or c or r_ex or r_mem or r_wb or r_rf)
begin
	if(a == 1)
		r = r_ex;
	else if(b == 1)
		r = r_mem;
	else if(c == 1)
		r = r_wb;
	else
		r = r_rf;
	/*casex({a,b,c})
	3'b1xx: r = r_ex;
	3'b01x: r = r_mem;
	3'b001: r = r_wb;
	3'b000: r = r_rf;
	endcase*/
end

endmodule
module ForwardingUnit (EXE_instr19_15, EXE_instr24_20, MEM_instr11_7, MEM_WBControl, WB_instr11_7, WB_Control, src1_sel_o, src2_sel_o);

	input [5-1:0] EXE_instr19_15, EXE_instr24_20, MEM_instr11_7, WB_instr11_7;
	input  MEM_WBControl, WB_Control;
	output wire [2-1:0] src1_sel_o, src2_sel_o;

/* Write your code HERE */
/*
EXE_instr19_15 -> ID/EX.Rs1
EXE_instr24_20 -> ID/EX.Rs2
MEM_instr11_7 -> EX/MEM.Rd
WB_instr11_7 -> MEM/WB.Rd
MEM_WBControl -> EX/MEM.RegWrite
WB_Control -> MEM/WB.RegWrite
*/

reg [1:0]src1_sel;
reg [1:0]src2_sel;

assign src1_sel_o=src1_sel;
assign src2_sel_o=src2_sel;


always @(*) begin

	if((MEM_WBControl) && (MEM_instr11_7!=0) && (MEM_instr11_7==EXE_instr19_15))begin
		src1_sel<=2'b10;
	end
	else if((WB_Control) && (WB_instr11_7!=0) && (MEM_instr11_7!=EXE_instr19_15) && (WB_instr11_7==EXE_instr19_15))begin
		src1_sel<=2'b01;
	end
	else begin
		src1_sel<=2'b00;
	end


	if((MEM_WBControl) && (MEM_instr11_7!=0) && (MEM_instr11_7==EXE_instr24_20))begin
		src2_sel<=2'b10;
	end
	else if((WB_Control) && (WB_instr11_7!=0) && (MEM_instr11_7!=EXE_instr24_20) && (WB_instr11_7==EXE_instr24_20))begin
		src2_sel<=2'b01;
	end
	else begin
		src2_sel<=2'b00;
	end
end

endmodule
 

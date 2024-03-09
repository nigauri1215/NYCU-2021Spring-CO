/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Decoder(
	input [32-1:0] 	instr_i,
	output wire			ALUSrc,
	output wire			RegWrite,
	output wire			Branch,
	output wire [2-1:0]	ALUOp
	);
	
//Internal Signals
wire	[7-1:0]		opcode;
wire 	[3-1:0]		funct3;
wire	[4-1:0]		func_field;
wire	[9-1:0]		Ctrl_o;

assign opcode=instr_i[6:0];
assign func_field={instr_i[30],instr_i[14:12]};

reg tp_alusrc;
reg tp_reg;
reg tp_brn;
reg [1:0]tp_op;

always @(*) begin	
	case(opcode)
		7'b0110011:begin
		tp_alusrc=0;
		tp_reg=1;
		tp_brn=0;
		tp_op=2'b1x;

		end

	endcase
end

assign ALUSrc=tp_alusrc;
assign RegWrite=tp_reg;
assign Branch=tp_brn;
assign ALUOp[0]=tp_op[0];
assign ALUOp[1]=tp_op[1];




endmodule





                    
                    
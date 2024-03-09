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
wire	[3-1:0]		Instr_field;
wire	[9-1:0]		Ctrl_o;

assign opcode=instr_i[6:0];
assign funct3=instr_i[14:12];

assign ALUsrc=0;
assign Branch=0;
assign RegWrite=0;
assign ALUOp=2'b10;



endmodule





                    
                    
/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Decoder(
	input [32-1:0] 	instr_i,
	output wire			Branch,
	output wire			ALUSrc,
	output wire			RegWrite,
	output wire [2-1:0]	ALUOp,
	output wire			MemRead,
	output wire			MemWrite,
	output wire			MemtoReg,
	output wire 		Jump
	);
	
//Internal Signals
wire	[7-1:0]		opcode;
wire 	[3-1:0]		funct3;
wire	[3-1:0]		Instr_field;
wire	[9:0]		Ctrl_o;

assign opcode = instr_i[6:0];
assign funct3 = instr_i[14:12];

// Check Instr. Field
// 0:R-type, 1:I-type, 2:S-type, 3:B-type	4:J-type				 

reg beq;
reg src;
reg regwrt;
reg [1:0]op;
reg memrd;
reg memwr;
reg mtoreg;
reg jp;

always @(*) begin	
	case(opcode)
		7'b0110011:begin    //R-type
            beq=0;
			src=0;
			regwrt=1;
			memrd=0;
			memwr=0;
			mtoreg=0;
			jp=0;
			op=2'b10;
		end
        7'b0010011:begin    //addi,slti,slli
            beq=0;
			src=1;
			regwrt=1;
			memrd=0;
			memwr=0;
			mtoreg=0;
			jp=0;
			op=2'b11;
        end
        7'b0000011:begin    //load
            beq=0;
			src=1;
			regwrt=1;
			memrd=1;
			memwr=0;
			mtoreg=1;
			jp=0;
			op=2'b00;
        end
        7'b0100011:begin    //store
            beq=0;
			src=1;
			regwrt=0;
			memrd=0;
			memwr=1;
			mtoreg=1'bx;
			jp=0;
			op=2'b00;
        end
        7'b1100011:begin    //branch
            beq=1;
			src=1;
			regwrt=0;
			memrd=0;
			memwr=0;
			mtoreg=0;
			jp=0;
			op=2'b01;
        end
        
        default:begin	//nop
            beq=0;
			src=1;
			regwrt=1;
			memrd=0;
			memwr=0;
			mtoreg=0;
			jp=0;
			op=2'b11;
        end


	endcase
end

assign RegWrite=regwrt;
assign Branch=beq;
assign Jump=jp;
assign MemRead=memrd;
assign MemWrite=memwr;
assign ALUSrc=src;
assign ALUOp[0]=op[0];
assign ALUOp[1]=op[1];
assign MemtoReg=mtoreg;


endmodule





                    
                    
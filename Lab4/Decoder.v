/***************************************************
Student Name:許舒茵
Student ID: 0816080
***************************************************/

   `timescale 1ns/1ps

   module Decoder(
       input   [7-1:0]     instr_i,
       output              RegWrite,
       output              Branch,
       output              Jump,
       output              WriteBack1,
       output              WriteBack0,
       output              MemRead,
       output              MemWrite,
       output              ALUSrcA,
       output              ALUSrcB,
       output  [2-1:0]     ALUOp
   );

   /* Write your code HERE */
wire	[7-1:0]		opcode;
wire 	[3-1:0]		funct3;
wire	[4-1:0]		func_field;
wire	[9-1:0]		Ctrl_o;

assign opcode=instr_i[6:0];

reg regwr;
reg beq;
reg jp;
reg wb1;
reg wb0;
reg memrd;
reg memwr;
reg srcA;
reg srcB;
reg [1:0]op;

always @(*) begin	
	case(opcode)
		7'b0110011:begin    //R-type
            regwr=1;
            beq=0;
            jp=0;
            wb1=0;
            wb0=0;
            memrd=0;
            memwr=0;
            srcA=1'bx;
            srcB=0;
            op=2'b10;
		end
        7'b0010011:begin    //addi
            regwr=1;
            beq=0;
            jp=0;
            wb1=0;
            wb0=0;
            memrd=0;
            memwr=0;
            srcA=1'bx;
            srcB=1;
            op=2'b11;
        end
        7'b0000011:begin    //load
            regwr=1;
            beq=0;
            jp=0;
            wb1=0;
            wb0=1;
            memrd=1;
            memwr=0;
            srcA=1'bx;
            srcB=1;
            op=2'b00;
        end
        7'b0100011:begin    //store
            regwr=0;
            beq=0;
            jp=0;
            wb1=1'bx;
            wb0=1'bx;
            memrd=0;
            memwr=1;
            srcA=1'bx;
            srcB=1;
            op=2'b00;
        end
        7'b1100011:begin    //branch
            regwr=0;
            beq=1;
            jp=0;
            wb1=1'bx;
            wb0=1'bx;
            memrd=0;
            memwr=0;
            srcA=0;
            srcB=0;
            op=2'b01;
        end
        7'b1101111:begin    //jal
            regwr=1;
            beq=1'bx;
            jp=1;
            wb1=1;
            wb0=1'bx;
            memrd=0;
            memwr=0;
            srcA=0;
            srcB=1'bx;
            op=2'bxx;
        end
        7'b1100111:begin    //jalr
            regwr=1;
            beq=1'bx;
            jp=1;
            wb1=1;
            wb0=1'bx;
            memrd=0;
            memwr=0;
            srcA=1;
            srcB=1'bx;
            op=2'b11;
        end
        default:begin
            regwr=0;
            beq=0;
            jp=0;
            wb1=1'bx;
            wb0=1'bx;
            memrd=0;
            memwr=0;
            srcA=1'bx;
            srcB=1'bx;
            op=2'bxx;
        end


	endcase
end

assign RegWrite=regwr;
assign Branch=beq;
assign Jump=jp;
assign WriteBack1=wb1;
assign WriteBack0=wb0;
assign MemRead=memrd;
assign MemWrite=memwr;
assign ALUSrcA=srcA;
assign ALUSrcB=srcB;
assign ALUOp[0]=op[0];
assign ALUOp[1]=op[1];

endmodule


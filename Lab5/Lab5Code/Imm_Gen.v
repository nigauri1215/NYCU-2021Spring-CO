/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Imm_Gen(
	input  [31:0] instr_i,
	output [31:0] Imm_Gen_o
	);

/* Write your code HERE */
wire [6:0] opcode;
reg [31:0] Imm_Gen;

assign opcode=instr_i[6:0];
assign Imm_Gen_o=Imm_Gen;

always @(*) begin
       case(opcode)
        7'b0010011:begin    //addi
            Imm_Gen={{21{instr_i[31]}},instr_i[30:25],instr_i[24:21],instr_i[20]};
        end
        7'b0000011:begin    //load
            Imm_Gen={{21{instr_i[31]}},instr_i[30:25],instr_i[24:21],instr_i[20]};
        end
        7'b0100011:begin    //store
            Imm_Gen={{21{instr_i[31]}},instr_i[30:25],instr_i[11:8],instr_i[7]};
        end
        7'b1100011:begin    //branch
            Imm_Gen={{20{instr_i[31]}},instr_i[7],instr_i[30:25],instr_i[11:8],1'b0};
        end
        default:Imm_Gen=0;
	endcase
   end


endmodule
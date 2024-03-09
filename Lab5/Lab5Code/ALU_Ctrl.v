/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input		[4-1:0]	instr,
	input		[2-1:0]	ALUOp,
	output wire	[4-1:0] ALU_Ctrl_o
	);


/* Write your code HERE */

reg [3:0] ALU_Ctrl;

assign ALU_Ctrl_o=ALU_Ctrl;

always @(*)begin
    case(ALUOp)
    2'b00:begin //lw,sw->add
        ALU_Ctrl=4'b0010;
    end
	2'b10:begin	//R-type:10
		case(instr)
			4'b0000:begin	//add
				ALU_Ctrl=4'b0010;
			end
			4'b1000:begin	//sub
				ALU_Ctrl=4'b0110;
			end
			4'b0111:begin	//and
				ALU_Ctrl=4'b0000;
			end
			4'b0110:begin	//or
				ALU_Ctrl=4'b0001;
			end
			4'b0100:begin	//xor
				ALU_Ctrl=4'b0011;
			end
			4'b0010:begin	//slt
				ALU_Ctrl=4'b0111;
			end
			4'b0001:begin	//sll
				ALU_Ctrl=4'b1000;
			end
			4'b1101:begin	//sra
				ALU_Ctrl=4'b1001;
			end

	endcase
	end
    2'b11:begin  
		case(instr[2:0])
		3'b000:ALU_Ctrl=4'b0010; 	//addi
		3'b010:ALU_Ctrl=4'b0111;	//slti
		3'b001:ALU_Ctrl=4'b1000;	//slli
		endcase
    end
    2'b01:begin  //beq->sub
        ALU_Ctrl=4'b0110;
    end
    endcase
end

endmodule
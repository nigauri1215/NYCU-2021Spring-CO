/***************************************************
Student Name:許舒茵
Student ID: 0816080
***************************************************/

   `timescale 1ns/1ps
   /*instr[30,14:12]*/
   module ALU_Ctrl(
       input       [4-1:0] instr,
       input       [2-1:0] ALUOp,
       output      [4-1:0] ALU_Ctrl_o
   );
   wire [2:0] func3;
   assign func3 = instr[2:0];
   /* Write your code HERE */
   reg [4-1:0] ALU_Ctrl;
   assign ALU_Ctrl_o=ALU_Ctrl;
   always @(*)begin
    case(ALUOp)
    2'b00:begin //lw,sw->add
        ALU_Ctrl=4'b0010;
    end
	2'b10:begin	//R-type:10
		case(instr)
			4'b0000:ALU_Ctrl=4'b0010; //add
			4'b1000:ALU_Ctrl=4'b0110; //sub
			4'b0111:ALU_Ctrl=4'b0000; //and
			4'b0110:ALU_Ctrl=4'b0001; //or
			4'b0010:ALU_Ctrl=4'b0111; //slt
            default:ALU_Ctrl=4'b0000;
	    endcase
	end
    2'b11:begin  //addi
        ALU_Ctrl=4'b0010;
    end
    2'b01:begin  //beq->sub
        ALU_Ctrl=4'b0110;
    end
    default: begin  //J-type:11
        ALU_Ctrl=4'b1111;
    end
    endcase

end

   endmodule


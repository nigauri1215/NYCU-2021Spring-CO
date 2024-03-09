/***************************************************
Student Name:許舒茵
Student ID: 0816080
***************************************************/
   `timescale 1ns/1ps

   module alu(
       input                   rst_n,         // negative reset            (input)
       input        [32-1:0]   src1,          // 32 bits source 1          (input)
       input        [32-1:0]   src2,          // 32 bits source 2          (input)
       input        [ 4-1:0]   ALU_control,   // 4 bits ALU control input  (input)
       output reg   [32-1:0]   result,        // 32 bits result            (output)
       output               Zero          // 1 bit when the output is 0, zero must be set (output)
   );

   /* Write your code HERE */
	assign Zero=~(|result);

	reg signed [32-1:0] a, b;


	always @(negedge rst_n) begin
		if(~rst_n)begin
			result<=0;
		end
	end

	always @(*)begin
			a = src1;
			b = src2;
		case(ALU_control)
				4'b0010:begin	//add
					result=a+b;
				end
				4'b0110:begin	//sub
					result=a-b;
				end
				4'b0000:begin	//and
					result=a&b;
				end
				4'b0001:begin	//or
					result=a|b;
				end
				4'b0111:begin	//slt
					result[0]=a<b;
					result[31:1]=0;
				end
				default: result=result;
		endcase

	end


endmodule


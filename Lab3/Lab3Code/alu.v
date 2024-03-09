/***************************************************
Student Name:
Student ID:
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	signed    [32-1:0]	src1,          // 32 bits source 1          (input)
	input	signed     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */
always @(negedge rst_n) begin
	if(~rst_n)begin
		result<=0;
		zero<=0;
		cout<=0;
		overflow<=0;

	end
end

always @(*)begin
	case(ALU_control)
			4'b0010:begin	//add
				{cout,result}={1'b0,src1}+{1'b0,src2};
			end
			4'b0110:begin	//sub
				{cout,result}={1'b0,src1}+{1'b0,~src2}+1;
			end
			4'b0000:begin	//and
				result=src1&src2;
			end
			4'b0001:begin	//or
				result=src1|src2;
			end
			4'b0011:begin	//xor
				result=src1^src2;
			end
			4'b0111:begin	//slt
				result=src1<src2;
				end
			4'b1000:begin	//sll
				result=src1<<src2;
			end
			4'b1001:begin	//sra
				result=src1>>>src2;
			end
			default: ;
	endcase

end

always @(*) begin
	if(ALU_control==4'b0010)begin
		//add
		if(src1[31]==0 && src2[31]==0 && result[31]==1)
			overflow=1;
		else if(src1[31]==1 && src2[31]==1 && result[31]==0)
			overflow=1;
		
		else
			overflow=0;
	end
	else if(ALU_control==4'b0110)begin
		//sub
		if(src1[31]==0 && src2[31]==1 && result[31]==1)
			overflow=1;
		else if(src1[31]==1 && src2[31]==0 && result[31]==0)
			overflow=1;
		else
			overflow=0;
	end
	else begin
		overflow=0;
		cout=0;
	end
	zero<=~(|result);
end



endmodule

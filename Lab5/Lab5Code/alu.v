/***************************************************
Student Name:
Student ID:
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */

reg signed [32-1:0] a, b;

always @(negedge rst_n) begin
	if(~rst_n)begin
		result<=0;
		zero<=0;
		cout<=0;
		overflow<=0;

	end
end

always @(*)begin
	
		a = src1;
		b = src2;
	case(ALU_control)
			4'b0010:{cout,result}={1'b0,a}+{1'b0,b};		//add
			4'b0110:{cout,result}={1'b0,a}+{1'b0,~b}+1;	//sub
			4'b0000:result=a&b;	//and
			4'b0001:result=a|b;	//or
			4'b0011:result=a^b;	//xor
			4'b0111:begin	//slt
					result[0]=a<b;
					result[31:1]=0;
				end
			4'b1000:result=a<<b;	//sll,slli
			4'b1001:result=a>>>b;	//sra
			default: result=0;
	endcase

end

always @(*) begin
	a = src1;
	b = src2;
	if(ALU_control==4'b0010)begin
		//add
		if(a[31]==0 && b[31]==0 && result[31]==1)
			overflow=1;
		else if(a[31]==1 && b[31]==1 && result[31]==0)
			overflow=1;
		
		else
			overflow=0;
	end
	else if(ALU_control==4'b0110)begin
		//sub
		if(a[31]==0 && b[31]==1 && result[31]==1)
			overflow=1;
		else if(a[31]==1 && b[31]==0 && result[31]==0)
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

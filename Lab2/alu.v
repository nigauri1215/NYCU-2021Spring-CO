/***************************************************
Student Name:
Student ID:0816080
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

always @(negedge rst_n) begin
	if(~rst_n)begin
		result<=0;
		zero<=0;
		cout<=0;
		overflow<=0;

	end
end

wire  [32-1:0]c;
wire  [32-1:0]temp;
ALU_1bit alu_32(
		.src1(src1[0]),
		.src2(src2[0]),
		.Ainvert(ALU_control[3]),
		.Binvert(ALU_control[2]),
		.Cin(ALU_control[3]^ALU_control[2]),
		.operation(ALU_control[1:0]),
		.result(temp[0]),
		.cout(c[0])
	);



genvar id;
generate
	for(id=1;id<32;id=id+1)begin
		ALU_1bit alu_32(
			.src1(src1[id]),
			.src2(src2[id]),
			.Ainvert(ALU_control[3]),
			.Binvert(ALU_control[2]),
			.Cin(c[id-1]),
			.operation(ALU_control[1:0]),
			.result(temp[id]),
			.cout(c[id])
		);
	end
endgenerate

reg signed  [32-1:0]a,b,r;
always @(*) begin
	a=src1;
	b=src2;
	r=temp;
	case(ALU_control[1:0])
		2'b11:begin 
			result[31:1]=0;
			result[0]=temp[31];
			cout=0;
			zero=~(|result);
		end
		default:begin
		result=temp;
		cout=c[31];
		zero=~(|result);
		end
endcase
end
always @(*) begin
	if(ALU_control[2:0]==3'b010)begin
		//add
		if(a>0 && b>0 && r<0)
			overflow=1;
		else if(a<0 && b<0 && r>0)
			overflow=1;
		else
			overflow=0;
	end
	else if(ALU_control[2:0]==3'b110)begin
		//sub
		if(a>0 && b<0 && r<0)
			overflow=1;
		else if(a<0 && b>0 && r>0)
			overflow=1;
		else
			overflow=0;
	end
	else begin
		overflow=0;
	end
end


endmodule

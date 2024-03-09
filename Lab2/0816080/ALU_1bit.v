/***************************************************
Student Name: 
Student ID: 
***************************************************/
`timescale 1ns/1ps

module ALU_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				Cin,        //1 bit carry in  (input)
	input 	    [2-1:0] operation,  //2 bit operation (input)
	output reg          result,     //1 bit result    (output)
	output reg          cout        //1 bit carry out (output)
	);

/* Write your code HERE */
/*
由於電路是同時通電過去的，所以同一個時間 wire 或是 reg 只能給值一次，不能有重複給值的情況發生
*/
//運算後將結果放在reg result裡
reg temp1;
reg temp2;
always @(*) begin
	if(Ainvert==1'b1) begin
		temp1=(~ src1);
	end
	else begin
		temp1=src1;
	end
	if(Binvert==1'b1) begin
		temp2=(~ src2);
	end
	else begin
		temp2=src2;
	end
	case(operation)
		2'b00:begin
			result=temp1 & temp2;		//and nand
			cout=Cin;
		end
		
		2'b01:begin
			result=temp1 | temp2;		//or nor
			cout=Cin;
		end
		
		2'b10,2'b11:begin
			result=temp1 + temp2 + Cin;		//add sub
			if(Cin==1)begin
					if(temp1 | temp2)
					cout=1;
					else
					cout=0;
			end
			else if(Cin==0) begin
					if(temp1 & temp2)
					cout=1;
					else
					cout=0;
			end
		end
	endcase
	
	
end


endmodule


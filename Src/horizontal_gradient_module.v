`timescale 1ns / 1ps
module horizontal_gradient(
	input clk,rst,
        input [71:0] H,
        output reg [8:0] Gx
    );
    reg [8:0]value1,value2, value3;

    always @ (posedge clk) 
    begin
        if(rst)
        	Gx<=8'b0;
        else
        begin
		value1 = (H[71:64] + 2*H[47:40]+ H[23:16]);
		value2 = (H[55:48] + 2*H[31:24] + H[7:0]);
		value3 = value1-value2;
		//if((value1>value2) && (value3>9'd256)) 
		   // Gx = 8'd255;
		if(value1>value2)
		    Gx = value3;
		else if(value2 > value1) 
		    //Res = (8'd255 - var3[7:0])+1;
		    Gx = ~(value2)+1;
		else 
		    Gx = 8'd0;
        end
       
    end
endmodule
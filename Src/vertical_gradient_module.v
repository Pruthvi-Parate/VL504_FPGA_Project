`timescale 1ns / 1ps

module vertical_gradient(
    input clk,rst,
    input [71:0] V,
    output reg [8:0] Gy
);
reg [8:0]value1,value2, value3;

    always @ (posedge clk) 
    begin
    	if(rst)
    		Gy<=8'b0;
        else
        begin
		value1 = (V[71:64] + 2*V[63:56]+ V[55:48]);
		value2 = (V[23:16] + 2*V[15:8] + V[7:0]);
		value3 = value1-value2;
		//if((value1>value2) && (value3>9'd256)) 
		    //Gy = 8'd255;
		if(value1>value2)
		    Gy = value3;
		else if(value2 > value1) 
		    //Res = (8'd255 - var3[7:0])+1;
		    Gy =~(value3)+1;
		else 
		    Gy = 8'd0;
        end
       
    end
endmodule
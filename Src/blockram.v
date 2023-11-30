`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2023 12:24:15 PM
// Design Name: 
// Module Name: blockram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module blockram(
    clk,rst,
    wea,
    addressin,
    addressout,
    datain,
    dataout

    );
    input clk,rst;
    input wea;
    input [13:0]addressin,addressout;
    input [7:0]datain;
    output reg [7:0] dataout;
    
    (* ram_style = "block" *)reg [7:0]memory[0:16383];
    
    
   integer i;
    initial begin
        for (i=0;i<16384;i=i+1)
            memory[i] <= 8'd0;
    end
    
    always@(posedge clk)
    begin
        if(rst)
        begin
            dataout<=8'b0;
            
        end
        else
        begin
            if(wea) memory[addressin]<=datain;
            else 
            begin
            dataout<=memory[addressout];
           
            end
        end
    end
    
    
endmodule


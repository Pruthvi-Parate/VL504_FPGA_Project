`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2023 08:24:02 PM
// Design Name: 
// Module Name: image_processing_module
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


module image_processing_module(

    input clk,rst,
    input transfer_done,
    input [71:0]input_matrix,
    output [7:0]output_pixel_data,
    output reg [15:0]pixel_address,
    output reg processing_done,
    output reg start

    );
    
    //internal signals
    reg [71:0]matrix;
    reg [7:0]output_pixel;
    reg [16:0]pixel_counter;
    reg flag;
    
    
    sobel_operator uut1(clk,rst,matrix,output_pixel_data);
    
    assign output_pixel_data = flag ? output_pixel : 8'b0;
    
    always@(posedge clk)
    begin
        if(rst)
        begin
            output_pixel<=8'b0;
            pixel_address<=16'b0;
            processing_done<=1'b0;
            pixel_counter<=16'b0;
            start<=1'b0;
            flag<=0;
        end
        else
        begin  
            if(transfer_done && processing_done==1'b0)
            begin
                if(pixel_counter>=9'd257 && pixel_counter<16'd65280 && (pixel_counter%256!=0) && (pixel_counter%512!=0))
                begin    
                    pixel_address<=pixel_address+16'b1;
                    matrix<=input_matrix;
                    flag<=1;
                end
                else
                begin
                    //output_pixel<=8'hFF;
                    flag<=0;
                    //matrix<=72'b0;
                end
                if(pixel_counter==17'd65536) processing_done<=1'b1;
                start<=1'b1;
            end
        end
    end
endmodule

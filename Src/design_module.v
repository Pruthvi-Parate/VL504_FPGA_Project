`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2023 08:53:54 PM
// Design Name: 
// Module Name: design_module
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


module design_module(
    input clk,rst,
    input transfer_done,
    input [15:0]address,
    input [23:0]input_din1,input_din2,input_din3,
    output hsync,vsync,
    output [11:0]vga_output
    );
    
    //internal signals
    //input_image_block
    wire clk2;
    wire [15:0]input_address1,input_address2;
    wire [71:0]input_dout1,input_dout2,input_dout3;
    
    //output_image_block
    wire clk3;
    wire [15:0]output_address1,output_address2;
    wire [71:0]output_din,output_dout;
    
    //image_processing_module
    wire [7:0]output_pixel;
    wire processing_done;
    wire [71:0]input_image_matrix;
    
    //data_receiver_module
    
    
    
    
    //data_receiver_module uut4(clk,rst,transfer_done,);
    
    
    //input data
    blk_mem_gen_0 input_image_block1 (
  .clka(clk2),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(~transfer_done),      // input wire [0 : 0] wea
  .addra(input_address1),  // input wire [15 : 0] addra
  .dina(input_din1),    // input wire [71 : 0] dina
  .clkb(clk2),    // input wire clkb
  .enb(transfer_done),      // input wire enb
  .addrb(input_address2),  // input wire [15 : 0] addrb
  .doutb(input_dout1)  // output wire [71 : 0] doutb
    );
    
    blk_mem_gen_1 input_image_block2 (
  .clka(clk2),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(~transfer_done),      // input wire [0 : 0] wea
  .addra(input_address1),  // input wire [15 : 0] addra
  .dina(input_din2),    // input wire [23 : 0] dina
  .clkb(clk2),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .addrb(input_address2),  // input wire [15 : 0] addrb
  .doutb(input_dout2)  // output wire [23 : 0] doutb
);

    blk_mem_gen_2 input_image_block3 (
  .clka(clk2),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(~transfer_done),      // input wire [0 : 0] wea
  .addra(input_address1),  // input wire [15 : 0] addra
  .dina(input_din3),    // input wire [23 : 0] dina
  .clkb(clk2),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .addrb(input_address2),  // input wire [15 : 0] addrb
  .doutb(input_dout3)  // output wire [23 : 0] doutb
);
    assign input_image_matrix = transfer_done?{input_dout1,input_dout2,input_dout3}: 72'b0;
    
    image_processing_module uut2(clk,rst,transfer_done,input_image_matrix,output_pixel,input_address2,processing_done,start_display);
    
    vga_display_module uut3(clk,rst,start_display,output_pixel,hsync,vsync,vga_output[11:8],vga_output[7:4],vga_output[3:0]);
    
    
    //output data
    /*blk_mem_gen_1 output_image_block (
  .clka(clk3),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(~processing_done),      // input wire [0 : 0] wea
  .addra(input_address1),  // input wire [15 : 0] addra
  .dina(input_din),    // input wire [71 : 0] dina
  .clkb(clkb),    // input wire clkb
  .enb(processing_done),      // input wire enb
  .addrb(input_address2),  // input wire [15 : 0] addrb
  .doutb(input_dout)  // output wire [71 : 0] doutb
    );*/
    
    
    
endmodule

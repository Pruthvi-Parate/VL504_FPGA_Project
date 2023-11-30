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
    input clk,rst,transfer_done,
    input [13:0]addressin,
    input [7:0]input_pixel,
    input select_input,
    //output start_display,
    output vsync,hsync,
    output [11:0]vga_output,
    output done_output,
    output processing_done
    
    
   
    
);

    //internal signals
    wire [71:0]input_image_matrix;
   
    
    wire [13:0]write_address,read_address;
    wire [7:0]write_data,read_data;
    wire [13:0]vga_address,vga;
    wire [7:0]vga_data;
    wire done;
    wire [7:0] output_pixel,output_pixel2;
    wire [7:0] output_pixel_data;
    wire [13:0] addressout,addressout2;
    wire clk_out1,clk_out2;

 
    assign done_output = transfer_done;
    
   
    
    blockram input_memory(clk,rst,~transfer_done,addressin,addressout,input_pixel,output_pixel);
    
    image_processing_module uut2(clk,rst,transfer_done,output_pixel,output_pixel_data,done,write_address,addressout2);
    
    vga_display_module uut3(clk,rst,vga_data,vga_address,hsync,vsync,vga_output[11:8],vga_output[7:4],vga_output[3:0]);

    assign addressout = select_input ? (done ? vga_address :addressout2) : (done ? 14'b1 :addressout2);
    assign read_address = select_input ? 14'b0 : vga_address;
    
    assign vga_data = select_input ? output_pixel : read_data;
    assign processing_done = done;
     
     
    
    
    blk_mem_gen_0 output_image_memory (
  .clka(clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(~done),      // input wire [0 : 0] wea
  .addra(write_address),  // input wire [15 : 0] addra
  .dina(output_pixel_data),    // input wire [23 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .addrb(read_address),  // input wire [15 : 0] addrb
  .doutb(read_data)  // output wire [23 : 0] doutb
);
    



endmodule

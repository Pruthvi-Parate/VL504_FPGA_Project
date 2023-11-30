`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2023 08:50:41 PM
// Design Name: 
// Module Name: sobel_operator_module
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


module sobel_operator(
	input clk,rst,
	input [71:0]A,
	output [7:0]result
);

wire [8:0]result_hg,result_vg;

horizontal_gradient hg(clk,rst,A,result_hg);
vertical_gradient hv(clk,rst,A,result_vg);
gradient g(clk,rst,result_hg,result_vg,result);

endmodule

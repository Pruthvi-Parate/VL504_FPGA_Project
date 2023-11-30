`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2018 04:26:40 PM
// Design Name: 
// Module Name: check
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01  - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module vga_display_module(
clock,reset, pixel_input,        //inputs - sel_module(select required function), reset(to switch on and off), val(give a value to adjust brightness and filters)
read_address,
hsync,vsync,                        // hsync and vsync for the working of monitor
red, green, blue                    // red, green and blue output pixels
);

    input clock;
    input [7:0] pixel_input;
    input reset;
    wire pixel_clk;
    output [13:0]read_address;
    
    reg [7:0] gray, left, right, up, down, leftup, leftdown, rightup, rightdown;       //different values in matrix
    reg[7:0] red_o, blue_o, green_o;            // variables used during calcultion
    reg [15:0] r, b, g;                         // variables used during calcultion
    
    
   reg clk;
   initial begin
   clk =0;
   end
   always@(posedge clock)
   begin
    clk<=~clk;
   end
   
   


 
   output reg hsync;
   output reg vsync;
   reg [7:0] tred,tgreen,tblue;
	output reg [3:0] red,green;
	output reg [3:0] blue;

 
	reg read = 0;
	reg [13:0] addra = 0;
	
   reg 		pcount = 0;
   wire 	ec = (pcount == 0);
   always @ (posedge clk) pcount <= ~pcount;
   assign 	pixel_clk = ec;
   
   reg 		hblank=0,vblank=0;
   initial begin
   hsync =0;
   vsync=0;
   end
   reg [9:0] 	hc=0;      
   reg [9:0] 	vc=0;	 
    
  

	
   wire 	hsyncon,hsyncoff,hreset,hblankon;
   assign 	hblankon = ec & (hc == 639);    
   assign 	hsyncon = ec & (hc == 655);
   assign 	hsyncoff = ec & (hc == 751);
   assign 	hreset = ec & (hc == 799);
   
   wire 	blank =  (vblank | (hblank & ~hreset));    
   
   wire 	vsyncon,vsyncoff,vreset,vblankon;
   assign 	vblankon = hreset & (vc == 479);    
   assign 	vsyncon = hreset & (vc == 490);
   assign 	vsyncoff = hreset & (vc == 492);
   assign 	vreset = hreset & (vc == 523);

   always @(posedge clk) begin
   hc <= ec ? (hreset ? 0 : hc + 1) : hc;
   hblank <= hreset ? 0 : hblankon ? 1 : hblank;
   hsync <= hsyncon ? 0 : hsyncoff ? 1 : hsync; 
   
   vc <= hreset ? (vreset ? 0 : vc + 1) : vc;
   vblank <= vreset ? 0 : vblankon ? 1 : vblank;
   vsync <= vsyncon ? 0 : vsyncoff ? 1 : vsync;
end

    assign read_address = addra;

always @(posedge pixel_clk)
	begin		
            if(blank == 0 && hc >= 100 && hc < 228 && vc >= 100 && vc < 228)
            begin
            
                
                gray = pixel_input;

            
                    if(reset ) begin
                        red = 0;
                        green = 0;
                        blue = 0;
                    end else begin
 
                        
                        red=gray[7:4];
                        green=gray[7:4];
                        blue=gray[7:4];
                                    
                    end
                
                    

                
                if(addra <=14'd16383)
                    addra <= addra + 14'd1;
                else
                    addra <= 14'b0;
            end
            
            else
            begin
            
                red = 0;
                green = 0;
                blue = 0;
                
            end
        end    
       
    endmodule


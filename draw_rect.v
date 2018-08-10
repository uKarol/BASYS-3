`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2018 23:04:48
// Design Name: 
// Module Name: draw_rect
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

  
module draw_rect 
      # ( parameter

    width=0,
    heigth=0,
    color=0,
    max_x = 800,
    max_y = 600
)
(
    input wire  [11:0]  x_pos,
    input wire  [11:0]  y_pos,
    input wire clk,
    input wire colission,    
    input [10:0] hcount_in,
    input hsync_in,
    input hblnk_in,
    input [10:0] vcount_in,
    input vsync_in,
    input vblnk_in,
    input [11:0] rgb_in,
    
    input [11:0] rgb_pixel,
    
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out,
    
    output reg [11:0] pixel_addr = 0,
    
    output reg [11:0] x_pos_out,
    output reg [11:0] y_pos_out
    );

reg [11:0] rgb_nxt;

reg [11:0]pixel_addr_nxt;

reg [11:0] x_pos_reg;
reg [11:0] y_pos_reg;

reg hsync_delay1;
reg hblnk_delay1;
reg [10:0] hcount_delay1;
reg vsync_delay1;
reg vblnk_delay1;
reg [10:0] vcount_delay1;
reg [11:0] rgb_delay1;

reg hsync_delay2;
reg hblnk_delay2;
reg [10:0] hcount_delay2;
reg vsync_delay2;
reg vblnk_delay2;
reg [10:0] vcount_delay2;
reg [11:0] rgb_delay2;

always @*
begin
    if ( (hcount_in >= x_pos_reg) && (hcount_in < (x_pos_reg+width)) && (vcount_in >= y_pos_reg)&&(vcount_in < (y_pos_reg +heigth))  ) begin
        pixel_addr_nxt[11:6] = vcount_in - y_pos_reg;
        pixel_addr_nxt[5:0] = hcount_in - x_pos_reg; 
        end
    else 
        pixel_addr_nxt = pixel_addr;
     
  

    //rgb_nxt = ( (hcount_delay2>= x_pos_reg) && (hcount_delay2 < (x_pos_reg+width)) && (vcount_delay2 >= y_pos_reg)&&(vcount_delay2 < (y_pos_reg +heigth))  ) ? rgb_pixel : rgb_delay2;
    
         if( (hcount_delay2>= x_pos_reg) && (hcount_delay2 < (x_pos_reg+width)) && (vcount_delay2 >= y_pos_reg)&&(vcount_delay2 < (y_pos_reg +heigth))  ) 
         begin 
            if(colission==1) rgb_nxt = {4'hf,rgb_pixel[7:0]};
            else rgb_nxt = rgb_pixel; 
         end
         else
            rgb_nxt = rgb_delay2;
    
    
end


always @(posedge clk) 
begin   
    
   x_pos_reg <= x_pos;
   y_pos_reg <= y_pos; 
   
   x_pos_out <= x_pos_reg;
   y_pos_out <= y_pos_reg; 

   hcount_delay1 <= hcount_in;
   hsync_delay1 <= hsync_in;
   hblnk_delay1 <= hblnk_in;
   vcount_delay1 <= vcount_in;
   vsync_delay1 <= vsync_in;
   vblnk_delay1 <= vblnk_in;
   rgb_delay1 <= rgb_in;
   
   hcount_delay2 <= hcount_delay1;
   hsync_delay2 <= hsync_delay1;
   hblnk_delay2 <= hblnk_delay1;
   vcount_delay2 <= vcount_delay1;
   vsync_delay2 <= vsync_delay1;
   vblnk_delay2 <= vblnk_delay1;
   rgb_delay2 <= rgb_delay1;
      
   hcount_out <= hcount_delay2;
   vcount_out <= vcount_delay2;
   vblnk_out <= vblnk_delay2;
   vsync_out <= vsync_delay2;
   hblnk_out <= hblnk_delay2;
   hsync_out <= hsync_delay2;
   
   rgb_out <= rgb_nxt;
   
   pixel_addr <= pixel_addr_nxt;
 end 
endmodule
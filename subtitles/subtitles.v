`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2018 13:31:59
// Design Name: 
// Module Name: subtitles
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


module subtitles
# ( parameter
    x_pos = 0,
    y_pos = 0,
    
    X_MAX = 128,
    Y_MAX = 16
)

(
    input wire rst,
    input pclk,
    input [10:0]hcount_in,
    input [10:0]vcount_in,
    input vsync_in,
    input hsync_in,
    input hblnk_in,
    input vblnk_in,
    input [11:0]rgb_in,
    input [2:0] status,
    
    output wire[10:0]hcount_out,
    output wire[10:0]vcount_out,
    output wire vsync_out,
    output wire hsync_out,
    output wire vblnk_out,
    output wire hblnk_out,
    output wire[11:0] rgb_out

    
    );
    
  
      
    
    // DRAW RECT CHAR
    
        wire [10:0] hcount_char_out;
        wire [10:0] vcount_char_out;
        wire hsync_char_out;
        wire vsync_char_out;
        wire hblnk_char_out;
        wire vblnk_char_out;
        
        wire [11:0]rgb_char_out;
        wire [7:0] char_xy;
        wire [3:0] char_line;
        wire [7:0] char_pixel;
        wire [6:0] char_code;
        
    
      
      draw_rect_char_sub 
          # (
    
        .x_pos(x_pos),
        .y_pos(y_pos),
        .X_MAX(X_MAX),
        .Y_MAX(Y_MAX)
    )
       my_draw_rect_char_sub (
       
           .clk(pclk),
           .rst(rst),
           .hcount_in(hcount_in),
           .vcount_in(vcount_in),
           .vsync_in(vsync_in),
           .hsync_in(hsync_in),
           .hblnk_in(hblnk_in),
           .vblnk_in(vblnk_in),
           
           
           .rgb_in(rgb_in),
           
           .rgb_out(rgb_char_out),
           .vsync_out(vsync_char_out),
           .hsync_out(hsync_char_out),
           
           .vblnk_out(vblnk_char_out),
           .hblnk_out(hblnk_char_out),
           .hcount_out(hcount_char_out),
           .vcount_out(vcount_char_out),
           .char_xy(char_xy),
           .char_line(char_line),
           .char_pixel(char_pixel)
           
      
      );
      char_rom_sub my_char_sub(
            .char_code(char_code),
            .char_xy(char_xy),
            .status(status)
      );
      
      font_rom my_font_rom(
            .clk(pclk),
            .rst(rst),
            .addr({char_code , char_line}),
            .char_line_pixels(char_pixel)
      );
      
      assign hcount_out = hcount_char_out;
      assign vcount_out = vcount_char_out;
      assign vsync_out = vsync_char_out;
      assign hsync_out = hsync_char_out;
      assign vblnk_out = vblnk_char_out;
      assign hblnk_out = hblnk_char_out;
      assign rgb_out = rgb_char_out;

        
endmodule

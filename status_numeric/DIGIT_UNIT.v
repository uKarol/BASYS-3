`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2018 13:57:16
// Design Name: 
// Module Name: DIGIT_UNIT
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


module DIGIT_UNIT
     # ( parameter
x_pos = 0,
y_pos = 0
)

(
    input rst,
    input clk,
    input [10:0]hcount_in,
    input [10:0]vcount_in,
    input vsync_in,
    input hsync_in,
    input hblnk_in,
    input vblnk_in,
    input [11:0]rgb_in,
    input [3:0] digit_in,

    output [10:0]hcount_out,
    output [10:0]vcount_out,
    output vsync_out,
    output hsync_out,
    output vblnk_out,
    output hblnk_out,
    output [11:0] rgb_out


);

    wire [7:0] char_xy;
    wire [3:0] char_line;
    wire [7:0] char_pixel;
    wire [6:0] char_code;
    
draw_rect_char_num 
# (

  .x_pos(x_pos),
  .y_pos(y_pos)
)
 DRAW_DIGIT (
 
     .rst(rst),
     .clk(clk),
     .hcount_in(hcount_in),
     .vcount_in(vcount_in),
     .vsync_in(vsync_in),
     .hsync_in(hsync_in),
     .hblnk_in(hblnk_in),
     .vblnk_in(vblnk_in),
     
     
     .rgb_in(rgb_in),
     
     .rgb_out(rgb_out),
     .vsync_out(vsync_out),
     .hsync_out(hsync_out),
     
     .vblnk_out(vblnk_out),
     .hblnk_out(hblnk_out),
     .hcount_out(hcount_out),
     .vcount_out(vcount_out),
     .char_xy(char_xy),
     .char_line(char_line),
     .char_pixel(char_pixel)
     

);
char_rom_16x16_num my_char_rom_16(
      .char_code(char_code),
      .char_xy(char_xy),
      .number(digit_in)
);

font_rom_num my_font_rom(
      .rst(rst),
      .clk(clk),
      .addr({char_code , char_line}),
      .char_line_pixels(char_pixel)
);

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2018 19:54:26
// Design Name: 
// Module Name: status_TXT
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


module status_TXT(
    input clk,
    input rst,
    input wire [10:0] hcount_in,
    input wire [10:0] vcount_in,
    input wire hsync_in,
    input wire vsync_in,
    input wire hblnk_in,
    input wire vblnk_in,
    
    input wire [11:0]rgb_in,
    
    output wire [10:0] hcount_out,
    output wire [10:0] vcount_out,
    output wire hsync_out,
    output wire vsync_out,
    output wire hblnk_out,
    output wire vblnk_out,    
    output wire [11:0]rgb_out
 
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
        
    // SCORE
    
        wire [10:0] hcount_score_out;
        wire [10:0] vcount_score_out;
        wire hsync_score_out;
        wire vsync_score_out;
        wire hblnk_score_out;
        wire vblnk_score_out;
        
        wire [11:0]rgb_score_out;
        wire [7:0] score_xy;
        wire [3:0] score_line;
        wire [7:0] score_pixel;
        wire [6:0] score_code;
        
    // HEALTH
        
       wire [10:0] hcount_health_out;
       wire [10:0] vcount_health_out;
       wire hsync_health_out;
       wire vsync_health_out;
       wire hblnk_health_out;
       wire vblnk_health_out;
            
       wire [11:0]rgb_health_out;
       wire [7:0] health_xy;
       wire [3:0] health_line;
       wire [7:0] health_pixel;
       wire [6:0] health_code;
       
     // LVL
    
         
        wire [7:0] lvl_xy;
        wire [3:0] lvl_line;
        wire [7:0] lvl_pixel;
        wire [6:0] lvl_code;
    
    
      draw_rect_char 
        # (
  
      .x_pos(100),
      .y_pos(12),
      .X_MAX(88),
      .Y_MAX(16)
  )
     my_draw_rect_title (
         
         .rst(rst),
         .clk(clk),
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
    char_rom_16x16 my_char_rom_16(
          .char_code(char_code),
          .char_xy(char_xy)
    );
    
    font_rom my_font_rom(
          .rst(rst),
          .clk(clk),
          .addr({char_code , char_line}),
          .char_line_pixels(char_pixel)
    );
    
    
      draw_rect_char 
        # (
  
      .x_pos(500),
      .y_pos(12),
      .X_MAX(40),
      .Y_MAX(16)
  )
     my_draw_rect_score (
     
         .rst(rst),
         .clk(clk),
         .hcount_in(hcount_char_out),
         .vcount_in(vcount_char_out),
         .vsync_in(vsync_char_out),
         .hsync_in(hsync_char_out),
         .hblnk_in(hblnk_char_out),
         .vblnk_in(vblnk_char_out),
         
         
         .rgb_in(rgb_char_out),
         
         .rgb_out(rgb_score_out),
         .vsync_out(vsync_score_out),
         .hsync_out(hsync_score_out),
         
         .vblnk_out(vblnk_score_out),
         .hblnk_out(hblnk_score_out),
         .hcount_out(hcount_score_out),
         .vcount_out(vcount_score_out),
         .char_xy(score_xy),
         .char_line(score_line),
         .char_pixel(score_pixel)
         
    
    );
    text_rom_score my_text_rom_score(
          .char_code(score_code),
          .char_xy(score_xy)
    );
    
    font_rom my_font_rom_score(
          .rst(rst),
          .clk(clk),
          .addr({score_code , score_line}),
          .char_line_pixels(score_pixel)
    );
    
    
      draw_rect_char 
        # (
  
      .x_pos(400),
      .y_pos(12),
      .X_MAX(48),
      .Y_MAX(16)
  )
     my_draw_rect_health (
     
         .rst(rst),
         .clk(clk),
         .hcount_in(hcount_score_out),
         .vcount_in(vcount_score_out),
         .vsync_in(vsync_score_out),
         .hsync_in(hsync_score_out),
         .hblnk_in(hblnk_score_out),
         .vblnk_in(vblnk_score_out),
         
         
         .rgb_in(rgb_score_out),
         
         .rgb_out(rgb_health_out),
         .vsync_out(vsync_health_out),
         .hsync_out(hsync_health_out),
         
         .vblnk_out(vblnk_health_out),
         .hblnk_out(hblnk_health_out),
         .hcount_out(hcount_health_out),
         .vcount_out(vcount_health_out),
         .char_xy(health_xy),
         .char_line(health_line),
         .char_pixel(health_pixel)
         
    
    );
    text_rom_health my_text_rom_health(
          .char_code(health_code),
          .char_xy(health_xy)
    );
    
    font_rom my_font_rom_health(
          .clk(clk),
          .rst(rst),
          .addr({health_code , health_line}),
          .char_line_pixels(health_pixel)
    );
    
    
        draw_rect_char 
      # (
  
    .x_pos(600),
    .y_pos(12),
    .X_MAX(40),
    .Y_MAX(16)
  )
   my_draw_rect_lvl (
        
       .rst(rst),
       .clk(clk),
       .hcount_in(hcount_health_out),
       .vcount_in(vcount_health_out),
       .vsync_in(vsync_health_out),
       .hsync_in(hsync_health_out),
       .hblnk_in(hblnk_health_out),
       .vblnk_in(vblnk_health_out),
       
       
       .rgb_in(rgb_health_out),
       
       .rgb_out(rgb_out),
       .vsync_out(vsync_out),
       .hsync_out(hsync_out),
       
       .vblnk_out(vblnk_out),
       .hblnk_out(hblnk_out),
       .hcount_out(hcount_out),
       .vcount_out(vcount_out),
       .char_xy(lvl_xy),
       .char_line(lvl_line),
       .char_pixel(lvl_pixel)
       
  
  );
  text_rom_lvl my_text_rom_lvl(
        .char_code(lvl_code),
        .char_xy(lvl_xy)
  );
  
  font_rom my_font_rom_lvl(
        .clk(clk),
        .rst(rst),
        .addr({lvl_code , lvl_line}),
        .char_line_pixels(lvl_pixel)
  );
    
    
    
endmodule

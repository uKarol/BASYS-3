`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2018 20:30:15
// Design Name: 
// Module Name: status_numeric
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


module status_numeric(
    input clk,
    input rst,
    input wire [11:0]rgb_in,
    input wire [10:0] hcount_in,
    input wire [10:0] vcount_in,
    input wire hsync_in,
    input wire vsync_in,
    input wire hblnk_in,
    input wire vblnk_in,
    
    input wire [12:0] score,
    input wire [12:0] life,
    input wire [12:0] lvl,
    
    output wire [11:0]rgb_out,
    output wire [10:0] hcount_out,
    output wire [10:0] vcount_out,
    output wire hsync_out,
    output wire vsync_out,
    output wire hblnk_out,
    output wire vblnk_out
    
    
    
    );
    
    // DRAW RECT CHAR

        
        wire [11:0]rgb_out_life;
        wire [10:0] hcount_out_life;
        wire [10:0] vcount_out_life;
        wire hsync_out_life;
        wire vsync_out_life;
        wire hblnk_out_life;
        wire vblnk_out_life;
        
        wire [11:0]rgb_out_score;
        wire [10:0] hcount_out_score;
        wire [10:0] vcount_out_score;
        wire hsync_out_score;
        wire vsync_out_score;
        wire hblnk_out_score;
        wire vblnk_out_score;
        
        wire [7:0] char_xy;
        wire [3:0] char_line;
        wire [7:0] char_pixel;
        wire [6:0] char_code;
    
     NUMBER3DIGIT
         # (
   
       .x_pos(450),
       .y_pos(8)
   )
      my_LIFE (
          .rst(rst),
          .clk(clk),
          .hcount_in(hcount_in),
          .vcount_in(vcount_in),
          .vsync_in(vsync_in),
          .hsync_in(hsync_in),
          .hblnk_in(hblnk_in),
          .vblnk_in(vblnk_in),
          
          
          .rgb_in(rgb_in),
          
          .rgb_out(rgb_out_life),
          .vsync_out(vsync_out_life),
          .hsync_out(hsync_out_life),
          
          .vblnk_out(vblnk_out_life),
          .hblnk_out(hblnk_out_life),
          .hcount_out(hcount_out_life),
          .vcount_out(vcount_out_life),
          .number_in(life)
          
     
     );
   
   
   
      NUMBER3DIGIT
         # (
   
       .x_pos(550),
       .y_pos(8)
   )
      my_SCORE (
          .rst(rst),
          .clk(clk),
          .hcount_in(hcount_out_life),
          .vcount_in(vcount_out_life),
          .vsync_in(vsync_out_life),
          .hsync_in(hsync_out_life),
          .hblnk_in(hblnk_out_life),
          .vblnk_in(vblnk_out_life),
          
          
          .rgb_in(rgb_out_life),
          
          .rgb_out(rgb_out_score),
          .vsync_out(vsync_out_score),
          .hsync_out(hsync_out_score),
          
          .vblnk_out(vblnk_out_score),
          .hblnk_out(hblnk_out_score),
          .hcount_out(hcount_out_score),
          .vcount_out(vcount_out_score),
          .number_in(score)
          
     
     );
    
       
     
     NUMBER3DIGIT
         # (
   
       .x_pos(650),
       .y_pos(8)
   )
      my_LVL (
           .rst(rst),
          .clk(clk),
          .hcount_in(hcount_out_score),
          .vcount_in(vcount_out_score),
          .vsync_in(vsync_out_score),
          .hsync_in(hsync_out_score),
          .hblnk_in(hblnk_out_score),
          .vblnk_in(vblnk_out_score),
          
          
          .rgb_in(rgb_out_score),
          
          .rgb_out(rgb_out),
          .vsync_out(vsync_out),
          .hsync_out(hsync_out),
          
          .vblnk_out(vblnk_out),
          .hblnk_out(hblnk_out),
          .hcount_out(hcount_out),
          .vcount_out(vcount_out),
          .number_in(lvl)
          
     
     );
    
    
endmodule

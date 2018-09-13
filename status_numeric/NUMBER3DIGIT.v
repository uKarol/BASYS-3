`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2018 14:28:12
// Design Name: 
// Module Name: NUMBER3DIGIT
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


module NUMBER3DIGIT
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
    input [12:0] number_in,

    output [10:0]hcount_out,
    output [10:0]vcount_out,
    output vsync_out,
    output hsync_out,
    output vblnk_out,
    output hblnk_out,
    output [11:0] rgb_out
    );
    
    
    wire [10:0]hcount_out_rect;
    wire [10:0]vcount_out_rect;
    wire vsync_out_rect;
    wire hsync_out_rect;
    wire hblnk_out_rect;
    wire vblnk_out_rect;
    wire [11:0]rgb_out_rect;
    
    wire [10:0]hcount_out1;
    wire [10:0]vcount_out1;
    wire vsync_out1;
    wire hsync_out1;
    wire hblnk_out1;
    wire vblnk_out1;
    wire [11:0]rgb_out1;

    wire [10:0]hcount_out2;
    wire [10:0]vcount_out2;
    wire vsync_out2;
    wire hsync_out2;
    wire vblnk_out2;
    wire hblnk_out2;
    wire [11:0] rgb_out2;
    
    
    
    
    
    
    localparam
    delimiter = 3,
    digit_width = 8,
    x_offset = 3,
    y_offset = 3;
    
      rect_num
      # (
  
     .width(36),
     .heigth(24),
     .color(110),
     .max_x(800),
     .max_y(600),
     .x_pos(x_pos),
     .y_pos(y_pos)
    )
     my_rect(
    

    
    
    .clk(clk),
    .rst(rst),
    .rgb_in(rgb_in),
    .vcount_in(vcount_in),
    .vsync_in(vsync_in),
    .vblnk_in(vblnk_in),
    .hcount_in(hcount_in),
    .hsync_in(hsync_in),
    .hblnk_in(hblnk_in),
    
    
    .rgb_out(rgb_out_rect),  
    .vcount_out(vcount_out_rect),
    .vsync_out(vsync_out_rect),
    .vblnk_out(vblnk_out_rect),
    .hcount_out(hcount_out_rect),
    .hsync_out(hsync_out_rect),
    .hblnk_out(hblnk_out_rect)
    
    
    );
    
    
    
      DIGIT_UNIT
        # (
  
            .x_pos(x_pos+x_offset),
            .y_pos(y_pos+y_offset)
        )
  
         MSB_DIGIT (
         .rst(rst),
         .clk(clk),
         .hcount_in(hcount_out_rect),
         .vcount_in(vcount_out_rect),
         .vsync_in(vsync_out_rect),
         .hsync_in(hsync_out_rect),
         .hblnk_in(hblnk_out_rect),
         .vblnk_in(vblnk_out_rect),
         .rgb_in(rgb_out_rect),
         
         .rgb_out(rgb_out1),
         .vsync_out(vsync_out1),
         .hsync_out(hsync_out1),
         
         .vblnk_out(vblnk_out1),
         .hblnk_out(hblnk_out1),
         .hcount_out(hcount_out1),
         .vcount_out(vcount_out1),
         .digit_in(number_in/100)

         
    
    );
    
    
    
    
    
     DIGIT_UNIT
           # (
     
               .x_pos(x_pos+digit_width+delimiter+x_offset),
               .y_pos(y_pos+y_offset)
           )
     
            MID_DIGIT (
            .rst(rst),
            .clk(clk),
            .hcount_in(hcount_out1),
            .vcount_in(vcount_out1),
            .vsync_in(vsync_out1),
            .hsync_in(hsync_out1),
            .hblnk_in(hblnk_out1),
            .vblnk_in(vblnk_out1),
            .rgb_in(rgb_out1),
            
            .rgb_out(rgb_out2),
            .vsync_out(vsync_out2),
            .hsync_out(hsync_out2),
            
            .vblnk_out(vblnk_out2),
            .hblnk_out(hblnk_out2),
            .hcount_out(hcount_out2),
            .vcount_out(vcount_out2),
            .digit_in((number_in/10)%10)                      
       );
       
       
       
            DIGIT_UNIT
             # (
       
                 .x_pos(x_pos+2*(digit_width+delimiter)+x_offset),
                 .y_pos(y_pos+y_offset)
             )
       
              LSB_DIGIT (
              .rst(rst),
              .clk(clk),
              .hcount_in(hcount_out2),
              .vcount_in(vcount_out2),
              .vsync_in(vsync_out2),
              .hsync_in(hsync_out2),
              .hblnk_in(hblnk_out2),
              .vblnk_in(vblnk_out2),
              .rgb_in(rgb_out2),
              
              .rgb_out(rgb_out),
              .vsync_out(vsync_out),
              .hsync_out(hsync_out),
              
              .vblnk_out(vblnk_out),
              .hblnk_out(hblnk_out),
              .hcount_out(hcount_out),
              .vcount_out(vcount_out),
              .digit_in(number_in%10)                      
         );
    
    
endmodule

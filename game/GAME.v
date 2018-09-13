`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.08.2018 17:38:03
// Design Name: 
// Module Name: GAME
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


module GAME(

    input pclk,
    input wire up,
    input wire left,
    input wire right,
    input wire rst,
    input wire landing_en,
    
    input wire [2:0] lvl,
        
    input [10:0] hcount_in,
    input hsync_in,
    input hblnk_in,
    input [10:0] vcount_in,
    input vsync_in,
    input vblnk_in,
    input [11:0] rgb_in,
    
    output [10:0] hcount_out,
    output hsync_out,
    output hblnk_out,
    output [10:0] vcount_out,
    output vsync_out,
    output vblnk_out,
    output [11:0] rgb_out,
    
    
    output colission_out,
    output captured,
    output [4:0] points,
    output landed_out
    );
     
     
     // draw rect
     
     wire [11:0] rgb_out_rect;
     wire [10:0] vcount_out_rect, hcount_out_rect;
     wire vsync_out_rect, hsync_out_rect;
     wire vblnk_out_rect, hblnk_out_rect; 
     
     //obstacles 
     
    wire [11:0] rgb_out_obst;
    wire [10:0] vcount_out_obst, hcount_out_obst;
    wire vsync_out_obst, hsync_out_obst;
    wire vblnk_out_obst, hblnk_out_obst; 
   
   // landing
   
    wire [11:0] rgb_out_landing;
    wire [10:0] vcount_out_landing, hcount_out_landing;
    wire vsync_out_landing, hsync_out_landing;
    wire vblnk_out_landing, hblnk_out_landing; 
    
    // points
    
    wire [11:0] rgb_out_point;
    wire [10:0] vcount_out_point, hcount_out_point;
    wire vsync_out_point, hsync_out_point;
    wire vblnk_out_point, hblnk_out_point; 
   
   //ROM
   
       wire [11:0]pixel_addr;
       wire [11:0]pixel_rgb;
   
   //DRAW RECT CTL
   
       wire [11:0]xpos_ctl_out; 
       wire [11:0]ypos_ctl_out;
       wire [11:0]xpos_rect_out; 
       wire [11:0]ypos_rect_out;
   
        wire [11:0] obst_rom_addr;
        wire [11:0] obst_rom_rgb;
     
     
       image_rom_obst obst_img(
            .rst(rst),
            .clk(pclk) ,
            .address(obst_rom_addr),  // address = {addry[5:0], addrx[5:0]}
            .rgb(obst_rom_rgb)
        );
        
        
     draw_obstacles my_obstacles(
     
     .clk(pclk),
     .rst(rst),
     .lvl(lvl),
         
     .rgb_in(rgb_in),
     .vcount_in(vcount_in),
     .vsync_in(vsync_in),
     .vblnk_in(vblnk_in),
     .hcount_in(hcount_in),
     .hsync_in(hsync_in),
     .hblnk_in(hblnk_in),
     
     .rgb_pixel(obst_rom_rgb),
     .pixel_addr(obst_rom_addr),
     .rgb_out(rgb_out_obst),  
     .vcount_out(vcount_out_obst),
     .vsync_out(vsync_out_obst),
     .vblnk_out(vblnk_out_obst),
     .hcount_out(hcount_out_obst),
     .hsync_out(hsync_out_obst),
     .hblnk_out(hblnk_out_obst)
   
     );
     wire colission_up;
     wire colission_down;
     wire colission_right;
     wire colission_left;
     
     draw_rect
       # (
   
      .width(64),
      .heigth(64)

   
     )
      my_draw_rect(
     
      .x_pos(xpos_ctl_out),
      .y_pos(ypos_ctl_out),
     
     .rst(rst),
     .clk(pclk),
     
     .rgb_in(rgb_out_point),
     .vcount_in(vcount_out_point),
     .vsync_in(vsync_out_point),
     .vblnk_in(vblnk_out_point),
     .hcount_in(hcount_out_point),
     .hsync_in(hsync_out_point),
     .hblnk_in(hblnk_out_point),
     
     .rgb_pixel(pixel_rgb),
     
     .rgb_out(rgb_out),  
     .vcount_out(vcount_out),
     .vsync_out(vsync_out),
     .vblnk_out(vblnk_out),
     .hcount_out(hcount_out),
     .hsync_out(hsync_out),
     .hblnk_out(hblnk_out),
     .colission(colission_up||colission_down|| colission_left || colission_right),
     
     .pixel_addr(pixel_addr),
     .x_pos_out(xpos_rect_out),
     .y_pos_out(ypos_rect_out)
     );
       
   
     
     
     image_rom my_image_rom(
       .clk(pclk),
       .rst(rst),
       .address(pixel_addr),
       .rgb(pixel_rgb)
     );
       
       
       wire landed;
       wire started;
     
     
     draw_rect_ctl my_draw_rect_ctl(
           .right(right),
           .left(left),
           .up(up),
           .x_pos(xpos_ctl_out),
           .y_pos(ypos_ctl_out),
           .clk(pclk),
           .rst(rst),
           .colission_up(colission_up),
           .colission_down(colission_down),
           
           .colission_left( colission_left),
           .colission_right(  colission_right),
           .landed(landed),
           .started(started)
     );
     
     colision_detector my_colission(
       .clk(pclk),
       .x_pos(xpos_rect_out),
       .y_pos(ypos_rect_out),
       .lvl(lvl),
       .rst(rst),
       .colission_up( colission_up),
       .colission_down(colission_down),
       .colission_left( colission_left),
       .colission_right(  colission_right),
       .landed(landed),
       .landing_enable(landing_en)
     );
     
     wire [11:0] landing_rom_addr;
     wire [11:0] landing_rom_rgb;
  
  
   img_rom_landing landing_img(
          .rst(rst),
         .clk(pclk) ,
         .address(landing_rom_addr),  // address = {addry[5:0], addrx[5:0]}
         .rgb(landing_rom_rgb)
     );
     
     
     
     draw_landing my_landing(
         
             .clk(pclk),
             .rst(rst),
             
             .rgb_pixel(landing_rom_rgb),
             .pixel_addr(landing_rom_addr),
             .landing1_enable(!started),
             .landing2_enable(landing_en),
             
            .hcount_in(hcount_out_obst),
            .hsync_in(hsync_out_obst),
            .hblnk_in(hblnk_out_obst),
            .vcount_in(vcount_out_obst),
            .vsync_in(vsync_out_obst),
            .vblnk_in(vblnk_out_obst),
            .rgb_in(rgb_out_obst),
            .hcount_out(hcount_out_landing),
            .hsync_out(hsync_out_landing),
            .hblnk_out(hblnk_out_landing),
            .vcount_out(vcount_out_landing),
            .vsync_out(vsync_out_landing),
            .vblnk_out(vblnk_out_landing),
            .rgb_out(rgb_out_landing)
         
         
         );
         
         wire [4:0]point_en;
         
         wire [11:0] point_rom_addr;
         wire [11:0] point_rom_rgb;
      
      
        point_img_rom point_img(
             .clk(pclk) ,
             .rst(rst),
             .address(point_rom_addr),  // address = {addry[5:0], addrx[5:0]}
             .rgb(point_rom_rgb)
         );
         
         
         draw_points my_points(
         
         
           .clk(pclk),
           .rst(rst),
         
           .rgb_pixel(point_rom_rgb),
           .pixel_addr(point_rom_addr),
           .point_enable(~point_en),
           .lvl(lvl),
         
           .hcount_in(hcount_out_landing),
           .hsync_in(hsync_out_landing),
           .hblnk_in(hblnk_out_landing),
           .vcount_in(vcount_out_landing),
           .vsync_in(vsync_out_landing),
           .vblnk_in(vblnk_out_landing),
           .rgb_in(rgb_out_landing),
           .hcount_out(hcount_out_point),
           .hsync_out(hsync_out_point),
           .hblnk_out(hblnk_out_point),
           .vcount_out(vcount_out_point),
           .vsync_out(vsync_out_point),
           .vblnk_out(vblnk_out_point),
           .rgb_out(rgb_out_point)
         
         );
     
         collect_points my_collect_points(
                 .clk(pclk),
                 .rst(rst),
                 .x_pos(xpos_rect_out),
                 .y_pos(ypos_rect_out),
                 .lvl(lvl),
                 .captured(point_en),
                 .capture_point(captured) 
             );
     
        assign colission_out = colission_up||colission_down||colission_right||colission_left;
        assign points = point_en;
        assign landed_out = landed;
        
endmodule

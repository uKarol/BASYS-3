// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.
module vga_example (
  input wire clk,
  input wire btn,
  input wire btnL,
  input wire btnR,
  input wire btnD,
  input wire [2:0]sw,
  input wire sw3,
  output reg vs,
  output reg hs,
  output reg [3:0] r,
  output reg [3:0] g,
  output reg [3:0] b,
  output wire pclk_mirror,
  output wire [5:0] led,
  inout wire ps2_clk,
  inout wire ps2_data
  );
 

  // Converts 100 MHz clk into 40 MHz pclk.
  // This uses a vendor specific primitive
  // called MMCME2, for frequency synthesis.

  wire clk_in;
  wire locked;
  wire clk_fb;
  wire clk_ss;
  wire clk_out;
  wire pclk;
  wire pclk100M;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg [7:0] safe_start = 0;


  ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(pclk),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
  );


clk_wiz_1 my_clk_wiz_1(
    .clk(clk),
    .clk40Mhz(pclk),
    .clk100Mhz(pclk100M)
);


  // Instantiate the vga_timing module, which is
  // the module you are designing for this lab.

  wire [10:0] vcount, hcount;
  wire vsync, hsync;
  wire vblnk, hblnk;

//draw background

  wire [11:0] rgb_out_bcg;
  wire [10:0] vcount_out_bcg, hcount_out_bcg;
  wire vsync_out_bcg, hsync_out_bcg;
  wire vblnk_out_bcg, hblnk_out_bcg;  
  
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


// myszka

    wire [11:0]xpos;
    wire [11:0]ypos;
    wire [3:0]r_out_mouse;
    wire [3:0]g_out_mouse;
    wire [3:0]b_out_mouse;
    wire hsync_out_mouse;
    wire vsync_out_mouse;
//ROM

    wire [11:0]pixel_addr;
    wire [11:0]pixel_rgb;

//DRAW RECT CTL

    
    wire mouse_left;
    wire [11:0]xpos_ctl_out; 
    wire [11:0]ypos_ctl_out;
    wire [11:0]xpos_rect_out; 
    wire [11:0]ypos_rect_out;

  vga_timing my_timing (
    .vcount(vcount),
    .vsync(vsync),
    .vblnk(vblnk),
    .hcount(hcount),
    .hsync(hsync),
    .hblnk(hblnk),
    .pclk(pclk)
  );
  
  draw_background my_background (
  
  .clk(pclk),
  
  .vcount_in(vcount),
  .vsync_in(vsync),
  .vblnk_in(vblnk),
  .hcount_in(hcount),
  .hsync_in(hsync),
  .hblnk_in(hblnk),
  
  .rgb_out(rgb_out_bcg),  
  .vcount_out(vcount_out_bcg),
  .vsync_out(vsync_out_bcg),
  .vblnk_out(vblnk_out_bcg),
  .hcount_out(hcount_out_bcg),
  .hsync_out(hsync_out_bcg),
  .hblnk_out(hblnk_out_bcg)
  
  );
  draw_obstacles my_obstacles(
  
  .clk(pclk),

  .lvl(sw),
      
  .rgb_in(rgb_out_bcg),
  .vcount_in(vcount_out_bcg),
  .vsync_in(vsync_out_bcg),
  .vblnk_in(vblnk_out_bcg),
  .hcount_in(hcount_out_bcg),
  .hsync_in(hsync_out_bcg),
  .hblnk_in(hblnk_out_bcg),
  
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

   .width(48),
   .heigth(64),
   .color(110)

  )
   my_draw_rect(
  
   .x_pos(xpos_ctl_out),
   .y_pos(ypos_ctl_out),
  
  
  .clk(pclk),
  
  .rgb_in(rgb_out_point),
  .vcount_in(vcount_out_point),
  .vsync_in(vsync_out_point),
  .vblnk_in(vblnk_out_point),
  .hcount_in(hcount_out_point),
  .hsync_in(hsync_out_point),
  .hblnk_in(hblnk_out_point),
  
  .rgb_pixel(pixel_rgb),
  
  .rgb_out(rgb_out_rect),  
  .vcount_out(vcount_out_rect),
  .vsync_out(vsync_out_rect),
  .vblnk_out(vblnk_out_rect),
  .hcount_out(hcount_out_rect),
  .hsync_out(hsync_out_rect),
  .hblnk_out(hblnk_out_rect),
  .colission(colission_up||colission_down|| colission_left || colission_right),
  
  .pixel_addr(pixel_addr),
  .x_pos_out(xpos_rect_out),
  .y_pos_out(ypos_rect_out)
  );
    

    
  MouseCtl My_Mouse_Ctl(
    .left(mouse_left),
    .xpos(xpos),
    .ypos(ypos),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .clk(pclk100M)
  );
  
  MouseDisplay My_Mouse_Disp(
  
       .pixel_clk(pclk),
       .xpos(xpos),     
       .ypos(ypos),     

       .hcount(hcount_out_rect),   
       .vcount(vcount_out_rect),   
       .hblank(hblnk_out_rect),
       .vblank(hblnk_out_rect), 
       .red_in(rgb_out_rect[11:8]),   
       .green_in(rgb_out_rect[7:4]), 
       .blue_in(rgb_out_rect[3:0]), 
        
        .hsync_in(hsync_out_rect),
        .hsync_out(hsync_out_mouse),
        .vsync_in(vsync_out_rect),
        .vsync_out(vsync_out_mouse),

       .red_out(r_out_mouse),
       .green_out(g_out_mouse),
       .blue_out(b_out_mouse)
  );
  
  image_rom my_image_rom(
    .clk(pclk),
    .address(pixel_addr),
    .rgb(pixel_rgb)
  );
    
    
  wire right;
  wire left;    
  debounce Rdebounce(
    .clk(pclk),
    .sw(btnR),
    .db_level(right)
  );
  
   debounce Ldebounce(
    .clk(pclk),
    .sw(btnL),
    .db_level(left)
  );
  

    
    wire landed;
    wire started;
  
  
  draw_rect_ctl my_draw_rect_ctl(
        .right(right),
        .left(left),
        .up(btn),
        .x_pos(xpos_ctl_out),
        .y_pos(ypos_ctl_out),
        .mouse_left(mouse_left),
        .clk(pclk100M),
        .leds(led),
        .rst(btnD),
        .colission_up(colission_up),
        .colission_down(colission_down),
        
        .colission_left( colission_left),
        .colission_right(  colission_right),
        .landed(landed),
        .started(started)
  );
  
  colision_detector my_colission(
    .clk(pclk100M),
    .x_pos(xpos_rect_out),
    .y_pos(ypos_rect_out),
    .lvl(sw),
    .rst(btnD),
    .colission_up( colission_up),
    .colission_down(colission_down),
    .colission_left( colission_left),
    .colission_right(  colission_right),
    .landed(landed),
    .landing_enable(sw3)
  );
  
  draw_landing my_landing(
      
          .clk(pclk),
          .rst(btnD),
          
          .landing1_enable(!started),
          .landing2_enable(sw3),
          
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
      
      draw_points my_points(
      
      
        .clk(pclk),
        .rst(btnD),
      
        .point_enable(~point_en),
        .lvl(sw),
      
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
              .rst(btnD),
              .x_pos(xpos_rect_out),
              .y_pos(ypos_rect_out),
              .lvl(sw),
              .captured(point_en)
                
          );
  
  // This is a simple test pattern generator.
  
  always @(posedge pclk)
  begin
    // Just pass these through.
    hs <= hsync_out_mouse;
    vs <= vsync_out_mouse;
    
    b <= b_out_mouse;
    g <= g_out_mouse;
    r <= r_out_mouse;

 end

endmodule

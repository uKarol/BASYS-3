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
  input wire [2:0]sw,
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
  
  .rgb_in(rgb_out_obst),
  .vcount_in(vcount_out_obst),
  .vsync_in(vsync_out_obst),
  .vblnk_in(vblnk_out_obst),
  .hcount_in(hcount_out_obst),
  .hsync_in(hsync_out_obst),
  .hblnk_in(hblnk_out_obst),
  
  .rgb_pixel(pixel_rgb),
  
  .rgb_out(rgb_out_rect),  
  .vcount_out(vcount_out_rect),
  .vsync_out(vsync_out_rect),
  .vblnk_out(vblnk_out_rect),
  .hcount_out(hcount_out_rect),
  .hsync_out(hsync_out_rect),
  .hblnk_out(hblnk_out_rect),
  
  
  .pixel_addr(pixel_addr)
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
  
  draw_rect_ctl my_draw_rect_ctl(
        .right(right),
        .left(left),
        .up(btn),
        .x_pos(xpos_ctl_out),
        .y_pos(ypos_ctl_out),
        .mouse_left(mouse_left),
        .clk(pclk100M),
        .leds(led)
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

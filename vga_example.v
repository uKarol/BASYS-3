// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.
module vga_example (
  inout ps2_clk,
  inout ps2_data,  
  input wire clk,
  input wire btnD,
  output reg vs,
  output reg hs,
  output reg [3:0] r,
  output reg [3:0] g,
  output reg [3:0] b,
  output wire pclk_mirror
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
    .reset(btnD)
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


   wire [11:0] rgb_out_txt;
  wire [10:0] vcount_out_txt, hcount_out_txt;
  wire vsync_out_txt, hsync_out_txt;
  wire vblnk_out_txt, hblnk_out_txt; 

   wire [11:0] rgb_out_num;
  wire [10:0] vcount_out_num, hcount_out_num;
  wire vsync_out_num, hsync_out_num;
  wire vblnk_out_num, hblnk_out_num; 

   wire [11:0] rgb_out_mux;
  wire [10:0] vcount_out_mux, hcount_out_mux;
  wire vsync_out_mux, hsync_out_mux;
  wire vblnk_out_mux, hblnk_out_mux; 

wire left_l, right_r, mid_m;
    
    MouseCtl my_mouse(
    .rst(btnD),
    .clk(pclk),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .left(left_l),
    .right(right_r),
    .middle(mid_m)
    );


  vga_timing my_timing (
    .vcount(vcount),
    .vsync(vsync),
    .vblnk(vblnk),
    .hcount(hcount),
    .hsync(hsync),
    .hblnk(hblnk),
    .pclk(pclk),
    .rst(btnD)
  );
  
  
  wire [11:0] bcg_rom_addr;
  wire [11:0] bcg_rom_rgb;


 img_rom_bcg bcg_img(
      .rst(btnD),
      .clk(pclk) ,
      .address(bcg_rom_addr),  // address = {addry[5:0], addrx[5:0]}
      .rgb(bcg_rom_rgb)
  );
  
  draw_background my_background (
  
  .rgb_pixel(bcg_rom_rgb),
  .pixel_addr(bcg_rom_addr),
  .clk(pclk),
  .rst(btnD),
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
  
  wire right;
  wire left;    
  wire colission;
  wire point_capture;
  wire landing_en;
  wire [4:0] points;
  wire [12:0] health;
  wire [12:0] score;
  wire landed;
  wire ok;
  
  debounce Rdebounce(
    .reset(btnD),
    .clk(pclk),
    .sw(right_r),
    .db_level(right),
    .db_tick(ok)
  );
  
   debounce Ldebounce(
    .reset(btnD),
    .clk(pclk),
    .sw(left_l),
    .db_level(left)
  );
  
  wire [12:0] lvl;
  wire next_lvl;
  wire game_rst;
  wire ctl_rst;
  wire failed;
  wire [2:0] game_state;
  wire txt_rst;
  game_state_main my_game_state(
  
  .clk(pclk),
  .ok(ok),
  .rst(btnD),
  
  .next_lvl(next_lvl),
  .fail(failed),  
  .lvl ( lvl ),      
  .game_reset(game_rst),
  .game_ctl_reset(ctl_rst),
  .text_reset(txt_rst),
  .game_state_out(game_state)

  
  );
        
  
  GAME myGAME(
  
      .pclk(pclk),
      .up(mid_m),
      .left(left),
      .right(right),
      .rst(btnD||game_rst),
      .landing_en(landing_en),
      
      .lvl(lvl[2:0]),
          
      .rgb_in(rgb_out_bcg),
      .vcount_in(vcount_out_bcg),
      .vsync_in(vsync_out_bcg),
      .vblnk_in(vblnk_out_bcg),
      .hcount_in(hcount_out_bcg),
      .hsync_in(hsync_out_bcg),
      .hblnk_in(hblnk_out_bcg),

      
      .rgb_out(rgb_out_rect),  
      .vcount_out(vcount_out_rect),
      .vsync_out(vsync_out_rect),
      .vblnk_out(vblnk_out_rect),
      .hcount_out(hcount_out_rect),
      .hsync_out(hsync_out_rect),
      .hblnk_out(hblnk_out_rect),
      
      .colission_out(colission),
      .captured(point_capture),
      .points(points),
      .landed_out(landed)
        
      );
  
        status_TXT my_status_txt(
          .clk(pclk),
          .rst(btnD),
          .hcount_in(hcount_out_rect),
          .vcount_in(vcount_out_rect),
          .hsync_in(hsync_out_rect),
          .vsync_in(vsync_out_rect),
          .hblnk_in(hblnk_out_rect),
          .vblnk_in(vblnk_out_rect),
          
          .rgb_in(rgb_out_rect),
          
          .hcount_out(hcount_out_txt),
          .vcount_out(vcount_out_txt),
          .hsync_out(hsync_out_txt),
          .vsync_out(vsync_out_txt),
          .hblnk_out(hblnk_out_txt),
          .vblnk_out(vblnk_out_txt),    
          .rgb_out(rgb_out_txt)
       
          );

            
    status_numeric my_status_numeric(
      .clk(pclk),
       .rst(btnD),
      .rgb_in(rgb_out_txt),
      .hcount_in(hcount_out_txt),
      .vcount_in(vcount_out_txt),
      .hsync_in(hsync_out_txt),
      .vsync_in(vsync_out_txt),
      .hblnk_in(hblnk_out_txt),
      .vblnk_in(vblnk_out_txt),
      
      .score(score),
      .life(health),
      .lvl(lvl),
      
      .rgb_out(rgb_out_num),
      .hcount_out(hcount_out_num),
      .vcount_out(vcount_out_num),
      .hsync_out(hsync_out_num),
      .vsync_out(vsync_out_num),
      .hblnk_out(hblnk_out_num),
      .vblnk_out(vblnk_out_num)
      
      
      
      );

    game_control my_control(
    
        .clk(pclk),
        .rst(btnD||ctl_rst),
        .colission(colission),
        .points(points),
        .capture(point_capture),
        .landed(landed),
    
        .health(health),
        .score(score),
        .next_lvl(next_lvl),
        .fail(failed),
        .landing_en(landing_en),
        .lvl(lvl)
    
    );

    wire [10:0] hcount_char_out;
    wire [10:0] vcount_char_out;
    wire hsync_char_out;
    wire vsync_char_out;
    wire hblnk_char_out;
    wire vblnk_char_out;   
    wire [11:0]rgb_char_out;    
    


subtitles 
      # (

    .x_pos(336),
    .y_pos(172),
    .X_MAX(128),
    .Y_MAX(256)
)
   my_subtitles (
        
       .rst(btnD || txt_rst),
       .pclk(pclk),
       .hcount_in(hcount_out_bcg),
       .vcount_in(vcount_out_bcg),
       .vsync_in(vsync_out_bcg),
       .hsync_in(hsync_out_bcg),
       .hblnk_in(hblnk_out_bcg),
       .vblnk_in(vblnk_out_bcg),
       
       
       .rgb_in(rgb_out_bcg),
       
       .status(game_state),
       
       .rgb_out(rgb_char_out),
       .vsync_out(vsync_char_out),
       .hsync_out(hsync_char_out),
       
       .vblnk_out(vblnk_char_out),
       .hblnk_out(hblnk_char_out),
       .hcount_out(hcount_char_out),
       .vcount_out(vcount_char_out)   
  
  );
  
  
  disp_mux my_mux(
      .clk(pclk),
      .rst(btnD),
      
      .hcount_in_txt(hcount_char_out),
      .hsync_in_txt(hsync_char_out),
      .hblnk_in_txt(hblnk_char_out),
      .vcount_in_txt(vcount_char_out),
      .vsync_in_txt(vsync_char_out),
      .vblnk_in_txt(vblnk_char_out),
      .rgb_in_txt(rgb_char_out),
      
      .hcount_in_game(hcount_out_num),
      .hsync_in_game(hsync_out_num),
      .hblnk_in_game(hblnk_out_num),
      .vcount_in_game( vcount_out_num),
      .vsync_in_game( vsync_out_num),
      .vblnk_in_game( vblnk_out_num),
      .rgb_in_game(rgb_out_num),
      
      .game_state(game_state),
      
      .hcount_out(vcount_out_mux),
      .hsync_out(hsync_out_mux),
      .hblnk_out(hblnk_out_mux),
      .vcount_out(vcount_out_mux),
      .vsync_out(vsync_out_mux),
      .vblnk_out(vblnk_out_mux),
      .rgb_out(rgb_out_mux)
      
      
      );


    

  // This is a simple test pattern generator.
  
  always @(posedge pclk)
  begin
    // Just pass these through.
    if(btnD == 1)
    begin
        hs <= 0;
        vs <= 0;

        b <= 0;
        g <= 0;
        r <= 0;
        
    end
    else
    begin
        hs <= hsync_out_mux;
        vs <= vsync_out_mux;
    
        b <= rgb_out_mux[3:0];
        g <= rgb_out_mux[7:4];
        r <= rgb_out_mux[11:8];
    end

 end

endmodule

// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_timing (
  output reg [10:0] vcount = 0,
  output reg vsync = 0,
  output reg vblnk = 0,
  output reg [10:0] hcount = 0,
  output reg hsync = 0,
  output reg hblnk = 0,
  input wire pclk,
  input rst 
  );

  // Describe the actual circuit for the assignment.
  // Video timing controller set for 800x600@60fps
  // using a 40 MHz pixel clock per VESA spec.
  localparam
  HCOUNT_MAX = 1055,
  VCOUNT_MAX = 627,
  
  HBLNK_START = 800,
  
  HSYNC_START = 840,
  HSYNC_STOP = 968,
  
 
  VBLNK_START = 600,
  VSYNC_START = 601,
  VSYNC_STOP = 605;

  
 reg [10:0] hcount_nxt;
  reg [10:0] vcount_nxt;
  reg vsync_nxt;
  reg vblnk_nxt;
  reg hsync_nxt;
  reg hblnk_nxt;

   always @(posedge pclk or posedge rst) begin
    
    if(rst == 1)
    begin
        hcount <= 0;
        vcount <= 0;
        hblnk <= 0;
        hsync <= 0;
        vblnk <= 0;
        vsync <= 0;
    end
    else
    begin
        hcount <= hcount_nxt;
        vcount <= vcount_nxt;
        hblnk <= hblnk_nxt;
        hsync <= hsync_nxt;
        vblnk <= vblnk_nxt;
        vsync <= vsync_nxt;
    end   
   end  
  always @*
  fork
 
     hcount_nxt =  (hcount == HCOUNT_MAX) ? 0 : hcount + 1;
     
     vcount_nxt =  (hcount == HCOUNT_MAX) ? (  (vcount == VCOUNT_MAX)? 0 : vcount + 1) : vcount;

     hblnk_nxt = ((hcount_nxt >= HBLNK_START)&&(hcount_nxt <= HCOUNT_MAX)) ? 1:0;
     hsync_nxt = ((hcount_nxt >= HSYNC_START)&&(hcount_nxt < HSYNC_STOP))  ? 1:0; 
  
     vblnk_nxt = ((vcount_nxt >= VBLNK_START)&&(vcount_nxt <= VCOUNT_MAX)) ? 1:0;
     vsync_nxt = ((vcount_nxt >= VSYNC_START)&&(vcount_nxt < VSYNC_STOP)) ? 1:0;   

     
 join 
  
endmodule

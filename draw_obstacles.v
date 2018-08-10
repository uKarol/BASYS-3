`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.08.2018 14:47:56
// Design Name: 
// Module Name: draw_obstacles
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


module draw_obstacles
(
    
    input wire clk,

    input wire [2:0] lvl,
        
    input [10:0] hcount_in,
    input hsync_in,
    input hblnk_in,
    input [10:0] vcount_in,
    input vsync_in,
    input vblnk_in,
    input [11:0] rgb_in,
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out
    );

    
reg [11:0] rgb_nxt;

localparam

    color = 0,
    
    //lvl1
    
    lvl1_obst1_x=200,
    lvl1_obst1_y=250,
    lvl1_obst1_h=20,
    lvl1_obst1_w=150,
    
    lvl1_obst2_x=450,
    lvl1_obst2_y=150,
    lvl1_obst2_h=20,
    lvl1_obst2_w=150,
    
    lvl1_obst3_x=200,
    lvl1_obst3_y=530,
    lvl1_obst3_h=60,
    lvl1_obst3_w=70,
    
    lvl1_obst4_x=280,
    lvl1_obst4_y=490,
    lvl1_obst4_h=100,
    lvl1_obst4_w=60,
    
    lvl1_landing_x=630,
    lvl1_landing_y=550,
    lvl1_landing_h=20,
    lvl1_landing_w=115,
    
    // lvl 2    
    
    lvl2_obst1_x=40,
    lvl2_obst1_y=360,
    lvl2_obst1_h=20,
    lvl2_obst1_w=150,
    
    lvl2_obst2_x=200,
    lvl2_obst2_y=130,
    lvl2_obst2_h=20,
    lvl2_obst2_w=150,
    
    lvl2_obst3_x=300,
    lvl2_obst3_y=270,
    lvl2_obst3_h=20,
    lvl2_obst3_w=450,
    
    lvl2_obst4_x=280,
    lvl2_obst4_y=490,
    lvl2_obst4_h=100,
    lvl2_obst4_w=60,
    
    lvl2_obst5_x=200,
    lvl2_obst5_y=530,
    lvl2_obst5_h=60,
    lvl2_obst5_w=70,
    
    lvl2_landing_x=630,
    lvl2_landing_y=550,
    lvl2_landing_h=20,
    lvl2_landing_w=115,
    
    // lvl 3    
    
    lvl3_obst1_x=60,
    lvl3_obst1_y=150,
    lvl3_obst1_h=20,
    lvl3_obst1_w=110,
    
    lvl3_obst2_x=250,
    lvl3_obst2_y=380,
    lvl3_obst2_h=200,
    lvl3_obst2_w=80,
    
    lvl3_obst3_x=330,
    lvl3_obst3_y=270,
    lvl3_obst3_h=310,
    lvl3_obst3_w=60,
    
    lvl3_obst4_x=390,
    lvl3_obst4_y=440,
    lvl3_obst4_h=140,
    lvl3_obst4_w=120,
    
    lvl3_obst5_x=520,
    lvl3_obst5_y=40,
    lvl3_obst5_h=60,
    lvl3_obst5_w=220,
    
    lvl3_obst6_x=540,
    lvl3_obst6_y=40,
    lvl3_obst6_h=100,
    lvl3_obst6_w=60,
    
    lvl3_obst7_x=680,
    lvl3_obst7_y=330,
    lvl3_obst7_h=20,
    lvl3_obst7_w=120,
    
    lvl3_landing_x=630,
    lvl3_landing_y=550,
    lvl3_landing_h=20,
    lvl3_landing_w=115;
    
    
always @*
begin

case(lvl)

3'b001:
begin
    rgb_nxt = ( (vcount_in >= 0)&&(vcount_in < 40)  ) || ( (vcount_in >= 580)&&(vcount_in < 600)  )
    || ( (hcount_in >= lvl1_obst1_x) && (hcount_in < (lvl1_obst1_x+lvl1_obst1_w)) && (vcount_in >= lvl1_obst1_y)&&(vcount_in < (lvl1_obst1_y+lvl1_obst1_h))  ) 
    || ( (hcount_in >= lvl1_obst2_x) && (hcount_in < (lvl1_obst2_x+lvl1_obst2_w)) && (vcount_in >= lvl1_obst2_y)&&(vcount_in < (lvl1_obst2_y+lvl1_obst2_h))  ) 
    || ( (hcount_in >= lvl1_obst3_x) && (hcount_in < (lvl1_obst3_x+lvl1_obst3_w)) && (vcount_in >= lvl1_obst3_y)&&(vcount_in < (lvl1_obst3_y+lvl1_obst3_h))  ) 
    || ( (hcount_in >= lvl1_obst4_x) && (hcount_in < (lvl1_obst4_x+lvl1_obst4_w)) && (vcount_in >= lvl1_obst4_y)&&(vcount_in < (lvl1_obst4_y+lvl1_obst4_h))  ) ? color : rgb_in;
 end
 
 3'b010:
 begin
     rgb_nxt = ( (vcount_in >= 0)&&(vcount_in < 40)  ) || ( (vcount_in >= 580)&&(vcount_in < 600)  )
     || ( (hcount_in >= lvl2_obst1_x) && (hcount_in < (lvl2_obst1_x+lvl2_obst1_w)) && (vcount_in >= lvl2_obst1_y)&&(vcount_in < (lvl2_obst1_y+lvl2_obst1_h))  ) 
     || ( (hcount_in >= lvl2_obst2_x) && (hcount_in < (lvl2_obst2_x+lvl2_obst2_w)) && (vcount_in >= lvl2_obst2_y)&&(vcount_in < (lvl2_obst2_y+lvl2_obst2_h))  ) 
     || ( (hcount_in >= lvl2_obst3_x) && (hcount_in < (lvl2_obst3_x+lvl2_obst3_w)) && (vcount_in >= lvl2_obst3_y)&&(vcount_in < (lvl2_obst3_y+lvl2_obst3_h))  ) 
     || ( (hcount_in >= lvl2_obst4_x) && (hcount_in < (lvl2_obst4_x+lvl2_obst4_w)) && (vcount_in >= lvl2_obst4_y)&&(vcount_in < (lvl2_obst4_y+lvl2_obst4_h))  ) 
     || ( (hcount_in >= lvl2_obst5_x) && (hcount_in < (lvl2_obst5_x+lvl2_obst5_w)) && (vcount_in >= lvl2_obst5_y)&&(vcount_in < (lvl2_obst5_y+lvl2_obst5_h))  ) ? color : rgb_in;
  end
  
  3'b011:
  begin
      rgb_nxt = ( (vcount_in >= 0)&&(vcount_in < 40)  ) || ( (vcount_in >= 580)&&(vcount_in < 600)  )
      || ( (hcount_in >= lvl3_obst1_x) && (hcount_in < (lvl3_obst1_x+lvl3_obst1_w)) && (vcount_in >= lvl3_obst1_y)&&(vcount_in < (lvl3_obst1_y+lvl3_obst1_h))  ) 
      || ( (hcount_in >= lvl3_obst2_x) && (hcount_in < (lvl3_obst2_x+lvl3_obst2_w)) && (vcount_in >= lvl3_obst2_y)&&(vcount_in < (lvl3_obst2_y+lvl3_obst2_h))  ) 
      || ( (hcount_in >= lvl3_obst3_x) && (hcount_in < (lvl3_obst3_x+lvl3_obst3_w)) && (vcount_in >= lvl3_obst3_y)&&(vcount_in < (lvl3_obst3_y+lvl3_obst3_h))  ) 
      || ( (hcount_in >= lvl3_obst4_x) && (hcount_in < (lvl3_obst4_x+lvl3_obst4_w)) && (vcount_in >= lvl3_obst4_y)&&(vcount_in < (lvl3_obst4_y+lvl3_obst4_h))  ) 
      || ( (hcount_in >= lvl3_obst5_x) && (hcount_in < (lvl3_obst5_x+lvl3_obst5_w)) && (vcount_in >= lvl3_obst5_y)&&(vcount_in < (lvl3_obst5_y+lvl3_obst5_h))  ) 
      || ( (hcount_in >= lvl3_obst6_x) && (hcount_in < (lvl3_obst6_x+lvl3_obst6_w)) && (vcount_in >= lvl3_obst6_y)&&(vcount_in < (lvl3_obst6_y+lvl3_obst6_h))  )
      || ( (hcount_in >= lvl3_obst7_x) && (hcount_in < (lvl3_obst7_x+lvl3_obst7_w)) && (vcount_in >= lvl3_obst7_y)&&(vcount_in < (lvl3_obst7_y+lvl3_obst7_h))  ) ? color : rgb_in;
   end
 
 default: rgb_nxt = rgb_in;  
 endcase
 end


always @(posedge clk) 
begin   
   hcount_out <= hcount_in;
   vcount_out <= vcount_in;
   vblnk_out <= vblnk_in;
   vsync_out <= vsync_in;
   hblnk_out <= hblnk_in;
   hsync_out <= hsync_in;
   rgb_out <= rgb_nxt; 
 end 

endmodule

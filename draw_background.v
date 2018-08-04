`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2018 13:24:51
// Design Name: 
// Module Name: draw_background
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


module draw_background(
    input [10:0] hcount_in,
    input [10:0] vcount_in,
    input vsync_in,
    input vblnk_in,
    input hsync_in,
    input hblnk_in,
    
    input clk,
    
    output reg [10:0] vcount_out,
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0]rgb_out
    );
    reg [11:0]rgb_nxt;
localparam
      y_dist = 10,
      x_dist = 10,
      
      x_5_dist = 30;
always @* 
begin
    

      if (vblnk_in || hblnk_in) rgb_nxt = 12'h0_0_0; 
    else
    begin
      // Active display, top edge, make a yellow line.
      if (vcount_in == 0) rgb_nxt = 12'hf_f_0;
      // Active display, bottom edge, make a red line.
      else if (vcount_in == 599) rgb_nxt = 12'hf_0_0;
      // Active display, left edge, make a green line.
      else if (hcount_in == 0) rgb_nxt = 12'h0_f_0;
      // Active display, right edge, make a blue line.
      else if (hcount_in == 799) rgb_nxt = 12'h0_0_f;
      // Active display, interior, fill with gray.
      // You will replace this with your own test.
  
  //na pa³e
     
     // LITERA K
     
     else if ( ( ( (hcount_in >= 0 + x_dist) && (hcount_in <= 17 + x_dist ) ) && ( (vcount_in >= y_dist) && (vcount_in <= 17 + y_dist ) ) ) && (vcount_in == 2*17  - 7 + x_dist - hcount_in ) ) rgb_nxt = 12'h0_f_0; 
     
     else if ( ( ( (hcount_in >= 0 + x_dist) && (hcount_in <= 16 + x_dist ) ) && ( (vcount_in >= y_dist) && (vcount_in <= 16 + y_dist ) ) ) && (vcount_in == 2*16 -6 + x_dist - hcount_in ) ) rgb_nxt = 12'h0_f_0;     
     else if ( ( ( (hcount_in >= 0 + x_dist) && (hcount_in <= 17 + x_dist ) ) && ( (vcount_in >= 13 + y_dist) && (vcount_in <= 30 + y_dist ) ) ) && (vcount_in == 13 + hcount_in ) ) rgb_nxt = 12'h0_f_0; 
     
     else if ( ( ( (hcount_in >= 0 + x_dist) && (hcount_in <= 16 + x_dist ) ) && ( (vcount_in >= 14 + y_dist) && (vcount_in <= 30 + y_dist ) ) ) && (vcount_in == 14 + hcount_in ) ) rgb_nxt = 12'h0_f_0; 
                
      else if   ( ( (hcount_in >= 0 + x_dist) && (hcount_in <= 1 + x_dist ) ) && ( (vcount_in >= 0 + y_dist) && (vcount_in <= 30 + y_dist ) ) ) rgb_nxt = 12'h0_f_0;  
      


    // cyfra 5
    
     else if   ( ( (hcount_in >= 0 + x_5_dist) && (hcount_in <= 1 + x_5_dist ) ) && ( (vcount_in >= 0 + y_dist) && (vcount_in <= 15 + y_dist ) ) ) rgb_nxt = 12'h0_f_0;  
         
     else if   ( ( (hcount_in >= 10 + x_5_dist) && (hcount_in <= 11 + x_5_dist ) ) && ( (vcount_in >= 18 + y_dist) && (vcount_in <= 26 + y_dist ) ) ) rgb_nxt = 12'h0_f_0;  
     
     else if   ( ( (hcount_in >= 2 + x_5_dist) && (hcount_in <= 12 + x_5_dist ) ) && ( (vcount_in >= 0 + y_dist) && (vcount_in <= 1 + y_dist ) ) ) rgb_nxt = 12'h0_f_0;  
    
     else if   ( ( (hcount_in >= 2 + x_5_dist) && (hcount_in <= 8 + x_5_dist ) ) && ( (vcount_in >= 14 + y_dist) && (vcount_in <= 15 + y_dist ) ) ) rgb_nxt = 12'h0_f_0;  
        
     else if   ( ( (hcount_in >= 0 + x_5_dist) && (hcount_in <= 8 + x_5_dist ) ) && ( (vcount_in >= 29 + y_dist) && (vcount_in <= 30 + y_dist ) ) ) rgb_nxt = 12'h0_f_0;  
                   
     
     else if ( ( ( (hcount_in >= 7 + x_5_dist) && (hcount_in <= 11 + x_5_dist ) ) && ( (vcount_in >= 14 + y_dist) && (vcount_in <= 18 + y_dist ) ) ) && (vcount_in == hcount_in + 17 - x_5_dist  ) ) rgb_nxt = 12'h0_f_0; 

     else if ( ( ( (hcount_in >= 8 + x_5_dist) && (hcount_in <= 11 + x_5_dist ) ) && ( (vcount_in >= 15 + y_dist) && (vcount_in <= 19 + y_dist ) ) ) && (vcount_in == 16 - x_5_dist + hcount_in ) ) rgb_nxt = 12'h0_f_0; 
    
     else if ( ( ( (hcount_in >= 7 + x_5_dist) && (hcount_in <= 11 + x_5_dist ) ) && ( (vcount_in >= 26+ y_dist) && (vcount_in <= 30 + y_dist ) ) ) && ( vcount_in ==  47 + x_5_dist - hcount_in  ) ) rgb_nxt = 12'h0_f_0; 

     else if ( ( ( (hcount_in >= 8 + x_5_dist) && (hcount_in <= 11 + x_5_dist ) ) && ( (vcount_in >= 26 + y_dist) && (vcount_in <= 30 + y_dist ) ) ) && (vcount_in ==  48 + x_5_dist - hcount_in  ) ) rgb_nxt = 12'h0_f_0; 
           
          else rgb_nxt = 12'h8_8_8;    
   end 

        
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
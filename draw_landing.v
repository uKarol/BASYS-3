`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.08.2018 14:11:28
// Design Name: 
// Module Name: draw_landing
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


module draw_landing(
    
        input wire clk,
        input wire rst,
        
        input wire landing1_enable,
        input wire landing2_enable,
        
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
        
            landing2_x=630,
            landing2_y=560,
            landing2_h=20,
            landing2_w=115,
            color = 12'h0f0,
            
            landing1_x=10,
            landing1_y=560,
            landing1_h=20,
            landing1_w=115;
            
            
       always @*
       begin 
        
            rgb_nxt =( ( (landing1_enable == 1)&&((hcount_in >= landing1_x) &&
             (hcount_in < (landing1_x+landing1_w)) && 
             (vcount_in >= landing1_y)&&
             (vcount_in < (landing1_y+landing1_h)) ))||
             
             ((landing2_enable == 1)&&((hcount_in >= landing2_x) &&
              (hcount_in < (landing2_x+landing2_w)) && 
              (vcount_in >= landing2_y)&&
              (vcount_in < (landing2_y+landing2_h)) )) )? color : rgb_in ;
            

       end 
            
            
       always @(posedge clk or posedge rst) 
       begin   
       if(rst == 1)
       begin
           hcount_out <= hcount_in;
           vcount_out <= vcount_in;
           vblnk_out <= vblnk_in;
           vsync_out <= vsync_in;
           hblnk_out <= hblnk_in;
           hsync_out <= hsync_in;
           rgb_out <= rgb_in; 
       
       end
       else begin
          hcount_out <= hcount_in;
          vcount_out <= vcount_in;
          vblnk_out <= vblnk_in;
          vsync_out <= vsync_in;
          hblnk_out <= hblnk_in;
          hsync_out <= hsync_in;
          rgb_out <= rgb_nxt; 
        end
        end 
            
endmodule

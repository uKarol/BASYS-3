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
        output reg [11:0] rgb_out,

        
        output reg [11:0] pixel_addr,
        input [11:0] rgb_pixel
        
        );
            
         reg [11:0] rgb_nxt;
         reg [11:0] pixel_addr_nxt;
     
         reg hsync_delay1;
         reg hblnk_delay1;
         reg [10:0] hcount_delay1;
         reg vsync_delay1;
         reg vblnk_delay1;
         reg [10:0] vcount_delay1;
         reg [11:0] rgb_delay1;
     
         reg hsync_delay2;   
         reg hblnk_delay2;
         reg [10:0] hcount_delay2;
         reg vsync_delay2;
         reg vblnk_delay2;
         reg [10:0] vcount_delay2;
         reg [11:0] rgb_delay2;
    
        localparam 
        
            landing2_x=630,
            landing2_y=560,
            landing2_h=20,
            landing2_w=115,

            
            landing1_x=10,
            landing1_y=560,
            landing1_h=20,
            landing1_w=115;
            
            
       always @*
       begin 
        
            if(( ( (landing1_enable == 1)&&((hcount_in >= landing1_x) &&
             (hcount_in < (landing1_x+landing1_w)) && 
             (vcount_in >= landing1_y)&&
             (vcount_in < (landing1_y+landing1_h)) )) ) )
           begin
                        pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-landing1_y[3:0] };
                        pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-landing1_x[3:0] }; 
             end  
         else   if( ((landing2_enable == 1)&&((hcount_in >= landing2_x) &&
              (hcount_in < (landing2_x+landing2_w)) && 
              (vcount_in >= landing2_y)&&
              (vcount_in < (landing2_y+landing2_h)) )) ) 
             begin
                         pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-landing2_y[3:0] };
                         pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-landing2_x[3:0] }; 
              end  
        else pixel_addr_nxt = pixel_addr;    
            
            
               if(( ( (landing1_enable == 1)&&((hcount_delay2 >= landing1_x) &&
               (hcount_delay2 < (landing1_x+landing1_w)) && 
               (vcount_delay2 >= landing1_y)&&
               (vcount_delay2 < (landing1_y+landing1_h)) ))||
               
               ((landing2_enable == 1)&&((hcount_delay2 >= landing2_x) &&
                (hcount_delay2 < (landing2_x+landing2_w)) && 
                (vcount_delay2 >= landing2_y)&&
                (vcount_delay2 < (landing2_y+landing2_h)) )) ) )
               begin
                            rgb_nxt = rgb_pixel;
               
               end
                else 
                rgb_nxt = rgb_delay2;
          

       end 
            
            
       always @(posedge clk or posedge rst) 
       begin   
       if(rst == 1)
       begin
           hcount_out <= 0;
           vcount_out <= 0;
           vblnk_out <= 0;
           vsync_out <= 0;
           hblnk_out <= 0;
           hsync_out <= 0;
           rgb_out <= 0; 
           pixel_addr <= 0;
           
           hcount_delay1 <= 0;
           hsync_delay1 <= 0;
           hblnk_delay1 <= 0;
           vcount_delay1 <= 0;
           vsync_delay1 <= 0;
           vblnk_delay1 <= 0;
           rgb_delay1 <= 0;
    
           hcount_delay2 <= 0;
           hsync_delay2 <= 0;
           hblnk_delay2 <= 0;
           vcount_delay2 <= 0;
           vsync_delay2 <= 0;
           vblnk_delay2 <= 0;
           rgb_delay2 <= 0;
       
       end
       else begin

                hcount_delay1 <= hcount_in;
                hsync_delay1 <= hsync_in;
                hblnk_delay1 <= hblnk_in;
                vcount_delay1 <= vcount_in;
                vsync_delay1 <= vsync_in;
                vblnk_delay1 <= vblnk_in;
                rgb_delay1 <= rgb_in;
         
                hcount_delay2 <= hcount_delay1;
                hsync_delay2 <= hsync_delay1;
                hblnk_delay2 <= hblnk_delay1;
                vcount_delay2 <= vcount_delay1;
                vsync_delay2 <= vsync_delay1;
                vblnk_delay2 <= vblnk_delay1;
                rgb_delay2 <= rgb_delay1;
        
            
                hcount_out <= hcount_delay2;
                vcount_out <= vcount_delay2;
                vblnk_out <= vblnk_delay2;
                vsync_out <= vsync_delay2;
                hblnk_out <= hblnk_delay2;
                hsync_out <= hsync_delay2;
            
                rgb_out <= rgb_nxt; 
            
                pixel_addr <= pixel_addr_nxt;
    

        end
        end 
            
endmodule

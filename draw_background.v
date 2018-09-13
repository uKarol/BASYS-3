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
    
    input rst,
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
    output reg [11:0]rgb_out,
    
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

always @* 
begin
    

    if (vblnk_in || hblnk_in)begin
         rgb_nxt = 12'h0_0_0; 
         pixel_addr_nxt = pixel_addr;  
    end
    else
    begin
    
    if( vcount_in > 0 && vcount_in < 600 && hcount_in > 0 && hcount_in < 800 ) 
    begin
        pixel_addr_nxt[11:6] = vcount_in[5:0];
        pixel_addr_nxt[5:0] =  hcount_in[5:0]; 
    end 
    else pixel_addr_nxt = pixel_addr;
         
    if( vcount_delay2 > 0 && vcount_delay2 < 600 && hcount_delay2 > 0 && hcount_delay2 < 800 ) 
    rgb_nxt = rgb_pixel;
    else 
    begin
     rgb_nxt = 0;

    end
    end
        
end
always @(posedge clk or posedge rst) 
begin 

   if(rst == 1) begin  
        hcount_out <= 0;
        vcount_out <= 0;
        vblnk_out <= 0;
        vsync_out <= 0;
        hblnk_out <= 0;
        hsync_out <= 0;
        rgb_out <= 0; 
        
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
        pixel_addr <= 0;

   end
   
   else begin  
        
        hcount_delay1 <= hcount_in;
        hsync_delay1 <= hsync_in;
        hblnk_delay1 <= hblnk_in;
        vcount_delay1 <= vcount_in;
        vsync_delay1 <= vsync_in;
        vblnk_delay1 <= vblnk_in;
        rgb_delay1 <= 0;

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
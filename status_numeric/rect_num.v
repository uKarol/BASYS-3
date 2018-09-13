`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2018 15:34:27
// Design Name: 
// Module Name: rect
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


module rect_num
      # ( parameter
    width=0,
    heigth=0,
    color=12'hf_0_0,
    max_x = 800,
    max_y = 600,
    x_pos = 0,
    y_pos = 0
)
(

    input wire clk,
    input wire rst,
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

always @*
begin
    rgb_nxt = ( (hcount_in>= x_pos) && (hcount_in < (x_pos+width)) && (vcount_in >= y_pos)&&(vcount_in < (y_pos +heigth))  ) ? color : rgb_in;
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
   end
   else
   begin    
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

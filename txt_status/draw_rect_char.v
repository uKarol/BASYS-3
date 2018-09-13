`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2018 14:43:52
// Design Name: 
// Module Name: draw_rect_char
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


module draw_rect_char
     # ( parameter
    x_pos = 0,
    y_pos = 0,
    
    X_MAX = 128,
    Y_MAX = 16,
    font_color = 12'hf_f_f,
    bcg_color = 12'h0_0_0
)

(
    input rst,
    input clk,
    input [10:0]hcount_in,
    input [10:0]vcount_in,
    input vsync_in,
    input hsync_in,
    input hblnk_in,
    input vblnk_in,
    input [11:0]rgb_in,
    input [7:0]char_pixel,
    
    output reg[10:0]hcount_out,
    output reg[10:0]vcount_out,
    output reg vsync_out,
    output reg hsync_out,
    output reg vblnk_out,
    output reg hblnk_out,
    output reg[11:0] rgb_out,
    output reg [7:0] char_xy,
    output reg [3:0] char_line 
     
    );
    
    
    reg [3:0] char_line_nxt;
    reg [7:0] char_xy_nxt;
    
    
    reg [11:0] rgb_nxt;
    
    
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
    
    reg[10:0] hcount_temp;
    reg[10:0] vcount_temp;
    
    reg[10:0] hcount_temp_delay;
    reg[10:0] vcount_temp_delay;
    
  
    //generacja adresu i odbieranie znaku 
    
    always @* 
    begin 
    
            vcount_temp = vcount_in - y_pos;
            hcount_temp = hcount_in - x_pos;
            vcount_temp_delay = vcount_delay2 - y_pos;
            vcount_temp_delay = hcount_delay2 - x_pos;
            
    if ( (hcount_in >= x_pos) && (hcount_in < X_MAX+ x_pos) && (vcount_in >= y_pos)&&(vcount_in < y_pos+Y_MAX)  ) begin
 
        char_xy_nxt = { vcount_temp[7:4] , hcount_temp[6:3] };
        char_line_nxt = vcount_temp[3:0];
        
    end
    else 
        begin
            char_xy_nxt = char_xy;
            char_line_nxt = char_line;
        end
     
  

   if( (hcount_delay2>= x_pos) && (hcount_delay2 < x_pos+X_MAX) && (vcount_delay2 >= y_pos)&&(vcount_delay2 < y_pos + Y_MAX)  ) begin
        
        if (char_pixel[3'b111 - vcount_temp_delay[2:0]]  ) rgb_nxt = font_color;
       else rgb_nxt = bcg_color; 
  
   end
   else rgb_nxt = rgb_delay2;
    
    
        
    end
    
     
    
    always@(posedge clk or posedge rst)
    begin 
    
    if(rst == 1)
    begin                
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
  
            
        hcount_out <= 0;
        vcount_out <= 0;
        vsync_out <= 0;
        hsync_out <= 0;
        vblnk_out <= 0;
        hblnk_out <= 0;
        rgb_out <= 0;
        char_xy <= 0;
        char_line <= 0;
    end
    
    else
    begin                
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
        vsync_out <= vsync_delay2;
        hsync_out <= hsync_delay2;
        vblnk_out <= vblnk_delay2;
        hblnk_out <= hblnk_delay2;
        rgb_out <= rgb_nxt;
        char_xy <= char_xy_nxt;
        char_line <= char_line_nxt;
    end
        
                        
    end 
    
    
    
   
endmodule

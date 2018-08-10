`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2018 14:45:25
// Design Name: 
// Module Name: draw_points
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


module draw_points(

    input clk,
    input wire rst,
    
    input wire [4:0] point_enable,
    input wire [2:0]lvl,
    
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
        
        point_w = 20,
        point_h = 20,
        
        point1_lvl1_x =265,
        point1_lvl1_y =220,
        point2_lvl1_x =515,
        point2_lvl1_y =120,
        point3_lvl1_x =235,
        point3_lvl1_y =500,
        point4_lvl1_x =310,
        point4_lvl1_y =460,   
        point5_lvl1_x =400,
        point5_lvl1_y =550,
        
        point1_lvl2_x =0,
        point1_lvl2_y =0,
        point2_lvl2_x =0,
        point2_lvl2_y =0,
        point3_lvl2_x =0,
        point3_lvl2_y =0,
        point4_lvl2_x =0,
        point4_lvl2_y =0,   
        point5_lvl2_x =0,
        point5_lvl2_y =0,
    
        point1_lvl3_x =0,
        point1_lvl3_y =0,
        point2_lvl3_x =0,
        point2_lvl3_y =0,
        point3_lvl3_x =0,
        point3_lvl3_y =0,
        point4_lvl3_x =0,
        point4_lvl3_y =0,   
        point5_lvl3_x =0,
        point5_lvl3_y =0,
        
        color = 12'h_0_0_f;
        
        always @*
        begin
            case(lvl)
        
        3'b001:
        begin
            rgb_nxt = 
               ( (point_enable[0] == 1 )&&(hcount_in >= point1_lvl1_x) && (hcount_in < (point1_lvl1_x+point_w)) && (vcount_in >= point1_lvl1_y)&&(vcount_in < (point1_lvl1_y+point_h))  ) 
            || ( (point_enable[1] == 1 )&&(hcount_in >= point2_lvl1_x) && (hcount_in < (point2_lvl1_x+point_w)) && (vcount_in >= point2_lvl1_y)&&(vcount_in < (point2_lvl1_y+point_h))  )  
            || ( (point_enable[2] == 1 )&&(hcount_in >= point3_lvl1_x) && (hcount_in < (point3_lvl1_x+point_w)) && (vcount_in >= point3_lvl1_y)&&(vcount_in < (point3_lvl1_y+point_h))  )    
            || ( (point_enable[3] == 1 )&&(hcount_in >= point4_lvl1_x) && (hcount_in < (point4_lvl1_x+point_w)) && (vcount_in >= point4_lvl1_y)&&(vcount_in < (point4_lvl1_y+point_h))  ) 
            || ( (point_enable[4] == 1 )&&(hcount_in >= point5_lvl1_x) && (hcount_in < (point5_lvl1_x+point_w)) && (vcount_in >= point5_lvl1_y)&&(vcount_in < (point5_lvl1_y+point_h))  )  ? color : rgb_in;
         end
         
         3'b010:
         begin
            rgb_nxt = 
                   ( (point_enable[0] == 1 )&& (hcount_in >= point1_lvl2_x) && (hcount_in < (point1_lvl2_x+point_w)) && (vcount_in >= point1_lvl2_y)&&(vcount_in < (point1_lvl2_y+point_h))  ) 
                 ||( (point_enable[1] == 1 )&& (hcount_in >= point2_lvl2_x) && (hcount_in < (point2_lvl2_x+point_w)) && (vcount_in >= point2_lvl2_y)&&(vcount_in < (point2_lvl2_y+point_h))  )  
                 ||( (point_enable[2] == 1 )&& (hcount_in >= point3_lvl2_x) && (hcount_in < (point3_lvl2_x+point_w)) && (vcount_in >= point3_lvl2_y)&&(vcount_in < (point3_lvl2_y+point_h))  )    
                 ||( (point_enable[3] == 1 )&& (hcount_in >= point4_lvl2_x) && (hcount_in < (point4_lvl2_x+point_w)) && (vcount_in >= point4_lvl2_y)&&(vcount_in < (point4_lvl2_y+point_h))  ) 
                 ||( (point_enable[4] == 1 )&& (hcount_in >= point5_lvl2_x) && (hcount_in < (point5_lvl2_x+point_w)) && (vcount_in >= point5_lvl2_y)&&(vcount_in < (point5_lvl2_y+point_h))  )  ? color : rgb_in;
           
         end
          
          3'b011:
          begin
          
           rgb_nxt = 
               ( (point_enable[0] == 1 )&&(hcount_in >= point1_lvl3_x) && (hcount_in < (point1_lvl3_x+point_w)) && (vcount_in >= point1_lvl3_y)&&(vcount_in < (point1_lvl3_y+point_h))  ) 
            || ( (point_enable[1] == 1 )&&(hcount_in >= point2_lvl3_x) && (hcount_in < (point2_lvl3_x+point_w)) && (vcount_in >= point2_lvl3_y)&&(vcount_in < (point2_lvl3_y+point_h))  )  
            || ( (point_enable[2] == 1 )&&(hcount_in >= point3_lvl3_x) && (hcount_in < (point3_lvl3_x+point_w)) && (vcount_in >= point3_lvl3_y)&&(vcount_in < (point3_lvl3_y+point_h))  )    
            || ( (point_enable[3] == 1 )&&(hcount_in >= point4_lvl3_x) && (hcount_in < (point4_lvl3_x+point_w)) && (vcount_in >= point4_lvl3_y)&&(vcount_in < (point4_lvl3_y+point_h))  ) 
            || ( (point_enable[4] == 1 )&&(hcount_in >= point5_lvl3_x) && (hcount_in < (point5_lvl3_x+point_w)) && (vcount_in >= point5_lvl3_y)&&(vcount_in < (point5_lvl3_y+point_h))  )  ? color : rgb_in;
   
              
          end
         
         default: rgb_nxt = rgb_in;  
         endcase
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

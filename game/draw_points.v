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
        
        point_w = 16,
        point_h = 16,
        
        point1_lvl1_x =269,
        point1_lvl1_y =216,
        point2_lvl1_x =519,
        point2_lvl1_y =116,
        point3_lvl1_x =229,
        point3_lvl1_y =496,
        point4_lvl1_x =304,
        point4_lvl1_y =454,   
        point5_lvl1_x =404,
        point5_lvl1_y =546,
        
        point1_lvl2_x =95,
        point1_lvl2_y =330,
        point2_lvl2_x =235,
        point2_lvl2_y =100,
        point3_lvl2_x =400,
        point3_lvl2_y =240,
        point4_lvl2_x =300,
        point4_lvl2_y =460,   
        point5_lvl2_x =400,
        point5_lvl2_y =550,
    
        point1_lvl3_x =105,
        point1_lvl3_y =120,
        point2_lvl3_x =730,
        point2_lvl3_y =300,
        point3_lvl3_x =270,
        point3_lvl3_y =350,
        point4_lvl3_x =560,
        point4_lvl3_y =150,   
        point5_lvl3_x =640,
        point5_lvl3_y =110;
        
        always @*
        begin
            case(lvl)
        
        3'b001:
        begin
             
            if( ( (point_enable[0] == 1 )&&(hcount_in >= point1_lvl1_x) && (hcount_in < (point1_lvl1_x+point_w)) && (vcount_in >= point1_lvl1_y)&&(vcount_in < (point1_lvl1_y+point_h))  ) )
            begin 
                    pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]- point1_lvl1_y[3:0] };
                    pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]- point1_lvl1_x[3:0] }; 
            end
            else if( ( (point_enable[1] == 1 )&&(hcount_in >= point2_lvl1_x) && (hcount_in < (point2_lvl1_x+point_w)) && (vcount_in >= point2_lvl1_y)&&(vcount_in < (point2_lvl1_y+point_h))  ) )
            begin
                    pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-point2_lvl1_y[3:0] };
                    pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-point2_lvl1_x[3:0] }; 
            end
            else if( ( (point_enable[2] == 1 )&&(hcount_in >= point3_lvl1_x) && (hcount_in < (point3_lvl1_x+point_w)) && (vcount_in >= point3_lvl1_y)&&(vcount_in < (point3_lvl1_y+point_h))  ) )   
            begin 
                    pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-point3_lvl1_y[3:0] };
                    pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-point3_lvl1_x[3:0] }; 
            
            end
            else if( ( (point_enable[3] == 1 )&&(hcount_in >= point4_lvl1_x) && (hcount_in < (point4_lvl1_x+point_w)) && (vcount_in >= point4_lvl1_y)&&(vcount_in < (point4_lvl1_y+point_h))  ) )
            begin
                   pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-point4_lvl1_y[3:0] };
                   pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-point4_lvl1_x[3:0] }; 
            end
            else if( ( (point_enable[4] == 1 )&&(hcount_in >= point5_lvl1_x) && (hcount_in < (point5_lvl1_x+point_w)) && (vcount_in >= point5_lvl1_y)&&(vcount_in < (point5_lvl1_y+point_h))  ) )
            begin
                   pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-point5_lvl1_y[3:0] };
                   pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-point5_lvl1_x[3:0] }; 
            end
             else 
                   pixel_addr_nxt = pixel_addr;
                   
            if( ( (point_enable[0] == 1 )&&(hcount_delay2 >= point1_lvl1_x) && (hcount_delay2  < (point1_lvl1_x+point_w)) && (vcount_delay2  >= point1_lvl1_y)&&(vcount_delay2  < (point1_lvl1_y+point_h))  ) 
            || ( (point_enable[1] == 1 )&&(hcount_delay2  >= point2_lvl1_x) && (hcount_delay2  < (point2_lvl1_x+point_w)) && (vcount_delay2  >= point2_lvl1_y)&&(vcount_delay2  < (point2_lvl1_y+point_h))  )  
            || ( (point_enable[2] == 1 )&&(hcount_delay2  >= point3_lvl1_x) && (hcount_delay2  < (point3_lvl1_x+point_w)) && (vcount_delay2  >= point3_lvl1_y)&&(vcount_delay2  < (point3_lvl1_y+point_h))  )    
            || ( (point_enable[3] == 1 )&&(hcount_delay2  >= point4_lvl1_x) && (hcount_delay2  < (point4_lvl1_x+point_w)) && (vcount_delay2  >= point4_lvl1_y)&&(vcount_delay2  < (point4_lvl1_y+point_h))  ) 
            || ( (point_enable[4] == 1 )&&(hcount_delay2  >= point5_lvl1_x) && (hcount_delay2  < (point5_lvl1_x+point_w)) && (vcount_delay2  >= point5_lvl1_y)&&(vcount_delay2  < (point5_lvl1_y+point_h))  ))
            rgb_nxt = rgb_pixel;
            else 
                rgb_nxt = rgb_delay2;
         end
         
         3'b010:
         begin
           
                 if(  ( (point_enable[0] == 1 )&& (hcount_in >= point1_lvl2_x) && (hcount_in < (point1_lvl2_x+point_w)) && (vcount_in >= point1_lvl2_y)&&(vcount_in < (point1_lvl2_y+point_h))  )) 
                 begin
                            pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-point1_lvl2_y[3:0] };
                            pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-point1_lvl2_x[3:0] }; 
                 end
                 else if(( (point_enable[1] == 1 )&& (hcount_in >= point2_lvl2_x) && (hcount_in < (point2_lvl2_x+point_w)) && (vcount_in >= point2_lvl2_y)&&(vcount_in < (point2_lvl2_y+point_h))  ))  
                 begin
                            pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-point2_lvl2_y[3:0] };
                            pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-point2_lvl2_x[3:0] };                  
                 end
                 else if(( (point_enable[2] == 1 )&& (hcount_in >= point3_lvl2_x) && (hcount_in < (point3_lvl2_x+point_w)) && (vcount_in >= point3_lvl2_y)&&(vcount_in < (point3_lvl2_y+point_h))  ))   
                 begin
                            pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-point3_lvl2_y[3:0] };
                            pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-point3_lvl2_x[3:0] };                  
                 end
                 else if(( (point_enable[3] == 1 )&& (hcount_in >= point4_lvl2_x) && (hcount_in < (point4_lvl2_x+point_w)) && (vcount_in >= point4_lvl2_y)&&(vcount_in < (point4_lvl2_y+point_h))  )) 
                 begin
                            pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-point4_lvl2_y[3:0] };
                            pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-point4_lvl2_x[3:0] }; 
                 end
                 else if(( (point_enable[4] == 1 )&& (hcount_in >= point5_lvl2_x) && (hcount_in < (point5_lvl2_x+point_w)) && (vcount_in >= point5_lvl2_y)&&(vcount_in < (point5_lvl2_y+point_h))  ))  
                 begin
                            pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-point5_lvl2_y[3:0] };
                            pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-point5_lvl2_x[3:0] }; 
                 end
                 else 
                       pixel_addr_nxt = pixel_addr;
                 
                 if(  ( (point_enable[0] == 1 )&& (hcount_delay2 >= point1_lvl2_x) && (hcount_delay2 < (point1_lvl2_x+point_w)) && (vcount_delay2 >= point1_lvl2_y)&&(vcount_delay2 < (point1_lvl2_y+point_h))  ) 
                 ||( (point_enable[1] == 1 )&& (hcount_delay2 >= point2_lvl2_x) && (hcount_delay2 < (point2_lvl2_x+point_w)) && (vcount_delay2 >= point2_lvl2_y)&&(vcount_delay2 < (point2_lvl2_y+point_h))  )  
                 ||( (point_enable[2] == 1 )&& (hcount_delay2 >= point3_lvl2_x) && (hcount_delay2 < (point3_lvl2_x+point_w)) && (vcount_delay2 >= point3_lvl2_y)&&(vcount_delay2 < (point3_lvl2_y+point_h))  )    
                 ||( (point_enable[3] == 1 )&& (hcount_delay2 >= point4_lvl2_x) && (hcount_delay2 < (point4_lvl2_x+point_w)) && (vcount_delay2 >= point4_lvl2_y)&&(vcount_delay2 < (point4_lvl2_y+point_h))  ) 
                 ||( (point_enable[4] == 1 )&& (hcount_delay2 >= point5_lvl2_x) && (hcount_delay2 < (point5_lvl2_x+point_w)) && (vcount_delay2 >= point5_lvl2_y)&&(vcount_delay2 < (point5_lvl2_y+point_h))  ))  
                  rgb_nxt = rgb_pixel;
                  else 
                          rgb_nxt = rgb_delay2;
     
                     
         end
          
          3'b011:
          begin
          
           
            if(   ( (point_enable[0] == 1 )&&(hcount_in >= point1_lvl3_x) && (hcount_in < (point1_lvl3_x+point_w)) && (vcount_in >= point1_lvl3_y)&&(vcount_in < (point1_lvl3_y+point_h))  )) 
            begin
                       pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-point1_lvl3_y[3:0] };
                       pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-point1_lvl3_x[3:0] }; 
            end            
            else if( ( (point_enable[1] == 1 )&&(hcount_in >= point2_lvl3_x) && (hcount_in < (point2_lvl3_x+point_w)) && (vcount_in >= point2_lvl3_y)&&(vcount_in < (point2_lvl3_y+point_h))  ))  
            begin
                       pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-point2_lvl3_y[3:0] };
                       pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-point2_lvl3_x[3:0] }; 
            end            
            else if( ( (point_enable[2] == 1 )&&(hcount_in >= point3_lvl3_x) && (hcount_in < (point3_lvl3_x+point_w)) && (vcount_in >= point3_lvl3_y)&&(vcount_in < (point3_lvl3_y+point_h))  ))    
            begin
                       pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-point3_lvl3_y[3:0] };
                       pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-point3_lvl3_x[3:0] }; 
            end            
            else if( ( (point_enable[3] == 1 )&&(hcount_in >= point4_lvl3_x) && (hcount_in < (point4_lvl3_x+point_w)) && (vcount_in >= point4_lvl3_y)&&(vcount_in < (point4_lvl3_y+point_h))  )) 
            begin
                       pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-point4_lvl3_y[3:0] };
                       pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-point4_lvl3_x[3:0] }; 
            end            
            else if( ( (point_enable[4] == 1 )&&(hcount_in >= point5_lvl3_x) && (hcount_in < (point5_lvl3_x+point_w)) && (vcount_in >= point5_lvl3_y)&&(vcount_in < (point5_lvl3_y+point_h))  ))
            begin
                       pixel_addr_nxt[11:6] = {2'b00, vcount_in[3:0]-point5_lvl3_y[3:0] };
                       pixel_addr_nxt[5:0] =  {2'b00, hcount_in[3:0]-point5_lvl3_x[3:0] }; 
            end   
            else 
                  pixel_addr_nxt = pixel_addr;
   
            if(   ( (point_enable[0] == 1 )&&(hcount_delay2 >= point1_lvl3_x) && (hcount_delay2 < (point1_lvl3_x+point_w)) && (vcount_delay2 >= point1_lvl3_y)&&(vcount_delay2 < (point1_lvl3_y+point_h))  ) 
            || ( (point_enable[1] == 1 )&&(hcount_delay2 >= point2_lvl3_x) && (hcount_delay2 < (point2_lvl3_x+point_w)) && (vcount_delay2 >= point2_lvl3_y)&&(vcount_delay2 < (point2_lvl3_y+point_h))  )  
            || ( (point_enable[2] == 1 )&&(hcount_delay2 >= point3_lvl3_x) && (hcount_delay2 < (point3_lvl3_x+point_w)) && (vcount_delay2 >= point3_lvl3_y)&&(vcount_delay2 < (point3_lvl3_y+point_h))  )    
            || ( (point_enable[3] == 1 )&&(hcount_delay2 >= point4_lvl3_x) && (hcount_delay2 < (point4_lvl3_x+point_w)) && (vcount_delay2 >= point4_lvl3_y)&&(vcount_delay2 < (point4_lvl3_y+point_h))  ) 
            || ( (point_enable[4] == 1 )&&(hcount_delay2 >= point5_lvl3_x) && (hcount_delay2 < (point5_lvl3_x+point_w)) && (vcount_delay2 >= point5_lvl3_y)&&(vcount_delay2 < (point5_lvl3_y+point_h))  ))
            rgb_nxt = rgb_pixel;
            else 
            rgb_nxt = rgb_delay2;
          end
         
         default: rgb_nxt = rgb_in;  
         endcase
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

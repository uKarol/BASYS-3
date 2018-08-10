`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2018 14:45:25
// Design Name: 
// Module Name: collect_points
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


module collect_points(
        input clk,
        input rst,
        input [11:0] x_pos,
        input [11:0] y_pos,
        input [2:0]lvl,
        output reg [4:0] captured
          
    );
    
    reg [4:0] captured_nxt;
    
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
        box1_w = 48,
        box1_h = 64;
    
    always @*
    begin 
        
        case( lvl )
            
            3'b001:
            begin 
            
                if( !(
                    (x_pos > point1_lvl1_x + point_w)||(x_pos + box1_w < point1_lvl1_x)||
                    (y_pos > point_h + point1_lvl1_y)||(y_pos + box1_h < point1_lvl1_y)
                    ) && 
                    (captured_nxt[0]!= 1) )
                    begin 
                         captured_nxt = captured;
                         captured_nxt[0] = 1; 
                    end
                else if( !(
                    (x_pos > point2_lvl1_x + point_w)||(x_pos + box1_w < point2_lvl1_x)||
                    (y_pos > point_h + point2_lvl1_y)||(y_pos + box1_h < point2_lvl1_y)
                    ) && 
                    (captured_nxt[1]!= 1) )
                    begin
                        captured_nxt = captured;
                        captured_nxt[1] = 1; 
                    end
                else if( !(
                    (x_pos > point3_lvl1_x + point_w)||(x_pos + box1_w < point3_lvl1_x)||
                    (y_pos > point_h + point3_lvl1_y)||(y_pos + box1_h < point3_lvl1_y)
                    ) && 
                    (captured_nxt[2]!= 1)
                    ) begin 
                         captured_nxt = captured;
                         captured_nxt[2] = 1;
                      end 
                else if(!(
                    (x_pos > point4_lvl1_x + point_w)||(x_pos + box1_w < point4_lvl1_x)||
                    (y_pos > point_h + point4_lvl1_y)||(y_pos + box1_h < point4_lvl1_y)
                    ) && 
                    (captured_nxt[3]!= 1)
                 ) begin 
                      captured_nxt = captured;
                      captured_nxt[3] = 1; 
                end
                else if(!(
                    (x_pos > point5_lvl1_x + point_w)||(x_pos + box1_w < point5_lvl1_x)||
                    (y_pos > point_h + point5_lvl1_y)||(y_pos + box1_h < point5_lvl1_y)
                    ) && 
                    (captured_nxt[4]!= 1)
                )begin 
                    captured_nxt = captured; 
                    captured_nxt[4] = 1;
                end 
                else captured_nxt = captured;
                
            end
            
            3'b010:
            begin
            if( !(
                (x_pos > point1_lvl2_x + point_w)||(x_pos + box1_w < point1_lvl2_x)||
                (y_pos > point_h + point1_lvl2_y)||(y_pos + box1_h < point1_lvl2_y)
                ) && 
                (captured_nxt[0]!= 1) ) captured_nxt[0] = 1; 
            else if( !(
                (x_pos > point2_lvl2_x + point_w)||(x_pos + box1_w < point2_lvl2_x)||
                (y_pos > point_h + point2_lvl2_y)||(y_pos + box1_h < point2_lvl2_y)
                ) && 
                (captured_nxt[1]!= 1) ) captured_nxt[1] = 1; 
            else if( !(
                (x_pos > point3_lvl2_x + point_w)||(x_pos + box1_w < point3_lvl2_x)||
                (y_pos > point_h + point3_lvl2_y)||(y_pos + box1_h < point3_lvl2_y)
                ) && 
                (captured_nxt[2]!= 1)
                ) captured_nxt[2] = 1; 
            else if(!(
                (x_pos > point4_lvl2_x + point_w)||(x_pos + box1_w < point4_lvl2_x)||
                (y_pos > point_h + point4_lvl2_y)||(y_pos + box1_h < point4_lvl2_y)
                ) && 
                (captured_nxt[3]!= 1)
             ) captured_nxt[3] = 1; 
            else if(!(
                (x_pos > point5_lvl2_x + point_w)||(x_pos + box1_w < point5_lvl2_x)||
                (y_pos > point_h + point5_lvl2_y)||(y_pos + box1_h < point5_lvl2_y)
                ) && 
                (captured_nxt[4]!= 1)
            ) captured_nxt[4] = 1; 
            else captured_nxt = captured;
            
            end
            3'b011:
            begin 
           
           if( !(
                (x_pos > point1_lvl3_x + point_w)||(x_pos + box1_w < point1_lvl3_x)||
                (y_pos > point_h + point1_lvl3_y)||(y_pos + box1_h < point1_lvl3_y)
                ) && 
                (captured_nxt[0]!= 1) ) captured_nxt[0] = 1; 
            else if( !(
                (x_pos > point2_lvl3_x + point_w)||(x_pos + box1_w < point2_lvl3_x)||
                (y_pos > point_h + point2_lvl3_y)||(y_pos + box1_h < point2_lvl3_y)
                ) && 
                (captured_nxt[1]!= 1) ) captured_nxt[1] = 1; 
            else if( !(
                (x_pos > point3_lvl3_x + point_w)||(x_pos + box1_w < point3_lvl3_x)||
                (y_pos > point_h + point3_lvl3_y)||(y_pos + box1_h < point3_lvl3_y)
                ) && 
                (captured_nxt[2]!= 1)
                ) captured_nxt[2] = 1; 
            else if(!(
                (x_pos > point4_lvl3_x + point_w)||(x_pos + box1_w < point4_lvl3_x)||
                (y_pos > point_h + point4_lvl3_y)||(y_pos + box1_h < point4_lvl3_y)
                ) && 
                (captured_nxt[3]!= 1)
             ) captured_nxt[3] = 1; 
            else if(!(
                (x_pos > point5_lvl3_x + point_w)||(x_pos + box1_w < point5_lvl3_x)||
                (y_pos > point_h + point5_lvl3_y)||(y_pos + box1_h < point5_lvl3_y)
                ) && 
                (captured_nxt[4]!= 1)
            ) captured_nxt[4] = 1; 
            
            else captured_nxt = captured;
            
            end
            
            default: captured_nxt = captured; 
            
            
        
        
        endcase 
    
    
    end 
    
    always @(posedge clk or posedge rst)
    begin     
        if(rst == 1) captured <= 0;
        else captured <= captured_nxt;
    end 
    
endmodule

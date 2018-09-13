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
        output reg [4:0] captured,
        output reg capture_point
          
    );
    
    
    reg capture_point_nxt;
    reg [4:0] captured_nxt;
    
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
        point5_lvl3_y =110,

                        
        box1_w = 64,
        box1_h  = 15,
        box1_x = 0,
        box1_y = 49,
        
        box2_w = 32,
        box2_h = 28,
        box2_x = 17,
        box2_y= 17;
    
    always @*
    begin 
        
        case( lvl )
            
            3'b001:
            begin 
            
                if( !(
                    ((x_pos + box1_x > point1_lvl1_x + point_w)||(x_pos + box1_x + box1_w < point1_lvl1_x)||
                    (y_pos + box1_y > point_h + point1_lvl1_y)||(y_pos + box1_y + box1_h < point1_lvl1_y))&&
                    ((x_pos + box2_x > point1_lvl1_x + point_w)||(x_pos + box2_x + box2_w < point1_lvl1_x)||
                    (y_pos + box2_y > point_h + point1_lvl1_y)||(y_pos + box2_y + box2_h < point1_lvl1_y))
                    ) && 
                    (captured[0]!= 1) )
                    begin 
                         captured_nxt = captured;
                         captured_nxt[0] = 1; 
                         capture_point_nxt = 1;
                    end
                else if( !(
                    ((x_pos + box1_x > point2_lvl1_x + point_w)||(x_pos + box1_x + box1_w < point2_lvl1_x)||
                    (y_pos + box1_y > point_h + point2_lvl1_y)||(y_pos + box1_y + box1_h < point2_lvl1_y))&&
                    ((x_pos + box2_x > point2_lvl1_x + point_w)||(x_pos + box2_x + box2_w < point2_lvl1_x)||
                    (y_pos + box2_y > point_h + point2_lvl1_y)||(y_pos + box2_y + box2_h < point2_lvl1_y))                    
                    ) && 
                    (captured[1]!= 1) )
                    begin
                        captured_nxt = captured;
                        captured_nxt[1] = 1; 
                        capture_point_nxt = 1;
                    end
                else if( !(
                    ((x_pos + box1_x > point3_lvl1_x + point_w)||(x_pos + box1_x + box1_w < point3_lvl1_x)||
                    (y_pos + box1_y > point_h + point3_lvl1_y)||(y_pos + box1_y + box1_h < point3_lvl1_y))&&
                    ((x_pos + box2_x > point3_lvl1_x + point_w)||(x_pos + box2_x + box2_w < point3_lvl1_x)||
                    (y_pos + box2_y > point_h + point3_lvl1_y)||(y_pos + box2_y + box2_h < point3_lvl1_y))
                    ) && 
                    (captured[2]!= 1)
                    ) begin 
                         captured_nxt = captured;
                         captured_nxt[2] = 1;
                         capture_point_nxt = 1;
                      end 
                else if(!(
                    ((x_pos + box1_x > point4_lvl1_x + point_w)||(x_pos + box1_x + box1_w < point4_lvl1_x)||
                    (y_pos + box1_y > point_h + point4_lvl1_y)||(y_pos + box1_y + box1_h < point4_lvl1_y))&&
                    ((x_pos + box2_x > point4_lvl1_x + point_w)||(x_pos + box2_x + box2_w < point4_lvl1_x)||
                    (y_pos + box2_y > point_h + point4_lvl1_y)||(y_pos + box2_y + box2_h < point4_lvl1_y))
                    
                    ) && 
                    (captured[3]!= 1)
                 ) begin 
                      captured_nxt = captured;
                      captured_nxt[3] = 1; 
                      capture_point_nxt = 1;
                end
                else if(!(
                    ((x_pos + box1_x > point5_lvl1_x + point_w)||(x_pos + box1_x + box1_w < point5_lvl1_x)||
                    (y_pos + box1_y > point_h + point5_lvl1_y)||(y_pos + box1_y + box1_h < point5_lvl1_y))&&
                    ((x_pos + box2_x > point5_lvl1_x + point_w)||(x_pos + box2_x + box2_w < point5_lvl1_x)||
                    (y_pos + box2_y > point_h + point5_lvl1_y)||(y_pos + box2_y + box2_h < point5_lvl1_y))                    
                    ) && 
                    (captured[4]!= 1)
                )begin 
                    captured_nxt = captured; 
                    captured_nxt[4] = 1;
                    capture_point_nxt = 1;
                end 
                else 
                begin
                    captured_nxt = captured;
                    capture_point_nxt = 0;
                end
                
                
            end
            
            3'b010:
            begin
            if( !(
                ((x_pos + box1_x > point1_lvl2_x + point_w)||(x_pos + box1_x + box1_w < point1_lvl2_x)||
                (y_pos + box1_y> point_h + point1_lvl2_y)||(y_pos + box1_y+ box1_h < point1_lvl2_y))&&
                ((x_pos + box2_x > point1_lvl2_x + point_w)||(x_pos + box2_x + box2_w < point1_lvl2_x)||
                (y_pos + box2_y> point_h + point1_lvl2_y)||(y_pos + box2_y+ box2_h < point1_lvl2_y))
                ) && 
                (captured[0]!= 1) ) 
                begin 
                     captured_nxt = captured;
                     captured_nxt[0] = 1; 
                     capture_point_nxt = 1;
                end
            else if( !(
                ((x_pos+ box1_x > point2_lvl2_x + point_w)||(x_pos + box1_x + box1_w < point2_lvl2_x)||
                (y_pos+ box1_y > point_h + point2_lvl2_y)||(y_pos + box1_y+ box1_h < point2_lvl2_y))&&
                ((x_pos+ box2_x > point2_lvl2_x + point_w)||(x_pos + box2_x + box2_w < point2_lvl2_x)||
                (y_pos+ box2_y > point_h + point2_lvl2_y)||(y_pos + box2_y+ box2_h < point2_lvl2_y))
                ) && 
                (captured[1]!= 1) )
                begin 
                     captured_nxt = captured;
                     captured_nxt[1] = 1; 
                     capture_point_nxt = 1;
                end 
            else if( !(
                ((x_pos + box1_x > point3_lvl2_x + point_w)||(x_pos + box1_x+ box1_w < point3_lvl2_x)||
                (y_pos + box1_y> point_h + point3_lvl2_y)||(y_pos + box1_y+ box1_h < point3_lvl2_y))&&
                ((x_pos + box2_x > point3_lvl2_x + point_w)||(x_pos + box2_x+ box2_w < point3_lvl2_x)||
                (y_pos + box2_y> point_h + point3_lvl2_y)||(y_pos + box2_y+ box2_h < point3_lvl2_y))
                ) && 
                (captured[2]!= 1))
                begin 
                     captured_nxt = captured;
                     captured_nxt[2] = 1; 
                     capture_point_nxt = 1;
                end 
            else if(!(
                ((x_pos + box1_x> point4_lvl2_x + point_w)||(x_pos + box1_x + box1_w < point4_lvl2_x)||
                (y_pos + box1_y> point_h + point4_lvl2_y)||(y_pos + box1_y+ box1_h < point4_lvl2_y))&&
                ((x_pos + box2_x> point4_lvl2_x + point_w)||(x_pos + box2_x + box2_w < point4_lvl2_x)||
                (y_pos + box2_y> point_h + point4_lvl2_y)||(y_pos + box2_y+ box2_h < point4_lvl2_y))                
                ) && 
                (captured[3]!= 1))
              begin 
                     captured_nxt = captured;
                     captured_nxt[3] = 1; 
                     capture_point_nxt = 1;
                end
            else if(!(
                ((x_pos + box1_x > point5_lvl2_x + point_w)||(x_pos + box1_x + box1_w < point5_lvl2_x)||
                (y_pos + box1_y > point_h + point5_lvl2_y)||(y_pos + box1_y + box1_h < point5_lvl2_y))&&
                ((x_pos + box2_x > point5_lvl2_x + point_w)||(x_pos + box2_x + box2_w < point5_lvl2_x)||
                (y_pos + box2_y > point_h + point5_lvl2_y)||(y_pos + box2_y + box2_h < point5_lvl2_y))
                ) && 
                (captured[4]!= 1))                    
                begin 
                     captured_nxt = captured;
                     captured_nxt[4] = 1; 
                     capture_point_nxt = 1;
                end
            else 
            begin
                captured_nxt = captured;
                capture_point_nxt = 0;
            end
            
            end
            3'b011:
            begin 
           
           if( !(
                ((x_pos + box1_x> point1_lvl3_x + point_w)||(x_pos + box1_x+ box1_w < point1_lvl3_x)||
                (y_pos + box1_y> point_h + point1_lvl3_y)||(y_pos + box1_y+ box1_h < point1_lvl3_y))&&
                ((x_pos + box2_x> point1_lvl3_x + point_w)||(x_pos + box2_x+ box2_w < point1_lvl3_x)||
                (y_pos + box2_y> point_h + point1_lvl3_y)||(y_pos + box2_y+ box2_h < point1_lvl3_y))
                ) && 
                (captured[0]!= 1) )
                begin 
                     captured_nxt = captured;
                     captured_nxt[0] = 1; 
                     capture_point_nxt = 1;
                end 
            else if( !(
                ((x_pos + box1_x> point2_lvl3_x + point_w)||(x_pos + box1_x + box1_w < point2_lvl3_x)||
                (y_pos + box1_y> point_h + point2_lvl3_y)||(y_pos + box1_y + box1_h < point2_lvl3_y))&&
                ((x_pos + box2_x> point2_lvl3_x + point_w)||(x_pos + box2_x + box2_w < point2_lvl3_x)||
                (y_pos + box2_y> point_h + point2_lvl3_y)||(y_pos + box2_y + box2_h < point2_lvl3_y))
                ) && 
                (captured[1]!= 1) )
                begin 
                     captured_nxt = captured;
                     captured_nxt[1] = 1; 
                     capture_point_nxt = 1;
                end 
            else if( !(
                ((x_pos + box1_x> point3_lvl3_x + point_w)||(x_pos + box1_x+ box1_w < point3_lvl3_x)||
                (y_pos + box1_y> point_h + point3_lvl3_y)||(y_pos + box1_y+ box1_h < point3_lvl3_y))&&
                ((x_pos + box2_x> point3_lvl3_x + point_w)||(x_pos + box2_x+ box2_w < point3_lvl3_x)||
                (y_pos + box2_y> point_h + point3_lvl3_y)||(y_pos + box2_y+ box2_h < point3_lvl3_y))
                ) && 
                (captured[2]!= 1) )
                begin 
                     captured_nxt = captured;
                     captured_nxt[2] = 1;
                     capture_point_nxt = 1; 
                end 
            else if(!(
                ((x_pos + box1_x > point4_lvl3_x + point_w)||(x_pos + box1_x + box1_w < point4_lvl3_x)||
                (y_pos + box1_y > point_h + point4_lvl3_y)||(y_pos + box1_y + box1_h < point4_lvl3_y))&&
                ((x_pos + box2_x > point4_lvl3_x + point_w)||(x_pos + box2_x + box2_w < point4_lvl3_x)||
                (y_pos + box2_y > point_h + point4_lvl3_y)||(y_pos + box2_y + box2_h < point4_lvl3_y))
                ) && 
                (captured[3]!= 1))
                begin 
                     captured_nxt = captured;
                     captured_nxt[3] = 1;
                     capture_point_nxt = 1; 
                end 
            else if(!(
                ((x_pos + box1_x > point5_lvl3_x + point_w)||(x_pos + box1_x + box1_w < point5_lvl3_x)||
                (y_pos + box1_y > point_h + point5_lvl3_y)||(y_pos + box1_y + box1_h < point5_lvl3_y))&&
                ((x_pos + box2_x > point5_lvl3_x + point_w)||(x_pos + box2_x + box2_w < point5_lvl3_x)||
                (y_pos + box2_y > point_h + point5_lvl3_y)||(y_pos + box2_y + box2_h < point5_lvl3_y))
                ) && 
                (captured[4]!= 1)) 
           begin 
                 captured_nxt = captured;
                 captured_nxt[4] = 1; 
                 capture_point_nxt = 1;
            end 
            
            else 
            begin
                captured_nxt = captured;
                capture_point_nxt = 0;
            end
            end
            
            default: 
            begin
                captured_nxt = captured; 
                capture_point_nxt = 0;
            end
            
            
        
        
        endcase 
    
    
    end 
    
    always @(posedge clk or posedge rst)
    begin     
        if(rst == 1)begin 
            captured <= 0;
            capture_point <= 0;
        end
        else 
        begin
            captured <= captured_nxt;
            capture_point <= capture_point_nxt;
        end
    end 
    
endmodule

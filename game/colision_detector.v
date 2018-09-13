`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.08.2018 16:01:54
// Design Name: 
// Module Name: colision_detector
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


module colision_detector(
    
        input wire rst,
        input wire clk,
        input wire [2:0] lvl,
        input wire [11:0] x_pos,
        input wire [11:0] y_pos,
        output reg colission_up,
        output reg colission_down,
        
        output reg landed,
        input wire landing_enable,
        
        output reg colission_left,
        output reg colission_right
        
    );
    
    reg colission_left_nxt;
    reg colission_right_nxt;
    reg colission_up_nxt;
    reg colission_down_nxt;
    reg landed_nxt;
    
    localparam
    
        color = 0,
        
        //lvl1
        
        lvl1_obst1_x=200,
        lvl1_obst1_y=250,
        lvl1_obst1_h=20,
        lvl1_obst1_w=150,
        
        lvl1_obst2_x=450,
        lvl1_obst2_y=150,
        lvl1_obst2_h=20,
        lvl1_obst2_w=150,
        
        lvl1_obst3_x=200,
        lvl1_obst3_y=530,
        lvl1_obst3_h=60,
        lvl1_obst3_w=70,
        
        lvl1_obst4_x=280,
        lvl1_obst4_y=490,
        lvl1_obst4_h=100,
        lvl1_obst4_w=60,
        
        
        // lvl 2    
        
        lvl2_obst1_x=40,
        lvl2_obst1_y=360,
        lvl2_obst1_h=20,
        lvl2_obst1_w=150,
        
        lvl2_obst2_x=200,
        lvl2_obst2_y=130,
        lvl2_obst2_h=20,
        lvl2_obst2_w=150,
        
        lvl2_obst3_x=300,
        lvl2_obst3_y=270,
        lvl2_obst3_h=20,
        lvl2_obst3_w=450,
        
        lvl2_obst4_x=280,
        lvl2_obst4_y=490,
        lvl2_obst4_h=100,
        lvl2_obst4_w=60,
        
        lvl2_obst5_x=200,
        lvl2_obst5_y=530,
        lvl2_obst5_h=60,
        lvl2_obst5_w=70,
        
        
        // lvl 3    
        
        lvl3_obst1_x=60,
        lvl3_obst1_y=150,
        lvl3_obst1_h=20,
        lvl3_obst1_w=110,
        
        lvl3_obst2_x=250,
        lvl3_obst2_y=380,
        lvl3_obst2_h=190,
        lvl3_obst2_w=80,
        
        lvl3_obst3_x=330,
        lvl3_obst3_y=270,
        lvl3_obst3_h=300,
        lvl3_obst3_w=60,
        
        lvl3_obst4_x=390,
        lvl3_obst4_y=440,
        lvl3_obst4_h=130,
        lvl3_obst4_w=120,
        
        lvl3_obst5_x=520,
        lvl3_obst5_y=40,
        lvl3_obst5_h=60,
        lvl3_obst5_w=220,
        
        lvl3_obst6_x=540,
        lvl3_obst6_y=40,
        lvl3_obst6_h=100,
        lvl3_obst6_w=60,
        
        lvl3_obst7_x=680,
        lvl3_obst7_y=330,
        lvl3_obst7_h=20,
        lvl3_obst7_w=120,
        
        landing2_x=630,
        landing2_y=560,
        landing2_h=20,
        landing2_w=115,
                
        box1_w = 64,
        box1_h  = 15,
        box1_x = 0,
        box1_y = 49,
        
        box2_w = 32,
        box2_h = 28,
        box2_x = 17,
        box2_y= 17;
        
        //left-right colissions 
        
        always@* 
        begin 
        
            case(lvl)
            
            3'b001:
            begin 
                
               if (
               
                ((x_pos + box1_x == 799 - box1_w)||
               
                (( x_pos + box1_x + box1_w == lvl1_obst1_x ) &&
                ( y_pos + box1_y <= lvl1_obst1_y + lvl1_obst1_h ) &&
                ( y_pos + box1_y + box1_h >= lvl1_obst1_y ) ) ||
                
                (( x_pos+ box1_x + box1_w == lvl1_obst2_x ) &&
                ( y_pos+ box1_y <= lvl1_obst2_y + lvl1_obst2_h ) &&
                ( y_pos + box1_y+ box1_h >= lvl1_obst2_y ) ) ||
                
                (( x_pos + box1_x + box1_w == lvl1_obst3_x ) &&
                ( y_pos + box1_y <= lvl1_obst3_y + lvl1_obst3_h ) &&
                ( y_pos + box1_h + box1_y >= lvl1_obst3_y ) ) ||
                
                (( x_pos + box1_x + box1_w == lvl1_obst4_x ) &&
                ( y_pos + box1_y <= lvl1_obst4_y + lvl1_obst4_h ) &&
                ( y_pos + box1_h + box1_y >= lvl1_obst4_y ) )  ||
                
                (( x_pos +box1_x+ box1_w == landing2_x ) &&
                ( y_pos + box1_y <= landing2_y + landing2_h ) &&
                ( y_pos + box1_y +box1_h >= landing2_y )&&
                (landing_enable==1) ) ) ||
                
                ((x_pos + box2_x == 799 - box2_w)||
                               
                (( x_pos + box2_x + box2_w == lvl1_obst1_x ) &&
                ( y_pos + box2_y <= lvl1_obst1_y + lvl1_obst1_h ) &&
                ( y_pos + box2_y + box2_h >= lvl1_obst1_y ) ) ||
                                
                (( x_pos + box2_x + box2_w == lvl1_obst2_x ) &&
                ( y_pos + box2_y <= lvl1_obst2_y + lvl1_obst2_h ) &&
                ( y_pos + box2_y + box2_h >= lvl1_obst2_y ) ) ||
                                
                (( x_pos + box2_x + box2_w == lvl1_obst3_x ) &&
                ( y_pos + box2_y <= lvl1_obst3_y + lvl1_obst3_h ) &&
                ( y_pos + box2_y + box2_h >= lvl1_obst3_y ) ) ||
                                
                (( x_pos + box2_x + box2_w == lvl1_obst4_x ) &&
                ( y_pos + box2_y<= lvl1_obst4_y + lvl1_obst4_h ) &&
                ( y_pos + box2_y + box2_h >= lvl1_obst4_y ) )  ||
                                
                (( x_pos + box2_x + box2_w == landing2_x ) &&
                ( y_pos +box2_y <= landing2_y + landing2_h ) &&
                ( y_pos + box2_y + box2_h >= landing2_y )&&
                (landing_enable==1) ) ) 
                
                ) begin
                     colission_right_nxt = 1;
                     colission_left_nxt = 0;
                end
                else if(
                    
                   ( (x_pos == 0)||
                    
                    (  ( x_pos + box1_x  == lvl1_obst1_x + lvl1_obst1_w) &&
                    ( y_pos + box1_y <= lvl1_obst1_y + lvl1_obst1_h ) &&
                    ( y_pos + box1_y + box1_h >= lvl1_obst1_y ) ) ||
                    
                    (  ( x_pos + box1_x == lvl1_obst2_x + lvl1_obst2_w) &&
                    ( y_pos + box1_y <= lvl1_obst2_y + lvl1_obst2_h ) &&
                    ( y_pos + box1_y + box1_h >= lvl1_obst2_y ) ) ||
                    
                    (  ( x_pos + box1_x== lvl1_obst3_x + lvl1_obst3_w) &&
                    ( y_pos + box1_y<= lvl1_obst3_y + lvl1_obst3_h ) &&
                    ( y_pos + box1_y + box1_h  >= lvl1_obst3_y ) ) ||
                    
                    (  ( x_pos + box1_x == lvl1_obst4_x + lvl1_obst4_w) &&
                    ( y_pos + box1_y <= lvl1_obst4_y + lvl1_obst4_h ) &&
                    ( y_pos + box1_y + box1_h >= lvl1_obst4_y ) )||
                                        
                    (  ( x_pos + box1_x == landing2_x + landing2_w) &&
                    ( y_pos + box1_y <= landing2_y + landing2_h ) &&
                    ( y_pos + box1_y + box1_h >= landing2_y ) &&
                    (landing_enable==1)) ) ||
                    
                    
                   ( (  ( x_pos + box2_x == lvl1_obst1_x + lvl1_obst1_w) &&
                    ( y_pos  + box2_y <= lvl1_obst1_y + lvl1_obst1_h ) &&
                    ( y_pos  + box2_y + box2_h >= lvl1_obst1_y ) ) ||
                                        
                    (  ( x_pos  + box2_x == lvl1_obst2_x + lvl1_obst2_w) &&
                    ( y_pos  + box2_y <= lvl1_obst2_y + lvl1_obst2_h ) &&
                    ( y_pos  + box2_y + box2_h >= lvl1_obst2_y ) ) ||
                                        
                    (  ( x_pos  + box2_x == lvl1_obst3_x + lvl1_obst3_w) &&
                    ( y_pos + box2_y <= lvl1_obst3_y + lvl1_obst3_h ) &&
                    ( y_pos + box2_y + box2_h >= lvl1_obst3_y ) ) ||
                                       
                    (  ( x_pos  + box2_x  == lvl1_obst4_x + lvl1_obst4_w) &&
                    ( y_pos  + box2_y<= lvl1_obst4_y + lvl1_obst4_h ) &&
                    ( y_pos  + box2_y + box2_h >= lvl1_obst4_y ) )||
                                                            
                    (  ( x_pos  + box2_x == landing2_x + landing2_w) &&
                   ( y_pos  + box2_y <= landing2_y + landing2_h ) &&
                    ( y_pos  + box2_y + box2_h >= landing2_y ) &&
                     (landing_enable==1)) )  
                    
                    ) begin
                        colission_left_nxt = 1;
                        colission_right_nxt = 0;
                     end
                else 
                begin
                      colission_left_nxt = 0;
                      colission_right_nxt = 0;
                end
                
               
            end
            
            
            
            3'b010:
            begin 
                
               if (
               
                ((x_pos + box1_x== 799 - box1_w)||
               
                (( x_pos + box1_x +  box1_w == lvl2_obst1_x ) &&
                ( y_pos + box1_y <= lvl2_obst1_y + lvl2_obst1_h ) &&
                ( y_pos + box1_y+ box1_h >= lvl2_obst1_y ) ) ||
                
                (( x_pos + box1_x + box1_w == lvl2_obst2_x ) &&
                ( y_pos + box1_y <= lvl2_obst2_y + lvl2_obst2_h ) &&
                ( y_pos + box1_y + box1_h >= lvl2_obst2_y ) ) ||
                
                (( x_pos + box1_x+ box1_w == lvl2_obst3_x ) &&
                ( y_pos + box1_y <= lvl2_obst3_y + lvl2_obst3_h ) &&
                ( y_pos + box1_y+ box1_h >= lvl2_obst3_y ) ) ||
                
                (( x_pos + box1_x + box1_w == lvl2_obst4_x ) &&
                ( y_pos + box1_y <= lvl2_obst4_y + lvl2_obst4_h ) &&
                ( y_pos + box1_y + box1_h >= lvl2_obst4_y ) ) ||
                
                (( x_pos + box1_x + box1_w == lvl2_obst5_x ) &&
                ( y_pos + box1_y <= lvl2_obst5_y + lvl2_obst5_h ) &&
                ( y_pos + box1_y + box1_h >= lvl2_obst5_y ) ) ||
                               
                (( x_pos + box1_x + box1_w == landing2_x ) &&
                ( y_pos + box1_y <= landing2_y + landing2_h ) &&
                ( y_pos + box1_y+ box1_h >= landing2_y )&&
                (landing_enable==1) )  ) ||
                
                ((x_pos+ box2_x == 799 - box2_w)||
                (( x_pos + box2_x + box2_w == lvl2_obst1_x ) &&
                ( y_pos + box2_y <= lvl2_obst1_y + lvl2_obst1_h ) &&
                ( y_pos + box2_y + box2_h >= lvl2_obst1_y ) ) ||
                     
                (( x_pos + box2_x+ box2_w == lvl2_obst2_x ) &&
                ( y_pos + box2_y <= lvl2_obst2_y + lvl2_obst2_h ) &&
                ( y_pos+ box2_y + box2_h >= lvl2_obst2_y ) ) ||
                   
                (( x_pos + box2_x + box2_w == lvl2_obst3_x ) &&
                ( y_pos + box2_y<= lvl2_obst3_y + lvl2_obst3_h ) &&
                ( y_pos + box2_y+ box2_h >= lvl2_obst3_y ) ) ||
                    
                (( x_pos+ box2_x  + box2_w == lvl2_obst4_x ) &&
                ( y_pos+ box2_y <= lvl2_obst4_y + lvl2_obst4_h ) &&
                ( y_pos+ box2_y + box2_h >= lvl2_obst4_y ) ) ||
                     
                (( x_pos+ box2_x + box2_w == lvl2_obst5_x ) &&
                ( y_pos+ box2_y <= lvl2_obst5_y + lvl2_obst5_h ) &&
                ( y_pos+ box2_y + box2_h >= lvl2_obst5_y ) ) ||
                                    
                (( x_pos+ box2_x + box2_w == landing2_x ) &&
                ( y_pos + box2_y <= landing2_y + landing2_h ) &&
                ( y_pos + box2_y + box2_h >= landing2_y )&&
                (landing_enable==1) )  )
                
                ) begin
                    colission_left_nxt = 0;

                    colission_right_nxt = 1;
                end
                else if(
                    
                    ((x_pos + box1_x== 0)||
                    
                    (  ( x_pos + box1_x  == lvl2_obst1_x + lvl2_obst1_w) &&
                    ( y_pos + box1_y <= lvl2_obst1_y + lvl2_obst1_h ) &&
                    ( y_pos + box1_y+ box1_h >= lvl2_obst1_y ) ) ||
                    
                    (  ( x_pos + box1_x== lvl2_obst2_x + lvl2_obst2_w) &&
                    ( y_pos+ box1_y <= lvl2_obst2_y + lvl2_obst2_h ) &&
                    ( y_pos + box1_y + box1_h >= lvl2_obst2_y ) ) ||
                    
                    (  ( x_pos+ box1_x == lvl2_obst3_x + lvl2_obst3_w) &&
                    ( y_pos+ box1_y <= lvl2_obst3_y + lvl2_obst3_h ) &&
                    ( y_pos+ box1_y + box1_h >= lvl2_obst3_y ) ) ||
                    
                    (  ( x_pos+ box1_x == lvl2_obst4_x + lvl2_obst4_w) &&
                    ( y_pos + box1_y <= lvl2_obst4_y + lvl2_obst4_h ) &&
                    ( y_pos + box1_y+ box1_h >= lvl2_obst4_y ) ) ||
                    
                    (  ( x_pos + box1_x == lvl2_obst5_x + lvl2_obst5_w) &&
                    ( y_pos + box1_y <= lvl2_obst5_y + lvl2_obst5_h ) &&
                    ( y_pos + box1_y + box1_h >= lvl2_obst5_y ) ) ||
                                                            
                    (  ( x_pos + box1_x== landing2_x + landing2_w) &&
                    ( y_pos + box1_y <= landing2_y + landing2_h ) &&
                    ( y_pos + box1_y + box1_h >= landing2_y ) &&
                    (landing_enable==1)) )||
                    
                    ((x_pos + box2_x== 0)||
                                        
                    (  ( x_pos + box2_x  == lvl2_obst1_x + lvl2_obst1_w) &&
                    ( y_pos + box2_y <= lvl2_obst1_y + lvl2_obst1_h ) &&
                    ( y_pos + box2_y+ box2_h >= lvl2_obst1_y ) ) ||
                                       
                    (  ( x_pos + box2_x== lvl2_obst2_x + lvl2_obst2_w) &&
                    ( y_pos+ box2_y <= lvl2_obst2_y + lvl2_obst2_h ) &&
                    ( y_pos + box2_y + box2_h >= lvl2_obst2_y ) ) ||
                                        
                    (  ( x_pos+ box2_x == lvl2_obst3_x + lvl2_obst3_w) &&
                    ( y_pos+ box2_y <= lvl2_obst3_y + lvl2_obst3_h ) &&
                    ( y_pos+ box2_y + box2_h >= lvl2_obst3_y ) ) ||
                                        
                    (  ( x_pos+ box2_x == lvl2_obst4_x + lvl2_obst4_w) &&
                    ( y_pos + box2_y <= lvl2_obst4_y + lvl2_obst4_h ) &&
                    ( y_pos + box2_y+ box2_h >= lvl2_obst4_y ) ) ||
                                        
                    (  ( x_pos + box2_x == lvl2_obst5_x + lvl2_obst5_w) &&
                    ( y_pos + box2_y <= lvl2_obst5_y + lvl2_obst5_h ) &&
                    ( y_pos + box2_y + box2_h >= lvl2_obst5_y ) ) ||
                                                                                
                     (  ( x_pos + box2_x== landing2_x + landing2_w) &&
                     ( y_pos + box2_y <= landing2_y + landing2_h ) &&
                     ( y_pos + box2_y + box2_h >= landing2_y ) &&
                     (landing_enable==1)) )
                    
                    )begin
                         colission_left_nxt = 1;
                         colission_right_nxt = 0;
                     end
                else 
                begin
                      colission_left_nxt = 0;
                      colission_right_nxt = 0;
                end
                
               
            end
            
            
            3'b011:
            begin 
                
               if (
               
               ((x_pos + box1_x == 799 - box1_w)||
               
                (( x_pos + box1_x + box1_w == lvl3_obst1_x ) &&
                ( y_pos + box1_y <= lvl3_obst1_y + lvl3_obst1_h ) &&
                ( y_pos + box1_y+ box1_h >= lvl3_obst1_y ) ) ||
                
                (( x_pos + box1_x+ box1_w == lvl3_obst2_x ) &&
                ( y_pos + box1_y<= lvl3_obst2_y + lvl3_obst2_h ) &&
                ( y_pos + box1_y+ box1_h >= lvl3_obst2_y ) ) ||
                
                (( x_pos+ box1_x + box1_w == lvl3_obst3_x ) &&
                ( y_pos+ box1_y <= lvl3_obst3_y + lvl3_obst3_h ) &&
                ( y_pos+ box1_y + box1_h >= lvl3_obst3_y ) ) ||
                
                (( x_pos+ box1_x + box1_w == lvl3_obst4_x ) &&
                ( y_pos+ box1_y <= lvl3_obst4_y + lvl3_obst4_h ) &&
                ( y_pos+ box1_y + box1_h >= lvl3_obst4_y ) ) ||
                
                (( x_pos+ box1_x + box1_w == lvl3_obst5_x ) &&
                ( y_pos+ box1_y <= lvl3_obst5_y + lvl3_obst5_h ) &&
                ( y_pos+ box1_y + box1_h >= lvl3_obst5_y ) ) ||
                
                (( x_pos+ box1_x + box1_w == lvl3_obst6_x ) &&
                ( y_pos+ box1_y <= lvl3_obst6_y + lvl3_obst6_h ) &&
                ( y_pos+ box1_y + box1_h >= lvl3_obst6_y ) ) ||
                
                (( x_pos+ box1_x + box1_w == lvl3_obst7_x ) &&
                ( y_pos+ box1_y <= lvl3_obst7_y + lvl3_obst7_h ) &&
                ( y_pos+ box1_y + box1_h >= lvl3_obst7_y ) )||
                                
                (( x_pos+ box1_x + box1_w == landing2_x ) &&
                ( y_pos+ box1_y <= landing2_y + landing2_h ) &&
                ( y_pos+ box1_y + box1_h >= landing2_y )&&
                (landing_enable==1) )) || 
                
                
                 ((x_pos + box2_x == 799 - box2_w)||
                
                 (( x_pos + box2_x + box2_w == lvl3_obst1_x ) &&
                 ( y_pos + box2_y <= lvl3_obst1_y + lvl3_obst1_h ) &&
                 ( y_pos + box2_y + box2_h >= lvl3_obst1_y ) ) ||
                 
                 (( x_pos + box2_x + box2_w == lvl3_obst2_x ) &&
                 ( y_pos + box2_y  <= lvl3_obst2_y + lvl3_obst2_h ) &&
                 ( y_pos + box2_y + box2_h >= lvl3_obst2_y ) ) ||
                 
                 (( x_pos+ box2_x  + box2_w == lvl3_obst3_x ) &&
                 ( y_pos + box2_y  <= lvl3_obst3_y + lvl3_obst3_h ) &&
                 ( y_pos + box2_y  + box2_h >= lvl3_obst3_y ) ) ||
                 
                 (( x_pos + box2_x  + box2_w == lvl3_obst4_x ) &&
                 ( y_pos + box2_y  <= lvl3_obst4_y + lvl3_obst4_h ) &&
                 ( y_pos + box2_y + box2_h >= lvl3_obst4_y ) ) ||
                 
                 (( x_pos+ box2_x  + box2_w == lvl3_obst5_x ) &&
                 ( y_pos + box2_y  <= lvl3_obst5_y + lvl3_obst5_h ) &&
                 ( y_pos + box2_y + box2_h >= lvl3_obst5_y ) ) ||
                 
                 (( x_pos+ box2_x  + box2_w == lvl3_obst6_x ) &&
                 ( y_pos + box2_y <= lvl3_obst6_y + lvl3_obst6_h ) &&
                 ( y_pos + box2_y  + box2_h >= lvl3_obst6_y ) ) ||
                 
                 (( x_pos + box2_x  + box2_w == lvl3_obst7_x ) &&
                 ( y_pos + box2_y  <= lvl3_obst7_y + lvl3_obst7_h ) &&
                 ( y_pos + box2_y + box2_h >= lvl3_obst7_y ) )||
                                 
                 (( x_pos + box2_x + box2_w == landing2_x ) &&
                 ( y_pos + box2_y  <= landing2_y + landing2_h ) &&
                 ( y_pos + box2_y + box2_h >= landing2_y )&&
                 (landing_enable==1) ))
                
                ) begin
                    colission_right_nxt = 1;
                    colission_left_nxt = 0;

                end
                else if(
                    
                    ((x_pos + box1_x  == 0)||
                    
                    (  ( x_pos + box1_x == lvl3_obst1_x + lvl3_obst1_w) &&
                    ( y_pos + box1_y <= lvl3_obst1_y + lvl3_obst1_h ) &&
                    ( y_pos + box1_y+ box1_h >= lvl3_obst1_y ) ) ||
                    
                    (  ( x_pos + box1_x== lvl3_obst2_x + lvl3_obst2_w) &&
                    ( y_pos + box1_y <= lvl3_obst2_y + lvl3_obst2_h ) &&
                    ( y_pos + box1_y + box1_h >= lvl3_obst2_y ) ) ||
                    
                    (  ( x_pos + box1_x == lvl3_obst3_x + lvl3_obst3_w) &&
                    ( y_pos + box1_y <= lvl3_obst3_y + lvl3_obst3_h ) &&
                    ( y_pos + box1_y+ box1_h >= lvl3_obst3_y ) ) ||
                    
                    (  ( x_pos + box1_x == lvl3_obst4_x + lvl3_obst4_w) &&
                    ( y_pos + box1_y<= lvl3_obst4_y + lvl3_obst4_h ) &&
                    ( y_pos+ box1_y + box1_h >= lvl3_obst4_y ) ) ||
                    
                    (  ( x_pos+ box1_x == lvl3_obst5_x + lvl3_obst5_w) &&
                    ( y_pos+ box1_y <= lvl3_obst5_y + lvl3_obst5_h ) &&
                    ( y_pos + box1_y+ box1_h >= lvl3_obst5_y ) ) ||
                                        
                    (  ( x_pos+ box1_x == lvl3_obst6_x + lvl3_obst6_w) &&
                    ( y_pos+ box1_y <= lvl3_obst6_y + lvl3_obst6_h ) &&
                    ( y_pos+ box1_y + box1_h >= lvl3_obst6_y ) ) ||
                                        
                    (  ( x_pos+ box1_x == lvl3_obst7_x + lvl3_obst7_w) &&
                    ( y_pos + box1_y<= lvl3_obst7_y + lvl3_obst7_h ) &&
                    ( y_pos + box1_y+ box1_h >= lvl3_obst7_y ) ) ||
                                                            
                    (  ( x_pos+ box1_x == landing2_x + landing2_w) &&
                    ( y_pos+ box1_y <= landing2_y + landing2_h ) &&
                    ( y_pos+ box1_y + box1_h >= landing2_y ) &&
                    (landing_enable==1)) ) ||
                    
                    ((x_pos + box2_x  == 0)||
                                        
                                        (  ( x_pos + box2_x == lvl3_obst1_x + lvl3_obst1_w) &&
                                        ( y_pos + box2_y <= lvl3_obst1_y + lvl3_obst1_h ) &&
                                        ( y_pos + box2_y+ box2_h >= lvl3_obst1_y ) ) ||
                                        
                                        (  ( x_pos + box2_x== lvl3_obst2_x + lvl3_obst2_w) &&
                                        ( y_pos + box2_y <= lvl3_obst2_y + lvl3_obst2_h ) &&
                                        ( y_pos + box2_y + box2_h >= lvl3_obst2_y ) ) ||
                                        
                                        (  ( x_pos + box2_x == lvl3_obst3_x + lvl3_obst3_w) &&
                                        ( y_pos + box2_y <= lvl3_obst3_y + lvl3_obst3_h ) &&
                                        ( y_pos + box2_y+ box2_h >= lvl3_obst3_y ) ) ||
                                        
                                        (  ( x_pos + box2_x == lvl3_obst4_x + lvl3_obst4_w) &&
                                        ( y_pos + box2_y<= lvl3_obst4_y + lvl3_obst4_h ) &&
                                        ( y_pos+ box2_y + box2_h >= lvl3_obst4_y ) ) ||
                                        
                                        (  ( x_pos+ box2_x == lvl3_obst5_x + lvl3_obst5_w) &&
                                        ( y_pos+ box2_y <= lvl3_obst5_y + lvl3_obst5_h ) &&
                                        ( y_pos + box2_y+ box2_h >= lvl3_obst5_y ) ) ||
                                                            
                                        (  ( x_pos+ box2_x == lvl3_obst6_x + lvl3_obst6_w) &&
                                        ( y_pos+ box2_y <= lvl3_obst6_y + lvl3_obst6_h ) &&
                                        ( y_pos+ box2_y + box2_h >= lvl3_obst6_y ) ) ||
                                                            
                                        (  ( x_pos+ box2_x == lvl3_obst7_x + lvl3_obst7_w) &&
                                        ( y_pos + box2_y<= lvl3_obst7_y + lvl3_obst7_h ) &&
                                        ( y_pos + box2_y+ box2_h >= lvl3_obst7_y ) ) ||
                                                                                
                                        (  ( x_pos+ box2_x == landing2_x + landing2_w) &&
                                        ( y_pos+ box2_y <= landing2_y + landing2_h ) &&
                                        ( y_pos+ box2_y + box2_h >= landing2_y ) &&
                                        (landing_enable==1)) )                   
                    
                    ) begin
                         colission_left_nxt = 1;
                         colission_right_nxt = 0;
                      end
                else 
                begin
                      colission_left_nxt = 0;
                      colission_right_nxt = 0;
                end
                
               
            end
            
          
            
            default: 
            begin 
                colission_left_nxt = 0;
                colission_right_nxt = 0;
            end
            
            endcase
        
        
        end
        
        // up-down
        
        always@* 
        begin 
        
            case(lvl)
            
            3'b001:
            begin 
                if(
                
               ( (y_pos + box1_y == 599 - box1_h - 20)||
                
                ((x_pos + box1_x<= lvl1_obst1_x + lvl1_obst1_w) &&
                ( x_pos + box1_x + box1_w >= lvl1_obst1_x ) &&
                ( y_pos + box1_y+ box1_h == lvl1_obst1_y ) ) ||
                
                 ((x_pos + box1_x <= lvl1_obst2_x + lvl1_obst2_w) &&
                 ( x_pos + box1_x + box1_w >= lvl1_obst2_x ) &&
                 ( y_pos + box1_y+ box1_h == lvl1_obst2_y ) ) ||
                
                 ((x_pos+ box1_x <= lvl1_obst3_x + lvl1_obst3_w) &&
                 ( x_pos + box1_x + box1_w >= lvl1_obst3_x ) &&
                 ( y_pos + box1_y + box1_h == lvl1_obst3_y ) ) ||
                 
                  ((x_pos + box1_x <= lvl1_obst4_x + lvl1_obst4_w) &&
                  ( x_pos + box1_x + box1_w >= lvl1_obst4_x ) &&
                  ( y_pos + box1_y + box1_h == lvl1_obst4_y ) ) ||
                  
                  ((x_pos + box1_x < landing2_x) &&
                  ( x_pos + box1_x+ box1_w > landing2_x  ) && 
                  ( y_pos + box1_y+ box1_h == landing2_y )&&                 
                   (landing_enable==1))||
                  
                  (( x_pos + box1_x+ box1_w > landing2_x + landing2_w  ) &&
                  (x_pos + box1_x < landing2_x + landing2_w) &&
                  ( y_pos + box1_y + box1_h == landing2_y )&&
                  (landing_enable==1) ) ) ||
                  
                  ( (y_pos + box2_y== 599 - box2_h - 20)||
                            
                   ((x_pos + box2_x <= lvl1_obst1_x + lvl1_obst1_w) &&
                   ( x_pos + box2_x + box2_w >= lvl1_obst1_x ) &&
                   ( y_pos + box2_y+ box2_h == lvl1_obst1_y ) ) ||
                            
                   ((x_pos + box2_x <= lvl1_obst2_x + lvl1_obst2_w) &&
                   ( x_pos + box2_x + box2_w >= lvl1_obst2_x ) &&
                   ( y_pos + box2_y + box2_h == lvl1_obst2_y ) ) ||
                            
                   ((x_pos + box2_x <= lvl1_obst3_x + lvl1_obst3_w) &&
                   ( x_pos + box2_x+ box2_w >= lvl1_obst3_x ) &&
                   ( y_pos + box2_y+ box2_h == lvl1_obst3_y ) ) ||
                             
                   ((x_pos + box2_x <= lvl1_obst4_x + lvl1_obst4_w) &&
                   ( x_pos + box2_x+ box2_w >= lvl1_obst4_x ) &&
                   ( y_pos + box2_y+ box2_h == lvl1_obst4_y ) ) ||
                              
                   ((x_pos + box2_x < landing2_x) &&
                   ( x_pos+ box2_x + box2_w > landing2_x  ) && 
                   ( y_pos + box2_y + box2_h == landing2_y )&&                 
                   (landing_enable==1))||
                              
                   (( x_pos+ box2_x + box2_w > landing2_x + landing2_w  ) &&
                   (x_pos+ box2_x < landing2_x + landing2_w) &&
                   ( y_pos+ box2_y + box2_h == landing2_y )&&
                   (landing_enable==1) ) ) 

                  
                ) begin
                    colission_down_nxt = 1;
                    landed_nxt = 0;
                    colission_up_nxt = 0;
                  end
                
                else if (
                    ((x_pos+ box1_x + box1_w <= landing2_x + landing2_w) &&
                    ( x_pos+ box1_x >= landing2_x ) &&
                    ( y_pos + box1_y + box1_h == landing2_y ) &&
                    (landing_enable==1) ) 
                
                ) begin
                    landed_nxt = 1;
                    colission_down_nxt = 0;
                    colission_up_nxt = 0;
                   end
                   
                else if(
                
              (  (y_pos + box1_y == 40)||
                
                ((x_pos + box1_x <= lvl1_obst1_x + lvl1_obst1_w)&&
                ( x_pos + box1_x + box1_w >= lvl1_obst1_x ) &&
                ( y_pos + box1_y == lvl1_obst1_y + lvl1_obst1_h ))||
                
                ((x_pos + box1_x <= lvl1_obst2_x + lvl1_obst2_w)&&
                ( x_pos + box1_x+ box1_w >= lvl1_obst2_x ) &&
                ( y_pos + box1_y == lvl1_obst2_y + lvl1_obst2_h )) ||
                
                ((x_pos + box1_x<= lvl1_obst3_x + lvl1_obst3_w)&&
                ( x_pos + box1_x+ box1_w >= lvl1_obst3_x ) &&
                ( y_pos + box1_y== lvl1_obst3_y + lvl1_obst3_h )) ||
                
                ((x_pos + box1_x <= lvl1_obst4_x + lvl1_obst4_w)&&
                ( x_pos + box1_x+ box1_w >= lvl1_obst4_x ) &&
                ( y_pos+ box1_y == lvl1_obst4_y + lvl1_obst4_h )) ||
                                
                ((x_pos+ box1_x <= landing2_x + landing2_w)&&
                ( x_pos+ box1_x + box1_w >= landing2_x ) &&
                ( y_pos+ box1_y == landing2_y + landing2_h )&&
                (landing_enable==1)) ) ||
                
                
                (  (y_pos + box2_y == 40)||
                             
                ((x_pos + box2_x <= lvl1_obst1_x + lvl1_obst1_w)&&
                ( x_pos + box2_x + box2_w >= lvl1_obst1_x ) &&
                ( y_pos + box2_y == lvl1_obst1_y + lvl1_obst1_h ))||
                             
                ((x_pos + box2_x <= lvl1_obst2_x + lvl1_obst2_w)&&
                ( x_pos + box2_x+ box2_w >= lvl1_obst2_x ) &&
                ( y_pos + box2_y == lvl1_obst2_y + lvl1_obst2_h )) ||
                             
                ((x_pos + box2_x<= lvl1_obst3_x + lvl1_obst3_w)&&
                ( x_pos + box2_x+ box2_w >= lvl1_obst3_x ) &&
                ( y_pos + box2_y== lvl1_obst3_y + lvl1_obst3_h )) ||
                             
                ((x_pos + box2_x <= lvl1_obst4_x + lvl1_obst4_w)&&
                ( x_pos + box2_x+ box2_w >= lvl1_obst4_x ) &&
                ( y_pos+ box2_y == lvl1_obst4_y + lvl1_obst4_h )) ||
                                             
                ((x_pos+ box2_x <= landing2_x + landing2_w)&&
                ( x_pos+ box2_x + box2_w >= landing2_x ) &&
                ( y_pos+ box2_y == landing2_y + landing2_h )&&
                (landing_enable==1)) )
                
                 ) begin
                    colission_up_nxt = 1;
                    colission_down_nxt = 0;
                    landed_nxt = 0;
                 end

                
                else begin 
                    colission_down_nxt = 0;
                    colission_up_nxt = 0;
                    landed_nxt = 0;
                end
            
            end
            
            
            3'b010:
            begin 
                if(
                
                ((y_pos + box1_y == 599 - box1_h - 20)||
                
                ((x_pos + box1_x <= lvl2_obst1_x + lvl2_obst1_w) &&
                ( x_pos + box1_x + box1_w >= lvl2_obst1_x ) &&
                ( y_pos + box1_y + box1_h == lvl2_obst1_y ) ) ||
                
                 ((x_pos + box1_x <= lvl2_obst2_x + lvl2_obst2_w) &&
                 ( x_pos + box1_x + box1_w >= lvl2_obst2_x ) &&
                 ( y_pos + box1_y+ box1_h == lvl2_obst2_y ) ) ||
                
                 ((x_pos  + box1_x <= lvl2_obst3_x + lvl2_obst3_w) &&
                 ( x_pos  + box1_x+ box1_w >= lvl2_obst3_x ) &&
                 ( y_pos  + box1_y+ box1_h == lvl2_obst3_y ) ) ||
                 
                  ((x_pos  + box1_x <= lvl2_obst4_x + lvl2_obst4_w) &&
                  ( x_pos  + box1_x+ box1_w >= lvl2_obst4_x ) &&
                  ( y_pos  + box1_y+ box1_h == lvl2_obst4_y ) )  ||
                  
                  ((x_pos + box1_x<= lvl2_obst5_x + lvl2_obst5_w) &&
                  ( x_pos + box1_x+ box1_w >= lvl2_obst5_x ) &&
                  ( y_pos + box1_y+ box1_h == lvl2_obst5_y ) ) ||
                                    
                  ((x_pos + box1_x< landing2_x) &&
                  ( x_pos + box1_x+ box1_w > landing2_x  ) && 
                  ( y_pos + box1_y+ box1_h == landing2_y )&&                 
                   (landing_enable==1))||
                  
                   ((x_pos + box1_x < landing2_x) &&
                   ( x_pos + box1_x+ box1_w > landing2_x  ) && 
                   ( y_pos + box1_y+ box1_h == landing2_y )&&                 
                    (landing_enable==1))||
                   
                   (( x_pos + box1_x+ box1_w > landing2_x + landing2_w  ) &&
                   (x_pos + box1_x< landing2_x + landing2_w) &&
                   ( y_pos + box1_y+ box1_h == landing2_y )&&
                   (landing_enable==1) ) ) ||
                   
                    ((y_pos + box2_y == 599 - box2_h - 20)||
                                  
                                  ((x_pos + box2_x <= lvl2_obst1_x + lvl2_obst1_w) &&
                                  ( x_pos + box2_x + box2_w >= lvl2_obst1_x ) &&
                                  ( y_pos + box2_y + box2_h == lvl2_obst1_y ) ) ||
                                  
                                   ((x_pos + box2_x <= lvl2_obst2_x + lvl2_obst2_w) &&
                                   ( x_pos + box2_x + box2_w >= lvl2_obst2_x ) &&
                                   ( y_pos + box2_y+ box2_h == lvl2_obst2_y ) ) ||
                                  
                                   ((x_pos  + box2_x <= lvl2_obst3_x + lvl2_obst3_w) &&
                                   ( x_pos  + box2_x+ box2_w >= lvl2_obst3_x ) &&
                                   ( y_pos  + box2_y+ box2_h == lvl2_obst3_y ) ) ||
                                   
                                    ((x_pos  + box2_x <= lvl2_obst4_x + lvl2_obst4_w) &&
                                    ( x_pos  + box2_x+ box2_w >= lvl2_obst4_x ) &&
                                    ( y_pos  + box2_y+ box2_h == lvl2_obst4_y ) )  ||
                                    
                                    ((x_pos + box2_x<= lvl2_obst5_x + lvl2_obst5_w) &&
                                    ( x_pos + box2_x+ box2_w >= lvl2_obst5_x ) &&
                                    ( y_pos + box2_y+ box2_h == lvl2_obst5_y ) ) ||
                                                      
                                    ((x_pos + box2_x< landing2_x) &&
                                    ( x_pos + box2_x+ box2_w > landing2_x  ) && 
                                    ( y_pos + box2_y+ box2_h == landing2_y )&&                 
                                     (landing_enable==1))||
                                    
                                     ((x_pos + box2_x < landing2_x) &&
                                     ( x_pos + box2_x+ box2_w > landing2_x  ) && 
                                     ( y_pos + box2_y+ box2_h == landing2_y )&&                 
                                      (landing_enable==1))||
                                     
                                     (( x_pos + box2_x+ box2_w > landing2_x + landing2_w  ) &&
                                     (x_pos + box2_x< landing2_x + landing2_w) &&
                                     ( y_pos + box2_y+ box2_h == landing2_y )&&
                                     (landing_enable==1) ) )
                                    
                  
                )begin
                                       colission_up_nxt = 0;
                                       colission_down_nxt = 1;
                                       landed_nxt = 0;
                                    end 
                

                
                else if (
                    ((x_pos + box1_x+ box1_w <= landing2_x + landing2_w) &&
                    ( x_pos + box1_x>= landing2_x ) &&
                    ( y_pos + box1_y+ box1_h == landing2_y ) &&
                    (landing_enable==1) ) 
                
                ) begin
                         colission_up_nxt = 0;
                         colission_down_nxt = 0;
                         landed_nxt = 1;
               end
                

                
                else if(
                
                ( (y_pos+ box1_y == 40)||
                
                ((x_pos+ box1_x <= lvl2_obst1_x + lvl2_obst1_w)&&
                ( x_pos+ box1_x + box1_w >= lvl2_obst1_x ) &&
                ( y_pos+ box1_y == lvl2_obst1_y + lvl2_obst1_h ))||
                
                ((x_pos+ box1_x <= lvl2_obst2_x + lvl2_obst2_w)&&
                ( x_pos+ box1_x + box1_w >= lvl2_obst2_x ) &&
                ( y_pos+ box1_y == lvl2_obst2_y + lvl2_obst2_h )) ||
                
                ((x_pos+ box1_x <= lvl2_obst3_x + lvl2_obst3_w)&&
                ( x_pos+ box1_x + box1_w >= lvl2_obst3_x ) &&
                ( y_pos+ box1_y == lvl2_obst3_y + lvl2_obst3_h )) ||
                
                ((x_pos+ box1_x <= lvl2_obst4_x + lvl2_obst4_w)&&
                ( x_pos+ box1_x + box1_w >= lvl2_obst4_x ) &&
                ( y_pos+ box1_y == lvl2_obst4_y + lvl2_obst4_h )) ||
                
                ((x_pos+ box1_x <= lvl2_obst5_x + lvl2_obst5_w)&&
                ( x_pos+ box1_x + box1_w >= lvl2_obst5_x ) &&
                ( y_pos+ box1_y == lvl2_obst5_y + lvl2_obst5_h )) ||
                                                
                ((x_pos+ box1_x <= landing2_x + landing2_w)&&
                ( x_pos+ box1_x + box1_w >= landing2_x ) &&
                ( y_pos+ box1_y == landing2_y + landing2_h )&&
                (landing_enable==1)) ) ||
                
                 ( (y_pos+ box2_y == 40)||
                               
                               ((x_pos+ box2_x <= lvl2_obst1_x + lvl2_obst1_w)&&
                               ( x_pos+ box2_x + box2_w >= lvl2_obst1_x ) &&
                               ( y_pos+ box2_y == lvl2_obst1_y + lvl2_obst1_h ))||
                               
                               ((x_pos+ box2_x <= lvl2_obst2_x + lvl2_obst2_w)&&
                               ( x_pos+ box2_x + box2_w >= lvl2_obst2_x ) &&
                               ( y_pos+ box2_y == lvl2_obst2_y + lvl2_obst2_h )) ||
                               
                               ((x_pos+ box2_x <= lvl2_obst3_x + lvl2_obst3_w)&&
                               ( x_pos+ box2_x + box2_w >= lvl2_obst3_x ) &&
                               ( y_pos+ box2_y == lvl2_obst3_y + lvl2_obst3_h )) ||
                               
                               ((x_pos+ box2_x <= lvl2_obst4_x + lvl2_obst4_w)&&
                               ( x_pos+ box2_x + box2_w >= lvl2_obst4_x ) &&
                               ( y_pos+ box2_y == lvl2_obst4_y + lvl2_obst4_h )) ||
                               
                               ((x_pos+ box2_x <= lvl2_obst5_x + lvl2_obst5_w)&&
                               ( x_pos+ box2_x + box2_w >= lvl2_obst5_x ) &&
                               ( y_pos+ box2_y == lvl2_obst5_y + lvl2_obst5_h )) ||
                                                               
                               ((x_pos+ box2_x <= landing2_x + landing2_w)&&
                               ( x_pos+ box2_x + box2_w >= landing2_x ) &&
                               ( y_pos+ box2_y == landing2_y + landing2_h )&&
                               (landing_enable==1)) )
                
                 ) begin
                      colission_up_nxt = 1;
                      colission_down_nxt = 0;
                      landed_nxt = 0;
                end
               
                
                else begin 
                    landed_nxt = 0;
                    colission_down_nxt = 0;
                    colission_up_nxt = 0;
                end
            
            end
            
            3'b011:
            begin 
                if(
                
                ((y_pos+ box1_y == 599 - box1_h - 20)||
                
                ((x_pos + box1_x <= lvl3_obst1_x + lvl3_obst1_w) &&
                ( x_pos + box1_x+ box1_w >= lvl3_obst1_x ) &&
                ( y_pos + box1_y+ box1_h == lvl3_obst1_y ) ) ||
                
                 ((x_pos + box1_x<= lvl3_obst2_x + lvl3_obst2_w) &&
                 ( x_pos + box1_x+ box1_w >= lvl3_obst2_x ) &&
                 ( y_pos + box1_y+ box1_h == lvl3_obst2_y ) ) ||
                
                 ((x_pos + box1_x <= lvl3_obst3_x + lvl3_obst3_w) &&
                 ( x_pos + box1_x+ box1_w >= lvl3_obst3_x ) &&
                 ( y_pos + box1_y+ box1_h == lvl3_obst3_y ) ) ||
                 
                 ((x_pos + box1_x<= lvl3_obst4_x + lvl3_obst4_w) &&
                 ( x_pos + box1_x+ box1_w >= lvl3_obst4_x ) &&
                 ( y_pos + box1_y+ box1_h == lvl3_obst4_y ) ) ||
                                  
                 ((x_pos + box1_x<= lvl3_obst5_x + lvl3_obst5_w) &&
                 ( x_pos + box1_x+ box1_w >= lvl3_obst5_x ) &&
                 ( y_pos + box1_y+ box1_h == lvl3_obst5_y ) ) ||
                                 
                 ((x_pos + box1_x<= lvl3_obst6_x + lvl3_obst6_w) &&
                 ( x_pos + box1_x+ box1_w >= lvl3_obst6_x ) &&
                 ( y_pos + box1_y+ box1_h == lvl3_obst6_y ) ) ||
                                   
                 ((x_pos + box1_x<= lvl3_obst7_x + lvl3_obst7_w) &&
                 ( x_pos + box1_x+ box1_w >= lvl3_obst7_x ) &&
                 ( y_pos + box1_y+ box1_h == lvl3_obst7_y ) ) ||
                                   
                 ((x_pos + box1_x  < landing2_x) &&
                 ( x_pos + box1_x+ box1_w > landing2_x  ) && 
                 ( y_pos + box1_y+ box1_h == landing2_y )&&                 
                  (landing_enable==1))||
                 
                 (( x_pos+ box1_x + box1_w > landing2_x + landing2_w  ) &&
                 (x_pos+ box1_x < landing2_x + landing2_w) &&
                 ( y_pos+ box1_y + box1_h == landing2_y )&&
                 (landing_enable==1) ) ) ||
                 
                ( ((y_pos+ box2_y == 599 - box2_h - 20)||
                                 
                 ((x_pos + box2_x <= lvl3_obst1_x + lvl3_obst1_w) &&
                 ( x_pos + box2_x+ box2_w >= lvl3_obst1_x ) &&
                 ( y_pos + box2_y+ box2_h == lvl3_obst1_y ) ) ||
                                 
                 ((x_pos + box2_x<= lvl3_obst2_x + lvl3_obst2_w) &&
                 ( x_pos + box2_x+ box2_w >= lvl3_obst2_x ) &&
                 ( y_pos + box2_y+ box2_h == lvl3_obst2_y ) ) ||
                                 
                 ((x_pos + box2_x <= lvl3_obst3_x + lvl3_obst3_w) &&
                 ( x_pos + box2_x+ box2_w >= lvl3_obst3_x ) &&
                 ( y_pos + box2_y+ box2_h == lvl3_obst3_y ) ) ||
                                  
                 ((x_pos + box2_x<= lvl3_obst4_x + lvl3_obst4_w) &&
                 ( x_pos + box2_x+ box2_w >= lvl3_obst4_x ) &&
                 ( y_pos + box2_y+ box2_h == lvl3_obst4_y ) ) ||
                                                   
                 ((x_pos + box2_x<= lvl3_obst5_x + lvl3_obst5_w) &&
                 ( x_pos + box2_x+ box2_w >= lvl3_obst5_x ) &&
                 ( y_pos + box2_y+ box2_h == lvl3_obst5_y ) ) ||
                                                  
                 ((x_pos + box2_x<= lvl3_obst6_x + lvl3_obst6_w) &&
                 ( x_pos + box2_x+ box2_w >= lvl3_obst6_x ) &&
                 ( y_pos + box2_y+ box2_h == lvl3_obst6_y ) ) ||
                                                    
                 ((x_pos + box2_x<= lvl3_obst7_x + lvl3_obst7_w) &&
                 ( x_pos + box2_x+ box2_w >= lvl3_obst7_x ) &&
                 ( y_pos + box2_y+ box2_h == lvl3_obst7_y ) ) ||
                                                    
                 (x_pos + box2_x < landing2_x) &&
                 ( x_pos + box2_x+ box2_w > landing2_x  ) && 
                 ( y_pos + box2_y+ box2_h == landing2_y )&&                 
                 (landing_enable==1))||
                                  
                 (( x_pos+ box2_x + box2_w > landing2_x + landing2_w  ) &&
                 (x_pos+ box2_x < landing2_x + landing2_w) &&
                 ( y_pos+ box2_y + box2_h == landing2_y )&&
                 (landing_enable==1) ) )
                                   
                  
                )begin
                       colission_up_nxt = 0;
                       colission_down_nxt = 1;
                       landed_nxt = 0;
                end 
                
                
                
                else if (
                    ((x_pos + box1_x + box1_w <= landing2_x + landing2_w) &&
                    ( x_pos + box1_x>= landing2_x ) &&
                    ( y_pos + box1_y+ box1_h == landing2_y ) &&
                    (landing_enable==1) ) 
                
                )begin
                     colission_up_nxt = 0;
                     colission_down_nxt = 0;                
                     landed_nxt = 1;
                 end
                

                
                else if(
                
                ((y_pos + box1_y == 40)||
                
                ((x_pos + box1_x  <= lvl3_obst1_x + lvl3_obst1_w)&&
                ( x_pos + box1_x+ box1_w >= lvl3_obst1_x ) &&
                ( y_pos + box1_y== lvl3_obst1_y + lvl3_obst1_h ))||
                
                ((x_pos + box1_x  <= lvl3_obst2_x + lvl3_obst2_w)&&
                ( x_pos + box1_x + box1_w >= lvl3_obst2_x ) &&
                ( y_pos + box1_y== lvl3_obst2_y + lvl3_obst2_h )) ||
                
                ((x_pos + box1_x<= lvl3_obst3_x + lvl3_obst3_w)&&
                ( x_pos + box1_x+ box1_w >= lvl3_obst3_x ) &&
                ( y_pos + box1_y== lvl3_obst3_y + lvl3_obst3_h )) ||
                
                ((x_pos + box1_x<= lvl3_obst4_x + lvl3_obst4_w)&&
                ( x_pos + box1_x + box1_w >= lvl3_obst4_x ) &&
                ( y_pos + box1_y == lvl3_obst4_y + lvl3_obst4_h )) ||
                                
                ((x_pos + box1_x<= lvl3_obst5_x + lvl3_obst5_w)&&
                ( x_pos + box1_x+ box1_w >= lvl3_obst5_x ) &&
                ( y_pos + box1_y== lvl3_obst5_y + lvl3_obst5_h )) ||
                               
                ((x_pos + box1_x<= lvl3_obst6_x + lvl3_obst6_w)&&
                ( x_pos + box1_x+ box1_w >= lvl3_obst6_x ) &&
                ( y_pos + box1_y== lvl3_obst6_y + lvl3_obst6_h )) ||
                                
                ((x_pos + box1_x<= lvl3_obst7_x + lvl3_obst7_w)&&
                ( x_pos + box1_x+ box1_w >= lvl3_obst7_x ) &&
                ( y_pos + box1_y== lvl3_obst7_y + lvl3_obst7_h )) ||
                                                
                ((x_pos + box1_x <= landing2_x + landing2_w)&&
                ( x_pos + box1_x+ box1_w >= landing2_x ) &&
                ( y_pos + box1_y == landing2_y + landing2_h )&&
                (landing_enable==1)) ) ||
                 
                ((y_pos + box2_y == 40)||
                               
                ((x_pos + box2_x  <= lvl3_obst1_x + lvl3_obst1_w)&&
                ( x_pos + box2_x+ box2_w >= lvl3_obst1_x ) &&
                ( y_pos + box2_y== lvl3_obst1_y + lvl3_obst1_h ))||
                               
                ((x_pos + box2_x  <= lvl3_obst2_x + lvl3_obst2_w)&&
                ( x_pos + box2_x + box2_w >= lvl3_obst2_x ) &&
                ( y_pos + box2_y== lvl3_obst2_y + lvl3_obst2_h )) ||
                               
                ((x_pos + box2_x<= lvl3_obst3_x + lvl3_obst3_w)&&
                ( x_pos + box2_x+ box2_w >= lvl3_obst3_x ) &&
                ( y_pos + box2_y== lvl3_obst3_y + lvl3_obst3_h )) ||
                               
                ((x_pos + box2_x<= lvl3_obst4_x + lvl3_obst4_w)&&
                ( x_pos + box2_x + box2_w >= lvl3_obst4_x ) &&
                ( y_pos + box2_y == lvl3_obst4_y + lvl3_obst4_h )) ||
                                               
                ((x_pos + box2_x<= lvl3_obst5_x + lvl3_obst5_w)&&
                ( x_pos + box2_x+ box2_w >= lvl3_obst5_x ) &&
                ( y_pos + box2_y== lvl3_obst5_y + lvl3_obst5_h )) ||
                                              
                ((x_pos + box2_x<= lvl3_obst6_x + lvl3_obst6_w)&&
                ( x_pos + box2_x+ box2_w >= lvl3_obst6_x ) &&
                ( y_pos + box2_y== lvl3_obst6_y + lvl3_obst6_h )) ||
                                       
                ((x_pos + box2_x<= lvl3_obst7_x + lvl3_obst7_w)&&
                ( x_pos + box2_x+ box2_w >= lvl3_obst7_x ) &&
                ( y_pos + box2_y== lvl3_obst7_y + lvl3_obst7_h )) ||
                                                               
                ((x_pos + box2_x <= landing2_x + landing2_w)&&
                ( x_pos + box2_x+ box2_w >= landing2_x ) &&
                ( y_pos + box2_y == landing2_y + landing2_h )&&
                (landing_enable==1)) )
                
                 ) begin
                    colission_up_nxt = 1;
                    colission_down_nxt = 0;
                    landed_nxt = 0;
                 end
                 
                else begin 
                    colission_down_nxt = 0;
                    colission_up_nxt = 0;
                    landed_nxt = 0;
                end
            
            end
            
            default: 
            begin 
                colission_up_nxt = 0;
                colission_down_nxt = 0;
                landed_nxt = 0;
            end
            
            
            endcase
        end
        
        
        always@(posedge clk or posedge rst)
        begin 
            if(rst==1)
            begin
                colission_up <= 0;
                colission_down <= 0;
                colission_left <= 0;
                colission_right <= 0;
                landed <= 0;
            end
            else
            begin
                colission_up <= colission_up_nxt;
                colission_down <= colission_down_nxt;
                colission_left <= colission_left_nxt;
                colission_right <= colission_right_nxt;
                landed <= landed_nxt;
            end         
        end
    
    
endmodule

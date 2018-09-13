`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2018 12:43:17
// Design Name: 
// Module Name: game_control
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


module game_control(
    input clk,
    input rst,
    input colission,
    input [4:0] points,
    input capture,
    input landed,
    
    output reg [12:0] health,
    output reg [12:0] score,
    output reg next_lvl,
    output reg  fail,
    output reg landing_en,
    output reg [12:0] lvl
    
    );
    
        reg [12:0] health_nxt=100;
        reg [12:0] score_nxt=0;
        reg [12:0]lvl_nxt;
        reg finish_nxt=0;
        reg fail_nxt=0;
        reg landing_en_nxt=0;
        reg lvl_next_nxt = 0;
    
    always @(posedge colission or posedge rst)
    begin  
        if (rst == 1) health_nxt =100;    
        else health_nxt = health -1 ;
        
    end
    
    always @(posedge capture or posedge rst) begin        
         if( rst == 1) score_nxt = 0;
         else score_nxt = score + 1;      
    end
    
    always @(posedge landed or posedge rst) begin
        if( rst == 1 ) lvl_nxt = 1;
        else lvl_nxt = lvl + 1;
    
    end

    
    always @*
    begin 
        
        if(  points == 5'b11111) landing_en_nxt = 1;
        else landing_en_nxt = 0;
        
        if( health == 0 ) fail_nxt = 1;
        else fail_nxt = 0;
        
        if ( landed == 1 ) lvl_next_nxt = 1;
        else lvl_next_nxt = 0;
    
    end 
    
    
    always @(posedge clk or posedge rst)
    begin 
        if(rst == 1)
        begin
            health <= 100;
            score <= 0;
            next_lvl <= 0;
            fail <= 0;
            landing_en <= 0;
            lvl <= 1;
        end
        
        else 
        begin
        
            health <= health_nxt;
            score <= score_nxt;
            next_lvl <= lvl_next_nxt;
            fail <= fail_nxt;
            landing_en <= landing_en_nxt;
            lvl <= lvl_nxt;
        end
    end 
    
endmodule

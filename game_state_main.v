`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2018 16:21:17
// Design Name: 
// Module Name: game_state_main
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


module game_state_main(
    
    input clk,
    input wire ok,
    input wire rst,
    
    input wire next_lvl,
    input wire fail,  
    input wire [12:0] lvl,
          
    output reg game_reset,
    output reg game_ctl_reset,
    output reg text_reset,
    output reg [2:0]game_state_out

    
    );
    
    localparam 
        START = 0,
        GAME = 4,
        NEXT_LEVEL = 1,
        FAIL = 2,
        FINISH = 3;
    
    reg game_ctl_reset_nxt;
    reg game_reset_nxt;
    reg text_reset_nxt;  
    reg [2:0] game_state_out_nxt;
    reg [2:0] lvl_nxt;
    
    
    always @*
    begin 
        
        case(game_state_out)
        
        START: 
        begin
            
            if( ok == 1 ) game_state_out_nxt = GAME; 
            else game_state_out_nxt = START;
            
            game_ctl_reset_nxt = 1;
            game_reset_nxt = 1;
            text_reset_nxt = 0;
           
        
        end 
        
        GAME: 
        begin 
        
            game_ctl_reset_nxt = 0;
            game_reset_nxt = 0;
            text_reset_nxt = 1;
        
            if( fail == 1 ) game_state_out_nxt = FAIL;
            else if (next_lvl == 1) game_state_out_nxt = NEXT_LEVEL;
            else game_state_out_nxt = GAME;  
            
        end
        
        NEXT_LEVEL: 
        begin
            
            if( ok == 1) game_state_out_nxt = GAME; 
            else if( lvl > 3) game_state_out_nxt = FINISH;
            else game_state_out_nxt = NEXT_LEVEL; 
            
            game_ctl_reset_nxt = 0;
            game_reset_nxt = 1;
            text_reset_nxt = 0;
     
        
        end 
        
        FAIL: 
        begin
            
            if( ok == 1) game_state_out_nxt = START; 
            else game_state_out_nxt = FAIL;
            
            game_ctl_reset_nxt = 0;
            game_reset_nxt = 1;
            text_reset_nxt = 0;
            
        
        end 
        
         FINISH: 
         begin
             
             if( ok == 1) game_state_out_nxt = START; 
             else game_state_out_nxt = FINISH;
             
             game_ctl_reset_nxt = 0;
             game_reset_nxt = 1;
             text_reset_nxt = 0;
             
         
         end 
        
        default:
        begin 
            game_state_out_nxt = game_state_out;
            game_ctl_reset_nxt = 0;
            game_reset_nxt = 0;
            text_reset_nxt = 0;
        
        end
        
        endcase 
    
    
    end
    
    
    always @(posedge clk or posedge rst)
    begin
        if(rst == 1)
        begin 
            
            game_reset <= 1;
            game_ctl_reset <= 1;
            text_reset <= 1;
            game_state_out <= START;
 
        end 
        else
        begin 
        
            game_reset <= game_reset_nxt;
            game_ctl_reset <= game_ctl_reset_nxt;
            text_reset <= text_reset_nxt;
            game_state_out <= game_state_out_nxt;
        
        end
    
    
    end
    
endmodule

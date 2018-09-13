`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2018 16:21:17
// Design Name: 
// Module Name: disp_mux
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


module disp_mux(
    input clk,
    input rst,
    
    input [10:0] hcount_in_txt,
    input hsync_in_txt,
    input hblnk_in_txt,
    input [10:0] vcount_in_txt,
    input vsync_in_txt,
    input vblnk_in_txt,
    input [11:0] rgb_in_txt,
    
    input [10:0] hcount_in_game,
    input hsync_in_game,
    input hblnk_in_game,
    input [10:0] vcount_in_game,
    input vsync_in_game,
    input vblnk_in_game,
    input [11:0] rgb_in_game,
    
    input [2:0] game_state,
    
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out
    
    
    );
    
    reg [10:0] hcount_out_nxt;
    reg hsync_out_nxt;
    reg hblnk_out_nxt;
    reg [10:0] vcount_out_nxt;
    reg vsync_out_nxt;
    reg vblnk_out_nxt;
    reg [11:0] rgb_out_nxt;
    
    always @* 
    begin
        if(game_state == 3'b100) 
        begin 
            
            hcount_out_nxt = hcount_in_game;
            hsync_out_nxt = hsync_in_game;
            hblnk_out_nxt = hblnk_in_game;
            vcount_out_nxt = vcount_in_game;
            vsync_out_nxt = vsync_in_game;
            vblnk_out_nxt = vblnk_in_game;
            rgb_out_nxt = rgb_in_game;
            
        end
        else
        begin
        
            hcount_out_nxt = hcount_in_txt;
            hsync_out_nxt = hsync_in_txt;
            hblnk_out_nxt = hblnk_in_txt;
            vcount_out_nxt = vcount_in_txt;
            vsync_out_nxt = vsync_in_txt;
            vblnk_out_nxt = vblnk_in_txt;
            rgb_out_nxt = rgb_in_txt;
        
        end
    
    end
    
    always @(posedge clk or posedge rst)
    begin
    
        if(rst == 1)
        begin
            
            hcount_out <= 0;
            hsync_out <= 0;
            hblnk_out <= 0;
            vcount_out <= 0;
            vsync_out <= 0;
            vblnk_out <= 0;
            rgb_out <= 0;
        
        end
        
        else
        begin
        
            hcount_out <= hcount_out_nxt;
            hsync_out <= hsync_out_nxt;
            hblnk_out <= hblnk_out_nxt;
            vcount_out <= vcount_out_nxt;
            vsync_out <= vsync_out_nxt;
            vblnk_out <= vblnk_out_nxt;
            rgb_out <= rgb_out_nxt;
        
        end
    
    end
    
endmodule

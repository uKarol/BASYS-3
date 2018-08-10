`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.08.2018 21:21:21
// Design Name: 
// Module Name: obstacles
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


module obstacles(
        input [10:0] hcount_in,
        input [10:0] vcount_in,
        input vsync_in,
        input vblnk_in,
        input hsync_in,
        input hblnk_in,

        input clk,
        input [2:0]lvl,
        
        output reg [10:0] vcount_out,
        output reg [10:0] hcount_out,
        output reg hsync_out,
        output reg hblnk_out,
        output reg vsync_out,
        output reg vblnk_out,
        output reg [11:0]rgb_out
    );
    
    
    always @*  
    
    begin  
        case( lvl )
        
        3'b001:
        begin
            draw_rect rect_1(
            
            
            ); 
        
        end 
            
        
        3'b010:
        begin
        
        
        end
        
        default:
        begin
        
        
        end
        
        endcase  
    end
    
    
endmodule

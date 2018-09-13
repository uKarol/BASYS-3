`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2018 15:43:42
// Design Name: 
// Module Name: char_rom_16x16
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


module text_rom_score(
    input [7:0] char_xy,
    output reg[6:0] char_code
    );
   
    always @*
        case(char_xy) 
        8'h00: char_code = "S"; 
        8'h01: char_code = "C";  
        8'h02: char_code = "O";  
        8'h03: char_code = "R";  
        8'h04: char_code = "E";  
        default: char_code = " ";  




    endcase


endmodule


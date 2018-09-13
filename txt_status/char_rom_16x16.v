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


module char_rom_16x16(
    input [7:0] char_xy,
    output reg[6:0] char_code
    );
   
    always @*
        case(char_xy) 
        8'h00: char_code = " "; 
        8'h01: char_code = "U";  
        8'h02: char_code = "F";  
        8'h03: char_code = "O";  
        8'h04: char_code = " ";  
        8'h05: char_code = " ";  
        8'h06: char_code = " ";    
        8'h07: char_code = "M"; 
        8'h08: char_code = "T";
        8'h09: char_code = "M"; 
        8'h0a: char_code = " "; 
        default: char_code = " ";
    endcase


endmodule

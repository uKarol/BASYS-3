module char_rom_16x16_num(
    input [7:0] char_xy,
    input [3:0] number,
    output reg[6:0] char_code
    );
   
    always @*
        case(char_xy) 
        8'h00: begin 
                case(number)
                    4'h0: char_code = "0";
                    4'h1: char_code = "1";
                    4'h2: char_code = "2";
                    4'h3: char_code = "3";
                    4'h4: char_code = "4";
                    4'h5: char_code = "5";               
                    4'h6: char_code = "6";
                    4'h7: char_code = "7";
                    4'h8: char_code = "8";
                    4'h9: char_code = "9";
                    default: char_code = "0";
            endcase
        
        
        end
        default: char_code = "0";
    endcase


endmodule



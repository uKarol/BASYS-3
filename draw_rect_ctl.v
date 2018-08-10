`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2018 20:41:59
// Design Name: 
// Module Name: draw_rect_ctl
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



module draw_rect_ctl(

    input wire mouse_left,
    input wire clk,
    
    input wire rst,
    
    input wire landed,
    
    input wire colission_up, 
    input wire colission_down, 
    input wire colission_left, 
    input wire colission_right, 
    
    input wire up,
    input wire left,
    input wire right,
    
    output wire [5:0] leds,
    output reg [11:0] x_pos,
    output reg [11:0] y_pos,
    
    output reg started
    );

// rewriten 

    localparam 
    
    // position 
        YPOS_MIN= 0,
        XPOS_MIN= 0,
        YPOS_MAX= 599,
        XPOS_MAX= 799,
    // STATE CODES    
        LEFT = 1,
        RIGHT = 2,
        IDLE = 0,
        
    // ROCKET DIMENSIONS
        ROCKET_HIGH = 64,
        ROCKET_WIDTH = 48,
   // SPEED PARAMETERS
        DELAY_MAX = 1000000,
        DELAY_MIN = 0,
        H_SPEED_DIVIDER = 100000,
        X_SPEED_DIVIDER = 100000,
        DELAY_FACTOR = 2000,
        START_DELAY = 1,
        MAX_ACC = 40000,
    
    // X_STATES
        X_IDLE = 0,
        LEFT_ACC = 1,
        LEFT_DELAY = 2,
        RIGHT_ACC = 3,
        RIGHT_DELAY = 4,
        
   // Y_STATES 
        Y_IDLE = 0,
        UP_ACC = 1,
        UP_DELAY = 2,
        DOWN_ACC = 3,
        DOWN_DELAY = 4;
            
        
        
    reg [11:0] x_pos_nxt; //pozycja x
    reg [11:0] y_pos_nxt; // pozycja y

    reg [32:0] y_speed_ctr;
    reg [32:0] x_speed_ctr;
    reg [32:0] y_speed_ctr_nxt;
    reg [32:0] x_speed_ctr_nxt;
    reg [32:0] delay=DELAY_MAX; // opoznienie 
    reg [32:0] delay_nxt;
    
    reg [32:0] y_delay = DELAY_MAX;
    reg [32:0] y_delay_nxt;
     
    reg started_nxt;

    reg [2:0]y_state= Y_IDLE;
    reg [2:0]y_state_nxt;

always @* // gravity
    begin    
    if( y_speed_ctr == H_SPEED_DIVIDER + y_delay ) begin
        
        y_speed_ctr_nxt = 0;
        
        case(y_state)
        
        Y_IDLE:
        begin 
            
            
            if(up==1)
            begin
                y_state_nxt = UP_ACC;
                started_nxt = 1;
             end
            else 
            begin 
                y_state_nxt = y_state;   
                started_nxt = 0;
            end
            y_pos_nxt = y_pos;
            y_delay_nxt = DELAY_MAX;
                  
        end
        
        UP_ACC:
        begin
            
            started_nxt = started;
            
            if(colission_up == 1) y_state_nxt = DOWN_ACC;
            else if(up!=1) y_state_nxt = UP_DELAY;
            else y_state_nxt = y_state;
            
            if(y_pos > YPOS_MIN) y_pos_nxt = y_pos-1;
            else y_pos_nxt = y_pos;  
            
            if(y_delay > DELAY_MIN) y_delay_nxt = y_delay-DELAY_FACTOR;
            else y_delay_nxt = y_delay;
        
        end
        
        UP_DELAY:
        begin
        
            started_nxt = started;
            
            if(colission_up == 1) y_state_nxt = DOWN_ACC;
            else if( up==1) y_state_nxt = UP_ACC;
            else if(y_delay >= DELAY_MAX) y_state_nxt = DOWN_ACC;
            else y_state_nxt = y_state;
        
            if(y_pos > YPOS_MIN) y_pos_nxt = y_pos-1;
            else y_pos_nxt = y_pos;  
    
            y_delay_nxt = y_delay+2*DELAY_FACTOR;
        
        end
        
        DOWN_ACC:
        begin 
            
            started_nxt = started;
            
            if(landed == 1) y_state_nxt = Y_IDLE;
            else if(colission_down == 1) y_state_nxt = UP_ACC;
            else if(up==1) y_state_nxt = DOWN_DELAY;
            else if(y_pos <= (YPOS_MAX - ROCKET_HIGH) ) y_state_nxt = DOWN_ACC;
            else y_state_nxt = Y_IDLE;
        
            if(y_pos <= (YPOS_MAX - ROCKET_HIGH) ) y_pos_nxt = y_pos+1;
            else y_pos_nxt = y_pos;  
        
            if(y_delay > DELAY_MIN) y_delay_nxt = y_delay-DELAY_FACTOR;
            else y_delay_nxt = y_delay;    
        
        end
        
        DOWN_DELAY:
        begin 
        
            started_nxt = started;
            
            if(landed == 1) y_state_nxt = Y_IDLE;
            else if(colission_down == 1) y_state_nxt = UP_ACC;
            else if( up!=1) y_state_nxt = DOWN_ACC;
            else if(y_delay >= DELAY_MAX) y_state_nxt = UP_ACC;
            else if(y_pos > YPOS_MAX - ROCKET_HIGH) y_state_nxt = Y_IDLE;
            else y_state_nxt = y_state;
    
            if(y_pos <= YPOS_MAX - ROCKET_HIGH) y_pos_nxt = y_pos+1;
            else y_pos_nxt = y_pos;  

            y_delay_nxt = y_delay+3*DELAY_FACTOR;
            
        
        end
        
        
        endcase
      end
      
	else begin
	
	   started_nxt <= started;
	
	   y_speed_ctr_nxt = y_speed_ctr + 1;
	   y_pos_nxt = y_pos;
	   y_delay_nxt = y_delay;
	   y_state_nxt = y_state;
	   
	end
	
end

reg [2:0]x_state= X_IDLE;
reg [2:0]x_state_nxt;

always @*

begin

    if( x_speed_ctr == X_SPEED_DIVIDER + delay) begin
    
        x_speed_ctr_nxt = 0;
        
        case(x_state)
    
            X_IDLE:
            begin 
        
                if(colission_right == 1) x_state_nxt = LEFT_ACC;
                else if(colission_right == 1) x_state_nxt = RIGHT_ACC;
                else if((left == 1)&&(started == 1)) x_state_nxt = LEFT_ACC;
                else if((right == 1)&&(started == 1)) x_state_nxt = RIGHT_ACC;
                else x_state_nxt = X_IDLE;
        
                x_pos_nxt = x_pos;
                delay_nxt = DELAY_MAX;
    
            end 
    
            LEFT_ACC:
            begin
                if(landed == 1) x_state_nxt = X_IDLE;
                else if(colission_left == 1) x_state_nxt = RIGHT_ACC;
                else if( left != 1) x_state_nxt = LEFT_DELAY;
                else x_state_nxt = x_state;
                
                if(x_pos > XPOS_MIN) x_pos_nxt = x_pos-1;
                else x_pos_nxt = x_pos;  
                
                if(delay > DELAY_MIN) delay_nxt = delay-DELAY_FACTOR;
                else delay_nxt = delay;
    
            end
            LEFT_DELAY:
            begin
                
                if(landed == 1) x_state_nxt = X_IDLE;
                else if(colission_left == 1) x_state_nxt = RIGHT_ACC;
                else if( left == 1) x_state_nxt = LEFT_ACC;
                else if(delay >= DELAY_MAX) x_state_nxt = X_IDLE;
                else x_state_nxt = x_state;
                
                if(x_pos > XPOS_MIN) x_pos_nxt = x_pos-1;
                else x_pos_nxt = x_pos;  
            
                if(right == 1) delay_nxt = delay+2*DELAY_FACTOR;
                else delay_nxt = delay+DELAY_FACTOR;
                      
            end
    
            RIGHT_ACC:
            begin 
            
                if(landed == 1) x_state_nxt = X_IDLE;
                else if(colission_right == 1) x_state_nxt = LEFT_ACC;
                else if( right != 1) x_state_nxt = RIGHT_DELAY;
                else x_state_nxt = x_state;
            
                if(x_pos < XPOS_MAX - ROCKET_WIDTH) x_pos_nxt = x_pos+1;
                else x_pos_nxt = x_pos;  
            
                if(delay > DELAY_MIN) delay_nxt = delay-DELAY_FACTOR;
                else delay_nxt = delay;
    
    
            end
            RIGHT_DELAY:
            begin 
               
               if(landed == 1) x_state_nxt = X_IDLE;
               else if(colission_right == 1) x_state_nxt = LEFT_ACC;
               else if(delay >= DELAY_MAX) x_state_nxt = X_IDLE;
               else x_state_nxt = x_state;
            
                if(x_pos < XPOS_MAX - ROCKET_WIDTH) x_pos_nxt = x_pos+1;
                else x_pos_nxt = x_pos;  
        
                if( left == 1) delay_nxt = delay+2*DELAY_FACTOR;
                else delay_nxt = delay+DELAY_FACTOR;
    
            end        
    
    
    
    
        endcase
    
    end
    
    else begin

       x_speed_ctr_nxt = x_speed_ctr + 1;
       x_pos_nxt = x_pos;
       delay_nxt = delay;
       x_state_nxt = x_state;
    end

end



always @(posedge clk or posedge rst)
begin 
    
    if(rst==1)
    begin 
        started <= 0;
        x_pos <= 20;
        y_pos <= 496; 
        x_speed_ctr <= 0;
        y_speed_ctr <= 0;
        delay <= DELAY_MAX;
        x_state <= X_IDLE;
        y_delay <= DELAY_MAX;
        y_state <= Y_IDLE;    
    
    
    end
    else
    begin
    
        started <= started_nxt;
        x_pos <= x_pos_nxt;
        y_pos <= y_pos_nxt; 
        x_speed_ctr <= x_speed_ctr_nxt;
        y_speed_ctr <= y_speed_ctr_nxt;
        delay <= delay_nxt;
        x_state <= x_state_nxt;
        y_delay <= y_delay_nxt;
        y_state <= y_state_nxt;
    end

end 

assign leds = {started , landed};

endmodule


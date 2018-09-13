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
    
    output reg [11:0] x_pos,
    output reg [11:0] y_pos,
    
    output reg started
    );

// rewriten 

    localparam 
    
    // position 
    
        Y_START_POS= 496,
        X_START_POS= 20,
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
   
        DELAY_MAX = 2050000,
        DELAY_MIN = 4000,
        H_SPEED_DIVIDER = 100000,
        X_SPEED_DIVIDER = 100000,
        DELAY_FACTOR = 3000,
        START_DELAY = 1,
        MAX_ACC = 40000,
    
    // X_STATES
        X_START = 0,
        X_IDLE = 1,
        LEFT_ACC = 2,
        LEFT_DELAY = 3,
        RIGHT_ACC = 4,
        RIGHT_DELAY = 5,
 
        
   // Y_STATES 
        Y_START = 0,
        Y_IDLE = 1,
        UP_ACC = 2,
        UP_DELAY = 3,
        DOWN_ACC = 4,
        DOWN_DELAY = 5,
        LANDED = 6;  
        
        
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

    reg [3:0]y_state= Y_START;
    reg [3:0]y_state_nxt;
    
    reg [4:0] idle_ctr; 
    reg [4:0] idle_ctr_nxt;

always @*
    begin
    
        if( y_speed_ctr == (H_SPEED_DIVIDER + y_delay) ) begin
        
            y_speed_ctr_nxt = 0;
           
            
            case(y_state)
        
                Y_START:
                begin
                
                    if(up == 1) y_state_nxt = UP_ACC;
                    else y_state_nxt = Y_START;
                    
                    idle_ctr_nxt = 0;
                    started_nxt = 0;                 
                    y_pos_nxt =   Y_START_POS;
                    y_delay_nxt = DELAY_MAX/4;                                        
         
                end
                
                UP_ACC:
                begin
                    
                    if( colission_up == 1 ) y_state_nxt = DOWN_ACC;
                    else if( up == 0 ) y_state_nxt = UP_DELAY;
                    else y_state_nxt = UP_ACC; 
                    
                    idle_ctr_nxt = 0;
                    started_nxt = 1;
                    y_pos_nxt = (y_pos > YPOS_MIN) ? y_pos-1 : y_pos;             
                    y_delay_nxt = (y_delay > DELAY_MIN)? (y_delay-DELAY_FACTOR/2) : y_delay;
                
               end
               
               UP_DELAY:
               begin
                    
                    if( colission_up == 1 )
                    begin
                         y_state_nxt = DOWN_ACC;
                         y_delay_nxt = y_delay;

                    end
                    else if( up == 1 )
                    begin
                         y_state_nxt = UP_ACC;
                         y_delay_nxt = (y_delay <= DELAY_MAX/4)?  y_delay : DELAY_MAX/4;

                    end     
                    else if( y_delay >= DELAY_MAX )
                    begin
                         y_state_nxt = Y_IDLE;   
                         y_delay_nxt = DELAY_MAX/4;

                    end                 
                    else
                    begin
                         y_state_nxt = UP_DELAY; 
                         y_delay_nxt = (y_delay <= DELAY_MAX)? (y_delay+10*DELAY_FACTOR) : y_delay;

                    end
               
                    idle_ctr_nxt = 0;
                    started_nxt = 1;
                    y_pos_nxt = (y_pos > YPOS_MIN) ? y_pos-1 : y_pos;            
                   
               end 
               
               Y_IDLE:
               begin 
                    
                    if(idle_ctr < 5)begin
                         y_state_nxt = Y_IDLE; 
                         y_delay_nxt = DELAY_MAX;
                    end
                    else if( up == 1 )
                    begin
                         y_state_nxt = UP_ACC;
                         y_delay_nxt = DELAY_MAX/4;
                    end
                    else
                    begin
                         y_state_nxt = DOWN_ACC;
                         y_delay_nxt = DELAY_MAX/2;
                    end
                    
                    idle_ctr_nxt =  idle_ctr + 1;
                    started_nxt = 1;
                    y_pos_nxt = y_pos;
                    
                      
               end
               
               DOWN_ACC:
               begin
                    
                    if( colission_down == 1 ) y_state_nxt = UP_ACC;
                    else if( up == 1 ) y_state_nxt = DOWN_DELAY;
                    else if( landed == 1 ) y_state_nxt = LANDED;
                    else y_state_nxt = DOWN_ACC; 
               
                    idle_ctr_nxt = 0;
                    started_nxt = 1;
                    y_pos_nxt = (y_pos < (YPOS_MAX - ROCKET_HIGH) ) ? (y_pos+1) : y_pos;             
                    y_delay_nxt = (y_delay > DELAY_MIN)? (y_delay-DELAY_FACTOR) : y_delay;
               
               
               end
               
               
               DOWN_DELAY:
               begin
                    
                    if( colission_down == 1 )
                    begin
                        y_state_nxt = UP_ACC;
                        y_delay_nxt = y_delay;
                    end
                    else if( up == 0 ) 
                    begin
                        y_state_nxt = DOWN_ACC;
                        y_delay_nxt = (y_delay < DELAY_MAX/2)? y_delay : DELAY_MAX/2;

                    end
                    else if( y_delay >= DELAY_MAX/2 ) 
                    begin
                        y_state_nxt = Y_IDLE; 
                        y_delay_nxt = DELAY_MAX;

                    end
                    else if( landed == 1 )
                    begin 
                         y_state_nxt = LANDED;
                         y_delay_nxt = DELAY_MAX;
                    end                   
                    else
                    begin
                         y_state_nxt = DOWN_DELAY; 
                         y_delay_nxt = (y_delay < DELAY_MAX)? y_delay+5*DELAY_FACTOR : y_delay;
                    end
               
                    idle_ctr_nxt = 0;
                    started_nxt = 1;
                    y_pos_nxt = (y_pos < (YPOS_MAX - ROCKET_HIGH) ) ? y_pos+1 : y_pos;           
                   
               end 
               
               LANDED:
               begin
               
                   idle_ctr_nxt = 0;
                   started_nxt = 1;
                   y_state_nxt = LANDED;
                   y_pos_nxt = y_pos;
                   y_delay_nxt = y_delay;
               
               end
               
               default:
               begin
                    started_nxt = started;
                    y_speed_ctr_nxt = y_speed_ctr;
                    y_pos_nxt = y_pos;
                    y_delay_nxt = y_delay;
                    y_state_nxt = y_state;
                    idle_ctr_nxt = idle_ctr;
               
               end
               
               
        
          endcase 
        end
        
        else 
        begin
        
           started_nxt = started;
           y_speed_ctr_nxt = y_speed_ctr + 1;
           y_pos_nxt = y_pos;
           y_delay_nxt = y_delay;
           y_state_nxt = y_state;
           idle_ctr_nxt = idle_ctr;

           
        end
            
    
    end


reg [3:0]x_state= X_START;
reg [3:0]x_state_nxt;

 
reg [4:0] x_idle_ctr, x_idle_ctr_nxt;


always @*

begin

    if( x_speed_ctr == (X_SPEED_DIVIDER + delay)) begin
    
        x_speed_ctr_nxt = 0;
        
        case(x_state)
    
           X_START:
           begin 
                
                if(up == 1) x_state_nxt = X_IDLE;
                else x_state_nxt = X_START;
                
                x_idle_ctr_nxt = 0;
                x_pos_nxt = X_START_POS;
                delay_nxt = DELAY_MAX;
           
           end
    
            
            X_IDLE:
            begin 
        
                if(colission_right == 1) x_state_nxt = LEFT_ACC;
                else if(colission_right == 1) x_state_nxt = RIGHT_ACC;
                else if ( x_idle_ctr<5 ) x_state_nxt = X_IDLE;
                else if(left == 1) x_state_nxt = LEFT_ACC;
                else if(right == 1) x_state_nxt = RIGHT_ACC;
                else x_state_nxt = X_IDLE;
        
                x_idle_ctr_nxt = x_idle_ctr + 1;
                x_pos_nxt = x_pos;
                delay_nxt = DELAY_MAX/4;
    
            end 
    
            LEFT_ACC:
            begin

                
                x_idle_ctr_nxt = 0;
                
                x_pos_nxt = (x_pos > XPOS_MIN)? ( x_pos-1 ) : x_pos;  
                
                delay_nxt = (delay > DELAY_MIN)? (delay-DELAY_FACTOR) : delay;
                
                if(landed == 1) x_state_nxt = LANDED;
                else if(colission_left == 1) x_state_nxt = RIGHT_ACC;
                else if( (left == 0) ) x_state_nxt = LEFT_DELAY;
                else x_state_nxt = LEFT_ACC;
    
            end
            LEFT_DELAY:
            begin
                
               
                
                if(landed == 1) begin
                     x_state_nxt = LANDED;
                     delay_nxt = DELAY_MAX;
                end
                else if(colission_left == 1)begin
                     x_state_nxt = RIGHT_ACC;
                     delay_nxt = delay;
                end
                else if( left == 1) begin
                    x_state_nxt = LEFT_ACC;
                    delay_nxt = (delay < DELAY_MAX/4) ?   delay : ( DELAY_MAX/4 );

                end
                else if(delay >= DELAY_MAX/2) begin
                    x_state_nxt = X_IDLE;
                    delay_nxt = DELAY_MAX/4;
                end
                else begin
                     x_state_nxt = LEFT_DELAY;
                     delay_nxt = (right == 1) ? (delay+5*DELAY_FACTOR) : (delay+DELAY_FACTOR);

                end
                
                x_idle_ctr_nxt = 0;
                x_pos_nxt = (x_pos > XPOS_MIN)? ( x_pos-1 ): x_pos;  
            
                      
            end
    
            RIGHT_ACC:
            begin 
            

            
                x_idle_ctr_nxt = 0;
                if(x_pos < (XPOS_MAX - ROCKET_WIDTH))   x_pos_nxt = x_pos+1;
                else  x_pos_nxt =  x_pos;
 
                if (delay > DELAY_MIN) delay_nxt = (delay-DELAY_FACTOR); 
                else delay_nxt = delay;

                if(landed == 1) x_state_nxt = LANDED;
                else if(colission_right == 1) x_state_nxt = LEFT_ACC;
                else if( right == 0) x_state_nxt = RIGHT_DELAY;
                else x_state_nxt = RIGHT_ACC;
    
    
            end
            RIGHT_DELAY:
            begin 
               
               if(landed == 1)begin
                     x_state_nxt = LANDED;
                     delay_nxt = DELAY_MAX;
               end
               else if(colission_right == 1) begin
                     x_state_nxt = LEFT_ACC;
                     delay_nxt = delay;
               end
               else if(right == 1) begin
                     x_state_nxt = RIGHT_ACC;
                     delay_nxt = (delay <= DELAY_MAX/4) ?   delay :( DELAY_MAX/4 );

                     
               end
               else if(delay >= DELAY_MAX/2) begin
                     x_state_nxt = X_IDLE;
                     delay_nxt = DELAY_MAX/4;
               end
               else begin
                    x_state_nxt = RIGHT_DELAY;
                    delay_nxt =(left == 1) ? (delay+5*DELAY_FACTOR) : (delay+DELAY_FACTOR);

               end
            
               x_idle_ctr_nxt = 0;
               x_pos_nxt = (x_pos < ( XPOS_MAX - ROCKET_WIDTH ))?  ( x_pos+1 ) : x_pos;  
        
    
            end        
    
            LANDED:
            begin
            
                x_idle_ctr_nxt = 0;
                
                x_state_nxt = LANDED;
                x_pos_nxt = x_pos;
                delay_nxt = delay;
            
            
            end
        default: 
        begin        
            
            x_speed_ctr_nxt = x_speed_ctr;
            x_pos_nxt = x_pos;
            delay_nxt = delay;
            x_state_nxt = x_state;
            x_idle_ctr_nxt = x_idle_ctr;
            
        end
        endcase
    
    end
    
    else begin

       x_speed_ctr_nxt = x_speed_ctr + 1;
       x_pos_nxt = x_pos;
       delay_nxt = delay;
       x_state_nxt = x_state;
       x_idle_ctr_nxt = x_idle_ctr;
    end

end







always @(posedge clk or posedge rst)
begin 
    
    if(rst==1)
    begin 
        started <= 0;
        x_pos <= X_START_POS;
        y_pos <= Y_START_POS; 
        x_speed_ctr <= 0;
        y_speed_ctr <= 0;
        delay <= DELAY_MAX;
        x_state <= X_START;
        y_delay <= DELAY_MAX;
        y_state <= Y_START; 
        idle_ctr <= 0;   
        x_idle_ctr <= 0; 
    
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
        idle_ctr <= idle_ctr_nxt;
        x_idle_ctr <= x_idle_ctr_nxt;
    end

end 


endmodule


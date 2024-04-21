module LED_blink_FSM(
    input logic clk,          
    input logic rst,        
    output logic led          
);

    // State declaration using single bit
    typedef enum logic {
        STATE_OFF = 1'b0,
        STATE_ON  = 1'b1
    } state_t;
    
    // State variables
    state_t current_state = STATE_ON, next_state; // next_state doesnt need initial value
	
    // Counter for timing control
    reg [27:0] counter;  // 28-bit counter to count up to 27,000,000


    // State transition and counter logic
	/*
		Below always block will reset the LED to off whenever button is clicked i.e. on posedge. 
		Button should be in  PULL_MODE=DOWN mode and connect to +5V 
	*/
    always_ff@(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= STATE_OFF; // rst becomes 1 automatically, for first 1 second the LED is OFF 
            counter <= 0;               
        end 
		else begin
            counter <= counter + 1;     
            if (counter >= 27000000) begin
                current_state <= next_state; 
                counter <= 0;                
            end
        end
    end

	
	/*
		Below always block will reset the LED to off whenever button is clicked 
		button should be in  PULL_MODE=UP mode and connected to GND 
	*/
	
	/*	 always_ff@(posedge clk or negedge rst) begin
			 if (!rst) begin
				 current_state <= STATE_OFF;  
				 counter <= 0;               
			 end 
			 else begin
				 counter <= counter + 1;     
				 if (counter >= 27000000) begin
					 current_state <= next_state; 
					 counter <= 0;                
				 end
			 end
		 end
	*/

    // Next state logic based on current state
    always_comb begin
        case (current_state)
            STATE_OFF: next_state = STATE_ON;  // Transition to ON after 1 second
            STATE_ON:  next_state = STATE_OFF; // Transition to OFF after 1 second
            default:   next_state = STATE_OFF; // Default case to handle unknown states
        endcase
    end

    // Output logic based on current state (Moore output)
    always_ff@(posedge clk) begin
        case (current_state)
            STATE_OFF: led = 1'b0;  // LED is off
            STATE_ON:  led = 1'b1;  // LED is on
            default:   led = 1'b0;  // Default case to ensure defined output
        endcase
    end

endmodule

module LED_blink_FSM(
    input logic clk,          
    input logic rst_n,        
    output logic led          
);

    // State declaration using enum
    typedef enum logic [1:0] {
        STATE_OFF = 2'b00,
        STATE_ON  = 2'b01
    } state_t;
    
    // State variables
    state_t current_state, next_state = STATE_ON;

    // Counter for timing control
    reg [27:0] counter;  // 28-bit counter to count up to 27,000,000

    // State transition and counter logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= STATE_OFF;  // Reset state
            counter <= 0;                // Reset counter
        end 
		else begin
			counter <= counter + 1;        // Increment counter
            if (counter >= 27_000_000) begin
                current_state <= next_state;  // Change state every 27,000,000 cycles
                counter <= 0;                  // Reset counter
        	end
		end
    end

    // Next state logic based on current state
    always_comb begin
        case (current_state)
            STATE_OFF: next_state = STATE_ON;  // Transition to ON after 1 second
            STATE_ON:  next_state = STATE_OFF; // Transition to OFF after 1 second
            default:   next_state = STATE_OFF; // Default case to handle unknown states
        endcase
    end

    // Output logic based on current state (Moore output)
    always_ff @(posedge clk) begin
        case (current_state)
            STATE_OFF: led = 1'b0;  // LED is off
            STATE_ON:  led = 1'b1;  // LED is on
            default:   led = 1'b0;  // Default case to ensure defined output
        endcase
    end

endmodule

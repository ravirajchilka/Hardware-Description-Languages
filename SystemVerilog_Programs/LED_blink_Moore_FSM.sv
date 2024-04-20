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
    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= STATE_OFF;  // Reset state
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_OFF: next_state = STATE_ON;
            STATE_ON:  next_state = STATE_OFF;
            default:   next_state = STATE_OFF; // Default case to handle unknown states
        endcase
    end

    // Output logic based on current state
    always_ff @(posedge clk) begin
        case (current_state)
            STATE_OFF: led = 1'b0;  // LED is off
            STATE_ON:  led = 1'b1;  // LED is on
            default:   led = 1'b0;  // Default case to ensure defined output
        endcase
    end

endmodule


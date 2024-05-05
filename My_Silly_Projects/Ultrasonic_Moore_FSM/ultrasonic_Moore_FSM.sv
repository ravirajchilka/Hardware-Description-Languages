/*
		The output of Ultrasonic sensors is highly unstable for that reason I couldnt able to measure the pulse width of the echo signal transmitted by 
		Ultrasonic sensor. The counter is resetting even if the pulse is high for 1 second duration
*/
module ultrasonic_FSM(
	input clk,rst,echo_pin,
	output reg trigger_pin, LED_pin	
);

		typedef enum [1:0] {
				IDLE,
				GENERATE_TRIGGER,
				WAIT,
				RECIEVE_ECHO
		} process_states;

		process_states current_state, next_state; 
		reg [31:0] counter; 
		reg [31:0] event_timer; 

		//width calucation
		reg [31:0] width_counter;
		reg [31:0] pulse_width;
		reg signal_last_state;


		always_comb begin 
				case(current_state) 
						IDLE:next_state = GENERATE_TRIGGER;
						GENERATE_TRIGGER:next_state = WAIT;
						WAIT:next_state = RECIEVE_ECHO;
						RECIEVE_ECHO:next_state = GENERATE_TRIGGER;
						default: next_state = IDLE;
				endcase
		end

		always_ff@(posedge clk or negedge rst) begin 
				if(!rst) begin 
						current_state <= IDLE;
						end
						else begin 
						event_timer <= event_timer + 1;
						if(event_timer == 1000000) begin // 1000000
						current_state <= next_state;
						event_timer <= 0;	 
						end
				end
		end	

		always_ff@(posedge clk) begin
				case(current_state) 
						IDLE: trigger_pin = 1'b0;
						GENERATE_TRIGGER: begin 
							 counter <= counter + 1;
						if(counter == 300000)  // Reset after 270 cycles for a 10 microsecond pulse
								counter <= 0;
						if(counter < 270)   // Set trigger_pin high for the first 270 cycles
								trigger_pin <= 1;
						else
								trigger_pin <= 0;
						end 
						WAIT: begin
								trigger_pin = 1'b0;
						end 
						RECIEVE_ECHO: trigger_pin = 1'b0;
				endcase
		end	
		

		//always block for pulse width calcualtion

		always_ff@(posedge clk or negedge rst) begin 
				if(!rst) begin 
						pulse_width <= 0;
						width_counter <= 0;
						signal_last_state <= 0;
				end
				else begin 
//						if(echo_pin) begin
//								width_counter <= width_counter + 1;
//						end
//						else begin 
//								pulse_width <= width_counter;
//								width_counter <= 0;
//						end
						if (echo_pin && !signal_last_state) begin
								width_counter <= 0;
						end
						if (echo_pin) begin
								width_counter <= width_counter + 1;
						end
						if (!echo_pin && signal_last_state) begin
								pulse_width <= width_counter;
								width_counter <= 0; 
						end
						signal_last_state <= echo_pin;
				end
		end


		always_ff@(posedge clk) begin
				if (pulse_width > 5) 
						LED_pin <= 1; 
				else 
						LED_pin <= 0;  
		end

endmodule




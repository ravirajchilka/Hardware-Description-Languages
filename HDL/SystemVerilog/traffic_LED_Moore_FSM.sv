module trafficlightcontrollerfsm(
	input clk, rst,
	output logic r,g,y // 74,73,75
);

	// state transition GREEN TO YELLOW, YELLOW TO RED then back to GREEN

	typedef enum logic [1:0] {
		RED,YELLOW,GREEN
	} signal_states;


	signal_states current_state,next_state;
	logic [31:0] counter;

	always_comb begin
		case(current_state) 
			GREEN:next_state = YELLOW;
			YELLOW:next_state = RED;
			RED:next_state = GREEN;
			default: next_state = GREEN;
		endcase
	end

	always_ff@(posedge clk or negedge rst) begin 
		if(!rst) begin 
			counter <= 0;
			current_state <= GREEN; // this will make GREEN LED to start first				 
		end
		else begin 
			counter <= counter + 1;
			if(counter == 27000000)
				current_state <= next_state;
			if(counter>27000000)
				counter <= 0;
		end
	end
	
	always_ff@(posedge clk) begin
		if(current_state == GREEN) begin 
			g <= 1'b1;
			y <= 1'b0;
			r <= 1'b0;
		end
		else if(current_state == YELLOW) begin 
			g <= 1'b0;
			y <= 1'b1;
			r <= 1'b0;
		end
		else begin
			g <= 1'b0;
			y <= 1'b0;
			r <= 1'b1;
		end
	end

endmodule


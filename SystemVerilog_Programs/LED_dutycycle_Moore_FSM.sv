module ledfsm(
	input clk, rst,
	output reg led
);

	typedef enum bit {
		ON = 1'b1, OFF=1'b0
	} state_t;

	state_t current_state = ON, next_state;
	reg [27:0] counter;
	
	always_comb begin 
		case(current_state)
			ON: next_state = OFF;
			OFF: next_state = ON;
			default: next_state = OFF;
		endcase
	end


	always_ff@(posedge clk or negedge rst) begin 
		if(!rst) begin 
			current_state <= OFF;
			counter <= 1'b0;
		end
		else begin 
			counter <= counter + 1;

			// Below code producees 2 seconsd ON and 1 second OFF time, starting from 2 seconds ON
			if(counter == 0)
				current_state <= next_state;
			if(counter == 2*27000000)
				current_state <= next_state;
			if(counter > 3*27000000) 
				counter <= 0;


            /*Below code producees 3 seconsd OFF and 1 second ON time, starting from 3 seconds OFF*/
			/*
			if(counter == 3*27000000)
				current_state <= next_state;
			if(counter == 4*27000000)
				current_state <= next_state;
			if(counter > 4*27000000) 
				counter <= 0;
			*/

		end
	end


	always_ff@(posedge clk) begin
		case(current_state) 
			ON: led = 1'b1;
			OFF: led = 1'b0;
		endcase
	 end

endmodule

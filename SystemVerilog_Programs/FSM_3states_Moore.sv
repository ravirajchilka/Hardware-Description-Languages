module fsm_3states(
		input clk, rst_n,
		output reg sig
);
		//outputs signal sig 101011000111110
		typedef enum logic [1:0] {
				IDLE,STATE1,STATE2,STATE3
		} states;

		states current_state, next_state;				
		reg [31:0] counter;

		parameter MILLISECOND_COUNT = 27000;

		always_comb begin 
				case(current_state)
						IDLE: next_state = STATE1;
						STATE1: begin 
								if(counter == 4*MILLISECOND_COUNT)
									next_state = STATE2;
								else 
									next_state = STATE1;	
						end
						STATE2: begin 
								if(counter == 5*MILLISECOND_COUNT)
									next_state = STATE3;
								else 
									next_state = STATE2;
						end
						STATE3: begin 
								if(counter == 6*MILLISECOND_COUNT)
									next_state = IDLE;
								else 
									next_state = STATE3;
						end
						default: next_state = IDLE;
				endcase
		end


		always_ff@(posedge clk or negedge rst_n) begin 
				if(!rst_n) begin 
						current_state <= IDLE;
				end
				else begin 
						current_state <= next_state;
				end
		end


		always_ff@(posedge clk) begin 
				case(current_state) 
						IDLE: begin 
							sig <= 0;
							counter <= 0;
						end 
						STATE1: begin 
								counter <= counter + 1;
								if(counter < MILLISECOND_COUNT) 
										sig <= 1;
								if(counter > MILLISECOND_COUNT && counter < 2*MILLISECOND_COUNT)
										sig <= 0;
								if(counter > 2*MILLISECOND_COUNT && counter < 3*MILLISECOND_COUNT)
										sig <= 1;
								if(counter > 3*MILLISECOND_COUNT && counter < 4*MILLISECOND_COUNT)  
										sig <= 0;
								 if(counter == 4*MILLISECOND_COUNT) 
										counter <= 0;
						end 
						STATE2: begin 
								counter <= counter + 1;
								if(counter < 2*MILLISECOND_COUNT) 
										sig <= 1;
								if(counter > 2*MILLISECOND_COUNT && counter < 5*MILLISECOND_COUNT)
										sig <= 0;
								if(counter == 5*MILLISECOND_COUNT)
										counter <= 0;
						end 
						STATE3: begin 
								counter <= counter + 1;
								if(counter < 5*MILLISECOND_COUNT) 
										sig <= 1;
								if(counter > 5*MILLISECOND_COUNT && counter < 6*MILLISECOND_COUNT)
										sig <= 0;
								if(counter == 6*MILLISECOND_COUNT)
										counter <= 0;
						end 
				endcase
		end

endmodule
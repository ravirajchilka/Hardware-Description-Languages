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

		parameter CLK_FREQ = 27000;

		always_comb begin 
				case(current_state)
						IDLE: next_state = STATE1;
						STATE1: begin 
								if(counter == 4*CLK_FREQ)
									next_state = STATE2;
								else 
									next_state = STATE1;	
						end
						STATE2: begin 
								if(counter == 5*CLK_FREQ)
									next_state = STATE3;
								else 
									next_state = STATE2;
						end
						STATE3: begin 
								if(counter == 6*CLK_FREQ)
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
								if(counter < CLK_FREQ) 
										sig <= 1;
								if(counter > CLK_FREQ && counter < 2*CLK_FREQ)
										sig <= 0;
								if(counter > 2*CLK_FREQ && counter < 3*CLK_FREQ)
										sig <= 1;
								if(counter > 3*CLK_FREQ && counter < 4*CLK_FREQ)  
										sig <= 0;
								 if(counter == 4*CLK_FREQ) 
										counter <= 0;
						end 
						STATE2: begin 
								counter <= counter + 1;
								if(counter < 2*CLK_FREQ) 
										sig <= 1;
								if(counter > 2*CLK_FREQ && counter < 5*CLK_FREQ)
										sig <= 0;
								if(counter == 5*CLK_FREQ)
										counter <= 0;
						end 
						STATE3: begin 
								counter <= counter + 1;
								if(counter < 5*CLK_FREQ) 
										sig <= 1;
								if(counter > 5*CLK_FREQ && counter < 6*CLK_FREQ)
										sig <= 0;
								if(counter == 6*CLK_FREQ)
										counter <= 0;
						end 
				endcase
		end

endmodule

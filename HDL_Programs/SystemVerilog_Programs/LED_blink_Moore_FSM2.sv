module fsm(
		input clk,rst,
		output logic sig
);

		typedef enum logic [1:0] {
				IDLE,TX
		} state;

		state cstate,nstate;
		logic [26:0] c;

		always_comb begin 
				case(cstate)
						IDLE: begin 
								nstate = TX;
						end
						TX: begin 
								if(c==3*27000000)
										nstate = IDLE;
								else 
										nstate = TX;
						end
						default: nstate = IDLE;
				endcase
		end


		/*
		Below always block will reset the LED to off condition and reset to IDLE state whenever button is clicked 
		Button should be in  PULL_MODE=UP mode and connected to GND 
		*/

		always_ff@(posedge clk or negedge rst) begin 
				if(!rst) begin 
					cstate <= IDLE; 
				end	
				else begin 
						cstate <= nstate;
				end
		end


		always_ff@(posedge clk) begin 
				case(cstate) 
						IDLE: begin 
							sig <= 0;
							c <= 0;	
						end
						TX: begin 
								c <= c+1;
								if(c<27000000) 
										sig <= 1;
								else 
										sig <= 0;
								// Not required as on this condition always_comb will set c to 0
								// reset c = 0
								//	if(c==3*27000000)  
								//			c <= 0;
						end
				endcase
		end

endmodule

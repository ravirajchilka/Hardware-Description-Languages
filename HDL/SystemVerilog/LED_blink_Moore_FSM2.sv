// Exactly! Your explanation of the Moore FSM operation is on point. Let me expand it slightly for clarity and confirm the sequence:

// ---

// ### Step-by-step execution of your **Moore FSM**:

// 1. **Reset (`rst_n` low)**:

//    * The **state register block** (`always_ff @(posedge clk or negedge rst_n)`) immediately sets `current_state` to `IDLE`.
//    * The output & counter block sees `IDLE` state → sets `sig = 0` and `counter = 0`.

// 2. **Next-state logic (`always_comb`)**:

//    * It continuously monitors `current_state`.
//    * When `current_state == IDLE`, it sets `next_state = TX`.

// 3. **At the next clock edge**:

//    * The **state register** updates `current_state <= next_state`, so `current_state` becomes `TX`.
//    * The output & counter block starts running the `TX` case:

//      * It increments the `counter` every clock cycle.
//      * Sets `sig` to `1` while `counter < CLOCK_CLK` (1 second).
//      * Sets `sig` to `0` when `counter >= CLOCK_CLK` (next 2 seconds).

// 4. **When `counter == 3 * CLOCK_CLK` (3 seconds total)**:

//    * The next-state logic sets `next_state = IDLE`.

// 5. **On the following clock edge**:

//    * `current_state` goes back to `IDLE`.
//    * Counter and `sig` reset to zero.

// 6. **Cycle repeats** indefinitely.

// ---

// ### Summary

// * **Reset sets initial state** to `IDLE`.
// * **Next-state logic (combinational)** chooses the next state based on the current state and conditions.
// * **State register** updates the state on each clock edge.
// * **Output & counter block** generates output `sig` based solely on current state and counter.
// * The output changes **only on clock edges** — this is Moore FSM behavior.

// ---


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

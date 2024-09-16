module fsm (
    input clk,rst_n,
    output logic SCLK,CS,DO
);

  typedef enum logic [1:0] {
    IDLE,
    READY,
    TX,
    STOP
  } states;

  states current_state, next_state;

	logic SCLK_d;
    logic posedge_detected;
	logic [2:0] counter;
	logic [5:0] data;

		always_comb begin 
		    case (current_state)
            		IDLE: next_state = READY;
						READY: begin
							if(!CS)
								 next_state = TX;
							else 
								 next_state = READY;
						end
						TX: begin
							if(counter == 6)
								 next_state = STOP;
							else 
								 next_state = TX;
						end
						STOP: next_state = IDLE;
            		default: next_state = IDLE;
       		 endcase
		end


		always_ff @(posedge clk or negedge rst_n) begin
				if (!rst_n)
						current_state <= IDLE;
				else
						current_state <= next_state;
        	end

        READY: begin
          CS <= 0;
        end

        TX: begin
          if (!CS) SCLK <= ~SCLK;

          if (SCLK && !SCLK_d) begin
            posedge_detected <= 1;
          end  // else block used when posedge doesnt exist 
               // because the current change will reflect in next clock cyle
          else begin
            if (!CS) begin
              counter <= counter + 1;
              if (counter < 6) begin
                posedge_detected <= 0;
                DO <= data[counter];
              end
            end
          end
          //finally assign SCLK value to delayed value    
          SCLK_d <= SCLK;
        end

        STOP: begin
          CS <= 1'b0;
          DO <= 1'bx;
        end
      endcase
    end
  end

  // synchronization doesnt happen if external always_ff block is used for SCLK generation
  // 		always_ff @(posedge clk or negedge rst_n) begin
  //         if (!rst_n)
  //             SCLK <= 0;
  //         else
  //           if(!CS)
  //             SCLK <= ~SCLK;
  //     end

endmodule

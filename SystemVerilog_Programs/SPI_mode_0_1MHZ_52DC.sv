/* The SCLK frequency is 1MHz with 52% duty cycle*/

module fsm(
	input clk,rst_n,
	output reg SCLK,MOSI,CS
);

	reg [30:0] sclk_counter;
	reg [30:0] testc;	

	typedef enum logic [1:0] {
		IDLE,READY,TX,STOP
	} spi_states;

	spi_states current_state, next_state;

	always_ff@(posedge clk or negedge rst_n) begin 
		if(!rst_n) begin 
			current_state <= IDLE;
		end
		else begin 
			current_state <= next_state;
		end
	end

	always_comb begin 
		case(current_state) 
			IDLE: next_state = READY;
			READY : next_state = TX;
			TX: begin 
				if(testc == 100) begin 
					next_state = next_state;
				end else begin 
					next_state = TX;
				end
			end 
			default: next_state = IDLE;
		endcase
	end

	always_ff@(posedge clk) begin 
		case(current_state)
			IDLE: begin 
				SCLK <= 0;
				CS <= 1;
				MOSI <= 0;
			end

			READY: begin 
				CS <= 0;
			end

			TX: begin 
				sclk_counter <= sclk_counter + 1;
      
                if(sclk_counter < 12.5) 
                    SCLK <= 1'b0; 
                else 
                    SCLK <= 1'b1; 
            
                if(sclk_counter > 2*12.5) begin
                    sclk_counter <= 0;
                    testc <= testc + 1;
                end
			end
		endcase
	end

endmodule


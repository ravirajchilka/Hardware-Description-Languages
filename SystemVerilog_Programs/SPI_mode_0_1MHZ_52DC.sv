module fsm(
	input clk,rst_n,
	output reg SCLK,MOSI,CS
);

    reg [4:0] sclk_counter;
    reg [2:0] data_counter;
    reg [7:0] MOSI_data;

    reg SCLK_prev;  // To detect SCLK negative edge

    typedef enum logic [1:0] {
	IDLE,
	READY,
	TX,
	STOP
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
				if(data_counter > 7) begin 
					next_state = IDLE;
				end 
				else begin  
					next_state = TX;
				end
			end 
			default: next_state = IDLE;
		endcase
	end

    always_ff@(posedge clk) begin 
		case(current_state)
			IDLE:begin 
				SCLK <= 1;
				CS <= 1;
				MOSI <= 0;
				MOSI_data <= 8'b11010000;
				data_counter <= 8;
			end

			READY: begin 
				CS <= 0;
			end

			TX: begin 
				sclk_counter <= sclk_counter + 1;

				if(sclk_counter < 12.5) begin
					SCLK <= 1'b0; 					
				end
				else begin 
					SCLK <= 1'b1; 
				end
				if(sclk_counter > 2*12.5) begin
					sclk_counter <= 0;
				end
						
				if (SCLK_prev == 1'b1 && SCLK == 1'b0) begin 
					if (data_counter < 8) begin 
						MOSI <= MOSI_data[data_counter]; // Send MSB first
						data_counter <= data_counter + 1; // Increment data counte\r
					end
				end

				SCLK_prev <= SCLK; // Update previous SCLK state
			end
		endcase
    end

endmodule



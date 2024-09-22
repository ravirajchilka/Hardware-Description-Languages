
/*
    The FSM is working fine but CS always outputs 0 , I was not able to find the reason behind that it could be
    due the way GOWIN FPGA sythesis works. Once reset button pressed then CS goes high and we can see the output.
    I interfaced MCP3008 10 bit ADC as slave and used resistors to create voltage divider circuit to get analog singal
    and was able to see the output on logic anaylzer.
*/

module mcp3008_spi_master_fsm (
   input clk, rst_n,
   output logic SCLK,MOSI,CS
);

   logic [5:0] sclk_counter;
   logic [3:0] data_counter;
   logic [15:0] MOSI_data;

   bit SCLK_prev;  // To detect SCLK negative edge

   typedef enum logic [1:0] {
        IDLE,
        READY,
        TX,
        STOP
	} spi_states;

	spi_states current_state, next_state;

	always_ff @(posedge clk or negedge rst_n) begin
	    if (!rst_n) begin
		    current_state <= IDLE;
	    end else begin
		    current_state <= next_state;
	    end
	end

	always_comb begin
	    case (current_state)
            IDLE: next_state = READY;
            READY: next_state = TX;
            TX: begin
                if (data_counter <= 15) begin
                    next_state = TX;
                end else begin
                    next_state = STOP;
                end
            end
            STOP: next_state = IDLE;
            default: next_state = IDLE;
	    endcase
	end

	always_ff @(posedge clk) begin
	    case (current_state)
		IDLE: begin
		    SCLK <= 1;
		    CS <= 1;
		    MOSI <= 0;
		    MOSI_data <= 0;
		    data_counter <= 0;
		    sclk_counter <= 0;
		    SCLK_prev <= 1;  // Initialize SCLK_prev
		end

		READY: begin
		    CS <= 0;
		    MOSI_data <= 16'b0000000110000000; // Command byte + Data byte for MCP3008 to select channel 0
		end

		TX: begin
		    CS <= 0;
		    sclk_counter <= sclk_counter + 1;

		    if (sclk_counter < 12.5) begin
			    SCLK <= 1'b0;
		    end else begin
			    SCLK <= 1'b1;
		    end
		    if (sclk_counter > 2 * 12.5) begin
			    sclk_counter <= 0;
		    end

		    if (SCLK_prev == 1'b1 && SCLK == 1'b0) begin
			    MOSI <= MOSI_data[15-data_counter]; // Send MSB first
			    data_counter <= data_counter + 1;
		    end

		    SCLK_prev <= SCLK;  // Update previous SCLK state
		end

		STOP: begin
		    CS <= 1;
		    SCLK <= 1;
		    MOSI <= 0;
		end
	    endcase
	end

endmodule



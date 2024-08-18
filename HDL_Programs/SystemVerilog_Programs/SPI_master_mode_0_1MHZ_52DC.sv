/* for testing purpose data is being sent on negedge of SCLK */

module fsm (
    input clk,
    rst_n,
    output logic SCLK,
    MOSI,
    CS
);

  logic [5:0] sclk_counter;
  logic [2:0] data_counter;
  logic [7:0] MOSI_data;

  logic SCLK_prev;  // To detect SCLK negative edge

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
        if (data_counter <= 7) begin
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
        MOSI_data <= 8'b01001100;
        data_counter <= 0;
        sclk_counter <= 0;
        SCLK_prev <= 1;  // Initialize SCLK_prev
      end

      READY: begin
        CS <= 0;
      end

      TX: begin
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
          MOSI <= MOSI_data[data_counter]; // Send LSB first, for sending MSB first use [7-data_counter]
          data_counter <= data_counter + 1;
        end

        SCLK_prev <= SCLK;  // Update previous SCLK state
      end

      STOP: begin
        CS   <= 1;
        SCLK <= 1;
        MOSI <= 0;
      end
    endcase
  end
endmodule


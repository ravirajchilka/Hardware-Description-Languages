module SPI_ADC_MASTER (
    input clk,
    rst_n,
    output logic CS,
    MOSI,
    SCLK
);

  logic [4:0] bit_counter;
  logic [5:0] sclk_counter;
  logic [23:0] data;
  logic [23:0] data_counter;
  logic edge_position = 0;

  typedef enum logic [1:0] {
    IDLE,
    READY,
    TX,
    STOP
  } spi_adc_states;

  spi_adc_states current_state, next_state;


  // generate 24 bits 00000001 10000000 00000000
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      current_state <= IDLE;
    end else begin
      current_state <= next_state;
    end
  end

  always_comb begin
    case (current_state)
      IDLE: begin
        next_state = READY;
      end
      READY: begin
        next_state = TX;
      end
      TX: begin
        if (data_counter <= 23) begin
          next_state = TX;
        end else begin
          next_state = STOP;
        end
      end
      STOP: begin
        next_state = IDLE;
      end
      default: next_state = IDLE;
    endcase
  end

  always_ff @(posedge clk) begin
    case (current_state)
      IDLE: begin
        CS <= 1;
        MOSI <= 0;
        data_counter <= 0;
        data <= 0;
        SCLK <= 0;
        sclk_counter <= 0;
        edge_position <= 1;
      end

      READY: begin
        data <= 24'b00000001_10000000_00000000;
        CS   <= 0;
      end

      TX: begin
        sclk_counter <= sclk_counter + 1;
        if (sclk_counter <= 12.5) begin
          SCLK <= 1'b0;
        end else begin
          SCLK <= 1'b1;
        end
        if (sclk_counter > 2 * 12.5) begin
          sclk_counter <= 0;
        end

        if (SCLK == 1'b0 && edge_position == 1'b1) begin
          data_counter <= data_counter + 1;
          MOSI <= data[23-data_counter];
        end

        edge_position <= SCLK;
      end

      STOP: begin
        CS   <= 1;
        MOSI <= 0;
      end

    endcase
  end

endmodule



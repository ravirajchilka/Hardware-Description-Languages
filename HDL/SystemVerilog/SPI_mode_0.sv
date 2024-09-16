module fsm (
    input clk,rst_n,
    output logic SCLK,CS,DO
);

  typedef enum logic [1:0] {
    IDEAL,
    READY,
    TX,
    STOP
  } spi_states;

  spi_states current_state, next_state;

  logic [0:7] data;
  logic [3:0] counter;
  logic prev_state;
  logic high_flag;

  always_comb begin
    case (current_state)
      IDEAL: begin
        next_state <= READY;
      end
      READY: begin
        next_state <= TX;
      end
      TX: begin
        if (counter == 8) next_state <= STOP;
        else next_state <= TX;
      end
      STOP: begin
        next_state <= IDEAL;
      end
      default: next_state <= IDEAL;
    endcase
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      current_state <= IDEAL;
    end else begin
      current_state <= next_state;
    end
  end

  always_ff @(posedge clk) begin
    case (current_state)
      IDEAL: begin
        counter <= 0;
        data <= 8'b10110001;
        CS <= 1;
        SCLK <= 0;
        DO <= 0;
      end
      READY: begin
        CS <= 0;
      end
      TX: begin
        if (!CS) SCLK <= ~SCLK;
        if (SCLK && !prev_state) begin
          high_flag <= 1;
           counter <= counter + 1;
          if (counter < 8) DO <= data[counter];
        end else begin
         
          high_flag <= 0;
        end

        prev_state <= SCLK;
      end
      STOP: begin
        CS <= 1;
        DO <= 1'bx;
      end
    endcase
  end


endmodule

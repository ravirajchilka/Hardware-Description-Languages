module fsm_2states_mealy(
    input logic clk,
    input logic rst_n,
    output logic sig
);

    typedef enum logic [1:0] {
        IDLE, TX
    } state;

    state current_state, next_state;
    logic [31:0] counter;

    parameter CLOCK_CLK = 100_000_000;

    //[1] Next-state logic (pure combinational)
    always_comb begin
        case (current_state)
            IDLE:       next_state = TX;
            TX:         next_state = (counter == 3 * CLOCK_CLK) ? IDLE : TX;
            default:    next_state = IDLE;
        endcase
    end

    //[2] State register (sequential block)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    //[3] Counter logic (sequential)
    always_ff @(posedge clk) begin
        case (current_state)
            IDLE: counter <= 0;
            TX:   counter <= counter + 1;
        endcase
    end

    //[4] Mealy output logic (combinational, real-time response)
    always_comb begin
        case (current_state)
            IDLE: sig = 0;
            TX:   sig = (counter < CLOCK_CLK) ? 1 : 0;
            default: sig = 0;
        endcase
    end

endmodule

module slaveSPI(
    input clk,rst_n,SCLK,MOSI,
    output logic data
);

    logic [15:0] shift_reg;   // 16-bit shift register
    integer bit_count;        // Bit counter

    always_ff@(posedge SCLK or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg <= 16'b0;
            bit_count <= 0;
            data <= 16'b0;
        end else begin
            // Shift in data from MOSI
            shift_reg <= {shift_reg[14:0], MOSI};
            bit_count <= bit_count + 1;

            // Capture data after 16 bits
            if (bit_count == 15) begin
                data <= shift_reg;
                bit_count <= 0;
            end
        end
    end
 

endmodule    















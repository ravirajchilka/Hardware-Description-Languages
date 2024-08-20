module slaveSPI (
    input rst_n, SCLK1,MOSI1,CS1,
    output logic data
);
    
    logic [15:0] shift_reg;  // Internal 16-bit shift register
    integer bit_count;       // Bit counter

    always_ff @(posedge SCLK1 or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg <= 16'b0;
            bit_count <= 0;
            data <= 1'b0; // Initialize data to a default state
        end else if (!CS1) begin
            // Only shift in data and operate when CS is low (active)
            shift_reg <= {shift_reg[14:0], MOSI1};

            // Output the current bit on the data line
            data <= shift_reg[15 - bit_count];

            // Increment the bit counter
            bit_count <= bit_count + 1;

            // Reset the bit counter after 16 bits
            if (bit_count == 15) begin
                bit_count <= 0; // Reset the bit counter for the next word
            end
        end
    end

endmodule

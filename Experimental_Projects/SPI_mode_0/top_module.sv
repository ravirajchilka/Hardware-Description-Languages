module top_module (
    input clk, rst_n,
    output logic SCLK, MOSI, CS,   // Outputs for the master
    input logic SCLK1, MOSI1, CS1, // Inputs for the slave
    output logic data              // Output from the slave
);

    // Internal signals to connect master and slave
    logic internal_sclk, internal_mosi, internal_cs;
    logic internal_data; // Internal signal for slave data output

    // Instantiate SPI Master
    masterSPI master_inst (
        .rst_n(rst_n),
        .clk(clk),
        .MOSI(internal_mosi),
        .SCLK(internal_sclk),
        .CS(internal_cs)
    );

    // Instantiate SPI Slave
    slaveSPI slave_inst (
        .rst_n(rst_n),
        .MOSI1(internal_mosi),
        .SCLK1(internal_sclk),
        .CS1(internal_cs),
        .data(internal_data) // Connect slave's data output
    );

    // Assign internal signals to I/O pins
    assign SCLK = internal_sclk;
    assign MOSI = internal_mosi;
    assign CS = internal_cs;
    assign data = internal_data; // Assign slave's data output to FPGA pin

endmodule
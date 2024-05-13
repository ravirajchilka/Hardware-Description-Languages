
`timescale 1ns/1ps


module SPI_8bits_Moore_tb;

//     // Inputs
//     wire clk;
//     wire rst;
//     wire tx_enable;

//     // Outputs
//     reg mosi;
//     reg cs;
    //reg sclk;

    reg clk;
    reg rst;
    reg tx_enable;

    // Outputs
    wire mosi;
    wire cs;
    wire sclk;
  
    // Instantiate the module under test
    ff dut (
        .clk(clk),
        .rst(rst),
        .tx_enable(tx_enable),
        .mosi(mosi),
        .cs(cs),
        .sclk(sclk)
    );

//       initial begin
//         $dumpfile("ff_tb.vcd");
//         $dumpvars(0, ff_tb);
//     end
  
  initial begin
    $dumpfile("SPI_8bits_Moore.vcd"); // Specify the VCD file name
    $dumpvars(0, SPI_8bits_Moore_tb); // Dump all signals in the testbench module
end

    // Clock generation
    always #5 clk = ~clk;

    // Test vectors
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        tx_enable = 0;

        // Reset the module
        #10 rst = 0;

        // Wait for some time
        #20;

        // Start transmission
        tx_enable = 1;
        #10 tx_enable = 0;

        // Wait for transmission to complete
        #500;

        // Start another transmission
        tx_enable = 1;
        #10 tx_enable = 0;

        // Wait for transmission to complete
        #500;

        // Finish simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t, mosi=%b, cs=%b, sclk=%b", $time, mosi, cs, sclk);
    end

endmodule

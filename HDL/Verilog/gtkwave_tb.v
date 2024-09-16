`include "ff.v"
 `timescale 1ns / 1ps
 //`timescale 1ns / 1ps

module ff_tb;

    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire opin;

    // Instantiate the Unit Under Test (UUT)
    ff uut (
        .clk(clk),
        .rst(rst),
        .opin(opin)
    );


    time highv = 0;
    time lowv = 0;

    reg first_high_flag = 1'b1; // Flag for the first time opin is high
    reg first_low_flag = 1'b1;  // Flag for the first time opin is low
    
    reg [31:0] counter;

     // Dump all signals to a VCD file
    initial begin
        $dumpfile("ff_tb.vcd");
        $dumpvars(0, ff_tb);
    end

    // Clock generation
    initial begin
        clk = 0;
        forever #18.5 clk = ~clk; // Generate a clock with a period of 10 ns
    end

    // Stimulus here
    initial begin
        // Initialize Inputs
        rst = 0;

        // Reset the system
        #100;
        rst = 1;
        #100;
        rst = 0;
        #1000;
        rst = 1;
         #1000;
        rst = 0;
        //    $monitor("Time: %t, opin = %b", $time, opin);
        //     $display("Time: %t, rst = %b ----------------------------------------------", $time, rst);

             forever begin
            @(posedge clk) begin
                // $display("Time: %t ns, Reset: %b, Output: %b", $time, rst, opin);
                 //   if (opin) begin
                        //$display("Time: %t, opin is HIGH>>>>>", $time);
                       // highv = $time;
                   // end else begin
                      //  $display("Time: %t, opin is LOW=====", $time);
                    //     lowv = $time;
                    // end
                    // if(lowv>highv) 
                       // $display("diference ----%t",lowv-highv);
                if (opin && first_high_flag) begin
                    $display("Time: %t, opin is HIGH for the first time", $time);
                    first_high_flag <= 1'b0; // Clear the flag after printing
                    // counter <= counter + 1;
                    //  $display("counter %d", counter);
                end
                if (!opin && first_low_flag) begin
                    $display("Time: %t, opin is LOW for the first time", $time);
                    first_low_flag <= 1'b0; // Clear the flag after printing
                end
            end
        end
        // Wait for a while to observe behavior
      // #1000000; // Adjust the simulation time according to your needs

        //Finish simulation
        $finish;
    end

endmodule


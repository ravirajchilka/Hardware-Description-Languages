`timescale 1ns/1ns

module counter4bit_tb;
    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire [3:0] count;

    // Instantiate the Unit Under Test (UUT)
    counter4bit uut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );
    
     // Generate the clock signal
    always begin  
        #10 
        clk = ~clk;
    end


    initial begin
      // Monitor the count output
        $monitor("Time: %0d, Count: %b", $time, count);
        
        // Initialize Inputs
        clk = 0;
        rst = 0;

        // Wait 100 ns for global reset to finish
        #100;
        
        // Add stimulus here
        rst = 1;
        #50;
        rst = 0;
        
        // Run the simulation for 620 ns
        #620 $finish;
    end
      
   
endmodule






`timescale 1ns/1ps

module tb_myprotocol;

// Inputs

reg clk;
reg rst;

// Outputs
wire sig1;
wire sig2;
wire sig3;

// Instantiate the module under test
myprotocol dut (
  .clk(clk),
  .rst(rst),
  .sig1(sig1),
  .sig2(sig2),
  .sig3(sig3)
);

  initial begin
    	$dumpfile("myprotocol.vcd"); // Specify the VCD file name
    	$dumpvars(0, tb_myprotocol); 
end


  
// Clock generation
always #5 clk = ~clk;

// Stimulus
initial begin
    // Initialize inputs
//   	#10;

  clk = 0;
    rst = 1;
    #10;
   	rst = 0;
// 	#70;
//   	rst = 1;
//    #10;
//    	rst = 0;
//   #70;
//   	rst = 1;
//    #10;
//    	rst = 0;
   
  
   
  //  #80;
#200;
    // End simulation
    $finish;
end

// Monitor outputs
initial begin
  $monitor("Time: %0t,  s1=%b,s2=%b, counter1=%d,counter2=%d", $time, sig1,sig2, dut.counter1,dut.counter2);
end

endmodule

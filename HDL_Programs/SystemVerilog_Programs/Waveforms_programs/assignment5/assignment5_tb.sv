
`timescale 1ns/1ps

module tb_myprotocol;

// Inputs

logic clk;
logic rst;
  

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
  $monitor("Time: %0t,  s1=%b,s2=%b, global_neg_c=%d, global_neg_c=%d", $time, sig1,sig2,dut.pos_c,dut.neg_c);
end

endmodule

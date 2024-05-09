interface counter_intf();
  logic clk,rst,up;
  logic [3:0] dout;
endinterface

module tb;
  counter_intf cintf();
  counter dut(cintf.clk,cintf.rst,cintf.up,cintf.dout);
  
  integer i;
  
  initial begin 
  	cintf.clk = 0;
    cintf.rst = 0;
    cintf.up = 0;
  end
  
  always #5 cintf.clk = ~cintf.clk;
  
  initial begin 
    cintf.rst = 1;
    #30;
    cintf.rst = 0;
    #200;
    cintf.rst = 1;
    #100;
    cintf.rst = 0;
  end
  
  initial begin 
    for(i=0;i<50;i++) begin 
    	cintf.up = $urandom;
        @(posedge cintf.clk);
    end
  end
  
  initial begin 
  	$dumpvars;
    $dumpfile("dump.vcd");
  end
  
  initial begin 
  	#500;
    $finish;
  end
  
endmodule


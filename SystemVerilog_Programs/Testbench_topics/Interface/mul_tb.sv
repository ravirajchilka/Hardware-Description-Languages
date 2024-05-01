interface multiplication_intf();
  logic [7:0] a;
  logic [7:0] b;
  logic [15:0] y;
endinterface

module tb;
  
  multiplication_intf mintf();
  mul dut(mintf.a,mintf.b,mintf.y);
  
  integer i;
  
  initial begin
    for(i=0;i<20;i++) begin 
    	mintf.a = $urandom;
      	mintf.b = $urandom;
      	#10;
    end 
  end
   
  initial begin 
  	$dumpvars;
   $dumpfile("dump.vcd");
  end    

  
endmodule

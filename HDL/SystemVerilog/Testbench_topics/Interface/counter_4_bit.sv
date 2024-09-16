module  counter(
	input clk,rst,up,
 	output reg [3:0] dout
); 
  
  always_ff@(posedge clk) begin 
    if(rst)
      	dout <= 4'b0000;
    else begin 
      if(up) 
        	dout <= dout + 1;
      else
        	dout <= dout - 1;
    end
  end
  
endmodule

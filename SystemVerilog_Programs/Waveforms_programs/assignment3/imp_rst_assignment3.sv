module myprotocol(
	input clk, rst,
  	output reg sig1,sig2,sig3
);
  
  reg [2:0] pos_c;
  reg [2:0] neg_c;
  
  always_ff@(posedge clk) begin 
    if(rst) 
    	pos_c <= 0;
    else 
    	pos_c <= pos_c + 1;
  end
  
  always_ff@(negedge clk) begin 
    if(rst) 
    	neg_c <= 0;
    else 
    	neg_c <= neg_c + 1;
  end
  
   always_comb begin 
    //always initialize the signals 
     if(rst) begin 
     	sig1 = 1;
     	sig2 = 1;
        sig3 = 1;
     end
     
    if(pos_c == 3)
      sig1 = 0;
    if(neg_c == 4)
      sig1 = 1;
    
     if(neg_c == 3)
      sig2 = 0;
     if(pos_c == 4)
      sig2 = 1;
     
     if(pos_c == 2)
      sig3 = 0;
     if(neg_c == 5)
      sig3 = 1;
    
  end
  
endmodule

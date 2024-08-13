module myprotocol(
	input clk,rst,
  	output logic sig1,sig2,sig3
);
  
  logic [2:0] global_neg_c;
  logic [2:0] global_pos_c;
  
  always_ff@(negedge clk) begin 
    if(rst) 
    	global_neg_c <= 0;
    else
  		global_neg_c <= global_neg_c + 1;
  end
  
  always_ff@(posedge clk) begin 
    if(rst) begin 
    	global_pos_c <= 0;
    end
    else begin 
      global_pos_c <= global_pos_c + 1;
    end
  end
  
  always_comb begin 
    if(rst) begin 
    	sig1 = 0;
      	sig2 = 0;
      	sig3 = 0;
    end
    if(global_pos_c==2)
      	sig1 = 1;
    if(global_neg_c ==5)
      	sig1 = 0;
    
    if(global_neg_c==3)
      sig2 = 1;
    if(global_pos_c==4)
      sig2 = 0;
    
    if(global_pos_c==3)
      sig3 = 1;
    if(global_neg_c==4)
      sig3 = 0;
    
  end
  
endmodule

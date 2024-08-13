module myprotocol(
	input clk,rst,
  	output logic sig1,sig2
);
  
  logic [7:0] pos_c;
  logic [7:0] neg_c;  

  always_ff@(posedge clk)begin 
    if(rst) begin 
    	pos_c <= 0;
      	sig1 <= 0;
    end
    else begin 
    	pos_c <= pos_c + 1;
      if(pos_c > 0 && pos_c < 11) begin 
      	sig1 <= ~sig1;
      end
    end
  end
  
  always_ff@(negedge clk)begin 
    if(rst) begin 
    	neg_c <= 0;
      	sig2 <= 1;
    end
    else begin 
    	neg_c <= neg_c + 1;
      if(neg_c > 0 && neg_c < 11) begin 
      	sig2 <= ~sig2;
      end
    end
  end
  
endmodule


















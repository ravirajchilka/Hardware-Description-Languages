module myprotocol(
	input clk,rst,
  	output logic sig1,sig2,sig3
);
  
  logic [2:0] counter1;
  logic [2:0] counter2;
  logic [2:0] counter3;
  
  always_ff@(posedge clk) begin 
    if(rst) begin
    	counter1 <= 0;
      	sig1 <= 0;
    end
    else begin
      counter1 <= counter1 + 1;
      if(counter1>2) begin 
        if(counter1%2==1)
          sig1<=1;
        else 
          sig1<=0;
      end
    end
  end
  
  
  always_ff@(negedge clk) begin 
    if(rst) begin 
	  counter2<=0;
      sig2<=0;
    end
    else begin 
      counter2 <= counter2 + 1;
      if(counter2>1) begin 
        if(counter2%2==0)  
          sig2<=1;
        else 
          sig2<=0;
      end
    end
  end

  
  always_ff@(negedge clk) begin 
    if(rst) begin 
    	counter3<=0;
      	sig3<=0;
    end 
    else begin 
    	counter3 <= counter3 + 1;
      if(counter3>0) begin 
        if(counter3%2==1)
        	sig3<=1;
        else 
          	sig3<=0;
      end
    end
  end
  
  
endmodule

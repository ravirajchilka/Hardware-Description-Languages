module myprotocol(
	input clk, rst,
  	output logic sig1,sig2,sig3
);
  
   logic [2:0] pos_c;
   logic [2:0] neg_c;
  
  always_ff@(posedge clk) begin 
    if(rst) begin
    	pos_c <= 0;
    	sig2 = 0;
    end
    else 
    	pos_c <= pos_c + 1;
        if(pos_c<8) begin 
            sig2 <= ~sig2;
        end
//         if(pos_c%2==0) begin 
//         	sig1 <= 1;
//         end
  end
  
  always_ff@(negedge clk) begin 
    if(rst) begin
    	neg_c <= 0;
    	sig3 <= 0;
    end  
    else 
    	neg_c <= neg_c + 1;
        if(neg_c<8) begin 
            sig3 <= ~sig3; 
        end
//     	if(neg_c%2==1) begin 
//         	sig1 <= 0;
//         end
  end
  
  
   always_comb begin 
     if(rst) begin 
     	sig1 = 0;
     end
     
     //alternate method for sig2, similarly can be done for sig3
//      if(pos_c == 0) sig2 = 0;
//      if(pos_c == 1) sig2 = 1;
//      if(pos_c == 2) sig2 = 0;
//      if(pos_c == 3) sig2 = 1;
//      if(pos_c == 4) sig2 = 0;
//      if(pos_c == 5) sig2 = 1;
//      if(pos_c == 6) sig2 = 0;
//      if(pos_c == 7) sig2 = 1;
     
     //waveform for sig1
     if(pos_c == 0) sig1 = 1;
     if(neg_c == 2) sig1 = 0;
     if(pos_c == 2) sig1 = 1;
     if(neg_c == 4) sig1 = 0;
     if(pos_c == 4) sig1 = 1;
     if(neg_c == 6) sig1 = 0;
     if(pos_c == 6) sig1 = 1;
     if(neg_c == 7) sig1 = 0;
     if(pos_c == 7) sig1 = 1;
     if(neg_c == 7) sig1 = 0;
     
  end
endmodule

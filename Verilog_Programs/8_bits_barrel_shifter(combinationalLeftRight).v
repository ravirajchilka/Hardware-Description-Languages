module barrle_bh(
   input [7:0]In;
   input [2:0]n;
   input Lr;
   output reg [7:0] Out;
);

   always@(*) begin 
      if(Lr)
            Out = In << n;
      else
            Out = In >> n;
   end

endmodule








module dlatch_bh(
   input en,d;
   output reg q;
);

always@(en,q)
   if(en) q = d;

endmodule








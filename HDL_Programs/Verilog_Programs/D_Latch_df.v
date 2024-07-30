module dlatch_df(
   input en,d;
   output q;
);

assign q = en?d:q;

endmodule








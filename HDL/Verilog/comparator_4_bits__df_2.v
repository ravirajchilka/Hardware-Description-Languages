module comparator_4_bits_df2(
    input [3:0]A,B;
    output Eq,Gt,Sm;
);

assign Eq = (A==B); //A==B
assign Gt = (A>B); //A>B
assign Sm = (A<B); //A<B 


endmodule







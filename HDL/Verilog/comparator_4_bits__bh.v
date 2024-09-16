module comparator_4_bits_bh( 
    input [3:0]A,B; 
    output reg Eq,Gt,Sm;);

 always @(*) begin 
        Eq = (A==B); //A==B 
        Gt = (A>B); //A>B 
        Sm = (A<B); //A<B
   end

endmodule








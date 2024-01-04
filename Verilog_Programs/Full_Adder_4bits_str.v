module full_adder_4bits_st(s,cout,a,b,cin);
input [3:0] a,b;
input cin;
output [3:0] s;
output cout;

wire n1,n2,n3;

full_adder_bh fa1(s[0],n1,a[0],b[0],cin);
full_adder_bh fa1(s[1],n1,a[1],b[1],n1);
full_adder_bh fa1(s[2],n1,a[2],b[2],n2);
full_adder_bh fa1(s[3],n1,a[3],b[3],n3);

endmodule

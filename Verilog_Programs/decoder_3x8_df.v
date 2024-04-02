module decode_3x8_df(Y,I,En);

input [2:0]I;
input En;
output [7:0]Y;

assign Y = {
    En & I[2] & I[1] & I[0],
    En & I[2] & I[1] & ~I[0],
    En & I[2] & ~I[1] & I[0],
    En & I[2] & ~I[1] & ~I[0],
    En & ~I[2] & I[1] & I[0],
    En & ~I[2] & I[1] & ~I[0],
    En & ~I[2] & ~I[1] & I[0],
    En & ~I[2] & ~I[1] & ~I[0]
};

endmodule


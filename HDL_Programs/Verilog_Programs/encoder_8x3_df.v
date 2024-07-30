module encode8x3(
	input [7:0] D,
	output [2:0] B
);

	assign B = {D[1]|D[3]|D[5]|D[7], D[2]|D[3]|D[6]|D[7], D[4]|D[5]|D[6]|D[7]};


endmodule

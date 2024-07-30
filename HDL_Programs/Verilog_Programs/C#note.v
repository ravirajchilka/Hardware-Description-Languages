module freq_277hz(
	input clk,
	output reg opin[1:0]
);

	reg [20:0]counter;

	always@(posedge clk) begin		
		counter <= counter + 1;
		if(counter == 97122)
			counter <= 0;
	end
	
	always@(counter) begin 
		if(counter < (97122/2))
			opin[0] <= 1'b1;
		else 	
			opin[0] <= 1'b0;
	end


endmodule

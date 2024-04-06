module speaker_siren_counter_bits(
	input clk,
	output reg opin [1:0]
);

	reg [31:0] counter;

	always@(posedge clk) begin
		counter <= counter + 1;
		if(counter == 2*27000000) 
			counter <= 0;
	end

	always@(*) begin 
		if(counter < 27000000)
			opin[0] <= counter[16];
		else 
			opin[0] <= counter[15];
	end

endmodule

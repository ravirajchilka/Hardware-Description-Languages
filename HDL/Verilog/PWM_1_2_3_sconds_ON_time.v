module PWM_1_2_3_sconds_ON_time(
	input clk,
	output reg opin[2:0]
);

	reg [31:0] counter;
	reg [31:0] one_sec = 27000000;

	always@(posedge clk) begin 
		counter <= counter + 1;
		if(counter == 9*one_sec) // reset counter after 9 seconds
			counter <= 0;
	end

	always@(*) begin 
		if(counter < one_sec)
			opin[0] <= 1'b1; // 1 sec high
		else if(counter > one_sec && counter < 2*one_sec) 
			opin[0] <= 1'b0; // next 1 sec low
		else if(counter > 2*one_sec && counter < 4*one_sec)
			opin[0] <= 1'b1; // next 2 secs high
		else if(counter > 4*one_sec && counter < 5*one_sec)
			opin[0] <= 1'b0; // next 1 sec low
		else if(counter > 5*one_sec && counter < 8*one_sec)
			opin[0] <= 1'b1; // next 3 secs high 
		else 
			opin[0] <= 1'b0; // next 1 sec low and restart the counter 
	end

endmodule

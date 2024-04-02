module PWM_servo_signals(
	input clk,
	output reg opin[2:0]
);

	reg [31:0] counter;
	parameter [15:0] one_ms = 27000;

	always@(posedge clk) begin 
		counter <= counter + 1;
		if(counter == 7.5*one_ms) // reset counter after 7.5 ms
			counter <= 0;
	end

	always@(*) begin 
		if(counter < one_ms)
			opin[0] <= 1'b1; 
		else if(counter > one_ms && counter < 2*one_ms) 
			opin[0] <= 1'b0; // next 1ms low
		else if(counter > 2*one_ms && counter < 3.5*one_ms)
			opin[0] <= 1'b1; // next 1.5ms high
		else if(counter > 3.5*one_ms && counter < 4.5*one_ms)
			opin[0] <= 1'b0; // next 1ms low
		else if(counter > 4.5*one_ms && counter < 6.5*one_ms)
			opin[0] <= 1'b1; // next 2ms high 
		else 
			opin[0] <= 1'b0; // next 1ms low and restart the counter 
	end

endmodule

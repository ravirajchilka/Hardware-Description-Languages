module LED_brightness_high_to_low_toggle(
	input clk,
	output reg [2:0] opin
);

	reg [27:0] counter;
	reg [27:0] step = 3000000;

	always@(posedge clk) begin 
		counter <= counter + 1;
	end


	always@(posedge clk) begin 
		step = step - 100000;
	end

	
	always@(step) begin 
		if(counter < step) begin 
			opin[0] <= 1'b1;
		end
		else begin 
			opin[0] <= 1'b0;
		end
	end

endmodule


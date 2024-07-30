module seven_segment_display(
    input clk,
	output reg a, b, c, d, e, f, g
);

	reg [3:0] counter_output;
	reg [31:0] counter;

	always@(posedge clk) begin 
		if(counter ==27000000) begin 
			counter <= 0;
			counter_output <= counter_output + 1;
			if(counter_output == 4'b1001) begin 
				counter_output <= 0;
			end
		end
		else begin 
			counter <= counter + 1;
		end
	end

	always @(counter_output) begin
			 case(counter_output)
			 4'b0000: {a, b, c, d, e, f, g} = 7'b1111110; // 0
			 4'b0001: {a, b, c, d, e, f, g} = 7'b0110000; // 1
			 4'b0010: {a, b, c, d, e, f, g} = 7'b1101101; // 2
			 4'b0011: {a, b, c, d, e, f, g} = 7'b1111001; // 3
			 4'b0100: {a, b, c, d, e, f, g} = 7'b0110011; // 4
			 4'b0101: {a, b, c, d, e, f, g} = 7'b1011011; // 5
			 4'b0110: {a, b, c, d, e, f, g} = 7'b1011111; // 6
			 4'b0111: {a, b, c, d, e, f, g} = 7'b1110000; // 7
			 4'b1000: {a, b, c, d, e, f, g} = 7'b1111111; // 8
			 4'b1001: {a, b, c, d, e, f, g} = 7'b1111011; // 9
			 default: {a, b, c, d, e, f, g} = 7'b0000000; // Off
		 endcase
	 end

endmodule


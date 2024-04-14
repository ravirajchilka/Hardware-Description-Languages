module metronome_8_beats(
    input clk,
	output reg a, b, c, d, e, f, g, speaker_out
);

	reg [3:0] counter_output = 1; // start metronome from beat 1
	reg [31:0] counter;
	reg [18:0] freq_counter;
	reg [25:0] beep_time_counter;

	always@(posedge clk) begin 
		// Generate C# beep at 1/5th time of a second
		beep_time_counter <= beep_time_counter + 1;
		if(beep_time_counter == 27000000) 
			beep_time_counter <= 0;
		
		if(beep_time_counter < (27000000/5)) begin 
            // Generate 278Hz frequency
		    freq_counter <= freq_counter + 1;
		    if(freq_counter == 97122)  
			  	freq_counter <= 0;
		    if(freq_counter < 97122/2) 
			  	speaker_out <= 1;
		    else 
			  	speaker_out <= 0;
		end	
			
		// 7-segment display 
		if(counter == 27000000) begin 
			counter <= 0;
			counter_output <= counter_output + 1;
			if(counter_output == 4'b1000) begin 
				counter_output <= 1; // start metronome from beat 1
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


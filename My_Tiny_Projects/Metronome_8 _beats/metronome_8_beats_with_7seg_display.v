module metronome_8_beats_with_7seg_display(
    input clk,
	output reg a, b, c, d, e, f, g, speaker_out
);

	reg [3:0] counter_output = 1; // start metronome from beat 1
	reg [24:0] counter;
	reg [16:0] c_sharp_freq_counter;
	reg [16:0] g_sharp_freq_counter;
	reg [24:0] c_sharp_beep_time_counter;
	reg [26:0] g_sharp_beep_time_counter;
	reg [26:0] c_sharp_loop_counter;
	
	always@(posedge clk) begin 
		// Generate G# beep at 4th interval // G#4: Around 415.30 Hz 
		g_sharp_beep_time_counter <= g_sharp_beep_time_counter + 1;
		if(g_sharp_beep_time_counter == (4*27000000) ) 
			g_sharp_beep_time_counter <= 0;

		if(g_sharp_beep_time_counter >= 3*(27000000) && g_sharp_beep_time_counter < 86400000) begin   // Generate 415.30 Hz frequency
		    g_sharp_freq_counter <= g_sharp_freq_counter + 1;
		    if(g_sharp_freq_counter == 65014)  
			  	g_sharp_freq_counter <= 0;

		    if(g_sharp_freq_counter < 65014/2) 
			  	speaker_out <= 1;
		    else 
			  	speaker_out <= 0;
		end	
		
		c_sharp_loop_counter <= c_sharp_loop_counter + 1;
		if(c_sharp_loop_counter <= 3*27000000) begin
			 c_sharp_beep_time_counter <= c_sharp_beep_time_counter + 1;
			 if(c_sharp_beep_time_counter == 27000000) 
				 c_sharp_beep_time_counter <= 0;

			 if(c_sharp_beep_time_counter <= (27000000/5)) begin // Generate C# beep at 1/5th time of a second
				 c_sharp_freq_counter <= c_sharp_freq_counter + 1;
				 if(c_sharp_freq_counter == 97408)  
					 c_sharp_freq_counter <= 0;
				 if(c_sharp_freq_counter < 97408/2) 
					 speaker_out <= 1;
				 else 
					 speaker_out <= 0;
			 end	
		end
		else if(c_sharp_loop_counter == 4*27000000) begin 
			c_sharp_loop_counter <= 0;
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



module c_sharp_music_scale_note(
    input clk,
    output reg opin [2:0], 
    input btn1
);

    reg [20:0] counter1;
    reg [20:0] debounce_counter; // Counter for debouncing
    reg btn1_stable; // Stable state of btn1 after debouncing
    reg btn1_last; // Last sampled state of btn1

    // Parameters for debouncing
    parameter DEBOUNCE_LIMIT = 50000; // Adjust based on your clock frequency and desired debounce time

    always@(posedge clk) begin
		 // Debouncing logic for btn1
		 if (btn1 != btn1_last) begin
			 // Reset debounce counter if btn1 state changes
			 debounce_counter <= 0;
		 end
		 if (btn1 == btn1_last && debounce_counter < DEBOUNCE_LIMIT) begin
			 // Increment debounce counter if btn1 state is stable but hasn't reached the limit
			 debounce_counter <= debounce_counter + 1;
		 end
		 if (btn1 == btn1_last && debounce_counter == DEBOUNCE_LIMIT) begin
			 // Confirm btn1 stable state if debounce counter reaches limit
			 btn1_stable <= btn1;
		 end
		 // Always update last known state of btn1
		 btn1_last <= btn1;

		 // Original logic with btn1 replaced by btn1_stable
		 if(btn1_stable) begin    
			 counter1 <= counter1 + 1;
			 if(counter1 == 97122)
				 counter1 <= 0;
		 end
	end

    always@(counter1) begin 
        if(btn1_stable) begin
            if(counter1 < (97122/2))
                opin[0] <= 1'b1;
            else    
                opin[0] <= 1'b0;
        end
    end

endmodule


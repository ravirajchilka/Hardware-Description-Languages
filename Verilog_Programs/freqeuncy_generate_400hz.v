module freq_400hz(
	input clk,
	output reg [1:0] opin
);

	reg [31:0] counter;

	always @(posedge clk) begin 
        counter <= counter + 1;
        if (counter == 67500)
			/*Adjusted the counter for 400 Hz frequency
			 clock freq divided by the desired freq will be the count we want
			 with this count represents on and off time i.e. one complete cycle 
             
             Required bits N = Clock frequency / desired frequency
             
             */			 
            counter <= 0;
    end
    
    always @(counter) begin 
        if (counter < 33750) // Adjusted for 50% duty cycle
            opin[0] <= 1'b1;    
        else 
            opin[0] <= 1'b0;    
    end

endmodule



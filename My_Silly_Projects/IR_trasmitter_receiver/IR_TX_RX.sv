module IR_transmitter(
		input clk,rst,btn_800,RX_800_signal,
		output reg TX_RX_signal,LED
);

		reg [31:0] counter;
		reg [31:0] outer_c;
		reg [31:0] test_c;
		reg [31:0] width_c;

		//width calucation
		reg [31:0] width_counter;
		reg [31:0] pulse_width;
		reg signal_last_state;


		//800-33.75khz,400-67.5khz,600-45khz
		always_ff@(posedge clk) begin 
				if(!rst) begin 
						counter <= 0;
						outer_c <= 0;
		
						pulse_width <= 0;
						width_counter <= 0;
						signal_last_state <= 0;
				end
				else begin 
						if(btn_800) begin 
								outer_c <= outer_c + 1;
								if(outer_c<27000000) begin
										counter <= counter + 1;
										if(counter<800/2)
												TX_RX_signal <= 1;
										else 
												TX_RX_signal <= 0;
										if(counter == 800) begin 
												counter <= 0;
										end
								end
								if(outer_c>2*27000000)
										outer_c <= 0;
						end

//						if(!RX_800_signal) begin
//								test_c <= test_c + 1;
//								
//						end
//						else begin 
//								width_c <= test_c;
//								test_c <= 0;
//						end
						
//						if (RX_800_signal && signal_last_state) begin
//								width_counter <= 0;
//						end
//						if (!RX_800_signal) begin
//								width_counter <= width_counter + 1;
//						end
//						if (RX_800_signal && !signal_last_state) begin
//								pulse_width <= width_counter;
//								width_counter <= 0; 
//						end
//						signal_last_state <= RX_800_signal;

				end
		end

		always_ff@(posedge clk) begin
				if (pulse_width > 540 ) 
						LED <= 0; 
				else 
						LED <= 1;  
		end

endmodule


module c_sharp_music_scale_3notes(
	input clk,
	output reg opin [2:0], 
	input btn1, btn2, btn3
);

	reg [20:0] counter1;
	reg [20:0] counter2;
	reg [20:0] counter3;

	// C# note //
	
	always@(posedge clk) begin	
		if(btn1) begin	
		  counter1 <= counter1 + 1;
		  if(counter1 == 97122)
			  counter1 <= 0;
		end
	end
	
	always@(counter1) begin 
		if(btn1) begin
		  if(counter1 < (97122/2))
			  opin[0] <= 1'b1;
		  else 	
			  opin[0] <= 1'b0;
		end
	end

	// D# note //

	always@(posedge clk) begin	
		if(btn2) begin	
		  counter2 <= counter2 + 1;
		  if(counter2 == 86816)
			  counter2 <= 0;
		end
	end
	
	always@(counter2) begin 
		if(btn2) begin
		  if(counter2 < (86816/2))
			  opin[1] <= 1'b1;
		  else 	
			  opin[1] <= 1'b0;
		end
	end


   // F# note //

	always@(posedge clk) begin	
		if(btn3) begin	
		  counter3 <= counter3 + 1;
		  if(counter3 == 72974)
			  counter3 <= 0;
		end
	end
	
	always@(counter3) begin 
		if(btn3) begin
		  if(counter3 < (72974/2))
			  opin[2] <= 1'b1;
		  else 	
			  opin[2] <= 1'b0;
		end
	end


endmodule





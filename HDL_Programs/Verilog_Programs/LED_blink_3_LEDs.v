module toggle_three_LEDs(
    input clk,
    output reg [2:0]opin
);

    reg [31:0] counter;

    always@(posedge clk) begin
        
        counter <= counter + 1;
      
        if(counter < 27000000) begin
            opin[0] <= 1'b1; 
            opin[1] <= 1'b0;
            opin[2] <= 1'b0;
        end
        else if(counter > 27000000 && counter < 2*27000000) begin
            opin[0] <= 1'b0;
            opin[1] <= 1'b1;
            opin[2] <= 1'b0;
        end
        else begin 
            opin[0] <= 1'b0;
            opin[1] <= 1'b0;
            opin[2] <= 1'b1;
        end
        
        if(counter > (3*27000000))
            counter <= 0;
        end
   
endmodule



module toggleLED(
    input clk, ipin,
    output reg opin
);

    reg [31:0] counter;

    always@(posedge clk) begin
        counter <= counter + 1;
      
        if(counter < 27000000)  
            opin <= 1'b1; // LED on for 1 sec
        else 
            opin <= 1'b0; 
        // from 1 second to 3 seconds LED is off 
        //because the counter reset after 3 seconds
       
        
        if(counter > (3*27000000)) // more 3 seconds time
            counter <= 0;
        end
   
endmodule



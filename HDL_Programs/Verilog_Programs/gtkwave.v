module ff (
    input clk,
    input rst,
    output reg opin
);

    reg [40:0] counter;

    always @(posedge clk) begin 
        if (rst) begin 
            counter <= 0;
        end
        else begin  
          counter <= counter + 1;
            if(counter < 400)
                opin <= 1;
            if(counter > 400)
                opin <= 0;  

             if(counter == 800)
                counter <= 0;        
            
        end                
    end

endmodule

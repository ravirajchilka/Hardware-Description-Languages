module pwm_half_dc (
    input clk,
    output reg [2:0]opin
);
    parameter DUTY_CYCLE = 8'd128;
    parameter COUNTER_LIMIT = 8'd255;

    reg [7:0] counter;

    always@(posedge clk) begin
        counter <= counter + 1;
        if(counter == COUNTER_LIMIT) 
            counter <= 0;
    end
    
    always@(counter) begin 
            if(counter < DUTY_CYCLE)
                opin[0] <= 1'b1;
            else 
                opin[0] <= 1'b0;
    end


endmodule

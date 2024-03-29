module LEDBrightnessControl(
    input clk,                  // Clock input
    output reg [2:0] opin       // Output pin, LED connected to opin[0]
);

// Parameters for PWM resolution and brightness control
parameter PWM_RESOLUTION = 8;   // 8-bit resolution for PWM
parameter MAX_BRIGHTNESS = 255; // Maximum brightness value
parameter MIN_BRIGHTNESS = 0;   // Minimum brightness value
parameter BRIGHTNESS_STEP = 1;  // Step size for brightness change

// Counter for PWM and brightness control
reg [PWM_RESOLUTION-1:0] pwm_counter = 0;
reg [PWM_RESOLUTION-1:0] brightness = MAX_BRIGHTNESS; // Start from max brightness

// Clock divider (optional, based on your clk frequency and desired PWM frequency)
reg [15:0] clk_divider = 0;
wire pwm_clk = clk_divider[10]; //(value for controlling brightness time, 
//larger value means more time takes to discharge) Adjust the index based on desired PWM frequency

always @(posedge clk) begin
    clk_divider <= clk_divider + 1;
end

always @(posedge pwm_clk) begin
    // PWM counter for generating PWM signal
    pwm_counter <= pwm_counter + 1;
    
    // Update brightness at the end of each PWM cycle
    if (pwm_counter == MAX_BRIGHTNESS) begin
        if (brightness > MIN_BRIGHTNESS) begin
            brightness <= brightness - BRIGHTNESS_STEP;
        end else begin
            // Optional: Reset brightness to MAX_BRIGHTNESS or keep it at MIN_BRIGHTNESS
            // brightness <= MAX_BRIGHTNESS; // Uncomment to loop brightness from high to low
        end
    end
    
    // Generate PWM signal based on current brightness level
    opin[0] <= (pwm_counter < brightness) ? 1'b1 : 1'b0;
end

// Set other bits of opin to 0 (if not used)
always @(posedge clk) begin
    opin[2:1] <= 2'b00;
end

endmodule

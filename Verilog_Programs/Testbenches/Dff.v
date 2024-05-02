module DFF (
    input logic clk,
    input logic reset,
    input logic d,
    output logic q
);
    always_ff @(posedge clk or posedge reset)
    begin
        if (reset)
            q <= 1'b0;  // Synchronously reset the output to 0
        else
            q <= d;     // Update the output based on the input
    end
endmodule

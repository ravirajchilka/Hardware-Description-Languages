module freq_divider_by2(
    input clk,rst,
    output reg clk2
);

    always@(posedge clk) begin
        if(rst)
            clk2 <= 0;
        else     
            clk2 <= ~clk2;
    end        

endmodule

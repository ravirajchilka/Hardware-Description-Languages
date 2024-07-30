module freq_divider_by4(
    input clk,rst,
    output reg clk2,clk_out
);

    always@(posedge clk) begin
        if(rst)
            clk2 <= 0;
        else     
            clk2 <= ~clk2;
    end        


    always@(posedge clk2) begin
        if(rst)
            clk_out <= 0;
        else     
            clk_out <= ~clk_out;
    end  
          

endmodule



module dff_pedge_ah (
    input D,
    input clk,
    output reg Q,
    output reg Q_bar
);

always@(posedge clk)
    if(D==1) begin 
        Q <= 1;
        Q_bar <= 0;
    end
    else begin
        Q <= 0;
        Q_bar <= 1;
    end

endmodule 

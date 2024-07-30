module ram_single_port (
    output reg [7:0]q,
    input [7:0] data, [5:0] read_addr, write_addr,
    we,clk
);

    reg [7:0] ram [63:0];

    always @(posedge clk) begin
        if(we)
            ram[write_addr] <= data;
    q <= ram[read_addr];

    end


endmodule



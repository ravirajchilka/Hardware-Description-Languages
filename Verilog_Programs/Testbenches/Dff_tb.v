`timescale 1ps/1ps

module DFF_tb;
    logic clk;
    logic reset;
    logic d;
    logic q;


DFF dut(.clk(clk),.reset(reset),.d(d),.q(q));

// clock generator

initial begin
     clk = 0;
     forever begin
        clk = ~clk;
        #5;   
     end
end

initial begin
    // Randomize reset
    reset = $urandom_range(0,1);
    #($urandom_range(5,15));
    reset = 0;

    // Randomize stimli generation
    repeat(10) begin 
        d = $urandom_range(0,1);
        #($urandom_range(1,20));
    end

    #50
    $finish;
end


always@(posedge clk) begin 
      $display("At time %t: q = %b", $time, q);

end

endmodule










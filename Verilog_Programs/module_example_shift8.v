/* You are given a module my_dff8 with two inputs and one output (that implements a set of 8 D flip-flops). 
Instantiate three of them, then chain them together to make a 8-bit wide shift register of length 3.
In addition, create a 4-to-1 multiplexer (not provided) that chooses what to output depending on sel[1:0]: The value at the input d, after the first, after the second, or after the third D flip-flop. (Essentially, sel selects how many cycles to delay the input, from zero to three clock cycles.)
The module provided to you is: module my_dff8 ( input clk, input [7:0] d, output [7:0] q );
The multiplexer is not provided.*/

module top_module ( input clk, input d, output q );

    wire [7:0] qTOd_1;
    wire [7:0] qTOd_2;
    wire [7:0] qTOd_3;
    
    my_dff8 instance_my_dff1(.clk(clk),.d(d),.q(qTOd_1));
    my_dff8 instance_my_dff2(.clk(clk),.d(qTOd_1),.q(qTOd_2));
    my_dff8 instance_my_dff3(.clk(clk),.d(qTOd_2),.q(qTOd_3));

     always @(*)
        begin 
            if (sel == 2'b00)
                q = d;
            else if (sel == 2'b01)
                q = qTOd_1;
            else if (sel == 2'b10)
                q = qTOd_2;
            else if (sel == 2'b11)
                q = qTOd_3;
            else 
                q = 1`bx;
        end
    
endmodule    


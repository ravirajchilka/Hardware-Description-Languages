module full_adder_4bits_bh_test_bench(s,cout,a,b,cin);
reg [3:0] a,b;
reg cin;
wire [3:0]s;
wire cout;

full_adder_4bits_bh fa4_dut(s,cout,a,b,cin);

initial
$monitor("time=%d" \t a=%b \t b=%b \t cin=%b \t s=%b \t cout=%b, $time a,b,cin,s,cout);
initial begin
    a = 0;  
    b = 0;
    cin = 0;
    repeat(16) begin
        #10 a=a+1;
        repeat(16) begin 
            #10 b=b+1;
            repeat(2)
                #10 cin = ~cin;
        end
    end        
end

endmodule

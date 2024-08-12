module c_sharp_music_scale_3notes(
    input clk,
    output reg [2:0] opin, 
    input btn1, btn2, btn3
);

    reg [20:0] counter1 = 0;
    reg [20:0] counter2 = 0;
    reg [20:0] counter3 = 0;

    // C# note
    always @(posedge clk) begin
        if (btn1) begin
            counter1 <= counter1 + 1;
            if (counter1 == 97122)
                counter1 <= 0;
            opin[0] <= (counter1 < (97122 / 2)) ? 1'b1 : 1'b0;
        end else begin
            counter1 <= 0;
            opin[0] <= 1'b0;
        end
    end

    // D# note
    always @(posedge clk) begin
        if (btn2) begin
            counter2 <= counter2 + 1;
            if (counter2 == 86816)
                counter2 <= 0;
            opin[1] <= (counter2 < (86816 / 2)) ? 1'b1 : 1'b0;
        end else begin
            counter2 <= 0;
            opin[1] <= 1'b0;
        end
    end

    // F# note
    always @(posedge clk) begin
        if (btn3) begin
            counter3 <= counter3 + 1;
            if (counter3 == 72974)
                counter3 <= 0;
            opin[2] <= (counter3 < (72974 / 2)) ? 1'b1 : 1'b0;
        end else begin
            counter3 <= 0;
            opin[2] <= 1'b0;
        end
    end

endmodule


/*
								PORT CONFIGURATION
		IO_LOC "opin[0]" 74;
		IO_PORT "opin[0]" IO_TYPE=LVCMOS18 PULL_MODE=UP DRIVE=8 BANK_VCCIO=1.8;
		IO_LOC "btn1" 73;
		IO_PORT "btn1" IO_TYPE=LVCMOS18 PULL_MODE=DOWN BANK_VCCIO=1.8;

		IO_LOC "opin[1]" 85;
		IO_PORT "opin[1]" IO_TYPE=LVCMOS18 PULL_MODE=UP DRIVE=8 BANK_VCCIO=1.8;
		IO_LOC "btn2" 75;
		IO_PORT "btn2" IO_TYPE=LVCMOS18 PULL_MODE=DOWN BANK_VCCIO=1.8;

		IO_LOC "opin[2]" 15;
		IO_PORT "opin[2]" IO_TYPE=LVCMOS18 PULL_MODE=UP DRIVE=8 BANK_VCCIO=1.8;
		IO_LOC "btn3" 77;
		IO_PORT "btn3" IO_TYPE=LVCMOS18 PULL_MODE=DOWN BANK_VCCIO=1.8;

		IO_LOC "clk" 4;
		IO_PORT "clk" IO_TYPE=LVCMOS18 PULL_MODE=UP BANK_VCCIO=1.8;
*/ 
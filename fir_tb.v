`timescale 1ns/1ps

module fir_tb;

    reg clk;
    reg rst;
    reg signed [15:0] x_in;
    wire signed [15:0] y_out;

    // Instantiate FIR filter
    fir_filter dut (
        .clk(clk),
        .rst(rst),
        .x_in(x_in),
        .y_out(y_out)
    );

    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        x_in = 0;

        // Waveform dump
        $dumpfile("fir_wave.vcd");
        $dumpvars(0, fir_tb);

        // Release reset
        #20 rst = 0;

        // Apply input samples
        #10 x_in = 16'sd10;
        #10 x_in = 16'sd20;
        #10 x_in = 16'sd30;
        #10 x_in = 16'sd40;
        #10 x_in = 16'sd50;

        #50 $finish;
    end

endmodule

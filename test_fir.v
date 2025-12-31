module testbench;
    reg clk;
    reg rst;

    initial begin
        clk = 0;
        rst = 1;
        #5 rst = 0;
    end

    always #1 clk = ~clk; // clock toggles every 1 time unit

    initial begin
        // Create VCD file
        $dumpfile("test_fir.vcd");
        $dumpvars(0, testbench);
        
        $display("Hello, Verilog simulation is working!");
        #20 $finish;
    end
endmodule

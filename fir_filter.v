module fir_filter (
    input wire clk,
    input wire rst,
    input wire signed [15:0] x_in,
    output reg signed [15:0] y_out
);

    reg signed [15:0] x_delay;

    // Q15 coefficients
    localparam signed [15:0] A = 16'sd16384; // 0.5
    localparam signed [15:0] B = 16'sd16384; // 0.5

    reg signed [31:0] mult_a;
    reg signed [31:0] mult_b;
    reg signed [31:0] sum;

    always @(posedge clk) begin
        if (rst) begin
            x_delay <= 0;
            y_out   <= 0;
        end else begin
            mult_a <= A * x_in;
            mult_b <= B * x_delay;
            sum    <= mult_a + mult_b;
            y_out  <= sum >>> 15; // scale back
            x_delay <= x_in;
        end
    end

endmodule

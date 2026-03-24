`timescale 1ns/1ps

module adsd_32_testbench;

reg clk;
reg rst;
wire [7:0] LEDport;

// Instantiate top module
adsd_32_top DUT(
    .clk(clk),
    .rst(rst),
    .LEDport(LEDport)
);

// Clock generator: 100 MHz -> period 10 ns
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 ns period
end

// Reset sequence
initial begin
    rst = 0;        // assert reset
    #20;
    rst = 1;        // deassert reset
end

// Monitor LED port
initial begin
    $display("Time(ns)\tLED");
    $monitor("%0t\t%b", $time, LEDport);
end

// Stop simulation after a while
initial begin
    #2000;          // run for 2000 ns
    $stop;
end

endmodule

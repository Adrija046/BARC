`timescale 1ns/1ps

module tb_rng;

reg clk;
reg rst_n;
reg decay_pulse;

wire [33:0] rand_bit_o;

wire [2:0] sync;
wire count_enable;
wire pulse_rise;
wire signed [33:0] diff;
wire[33:0] counter;
wire capture_delta1;
wire capture_delta2;
wire calc_enable;
wire rand_enable;
wire counter_reset;
wire[33:0] delta1;
wire[33:0] delta2;
wire [2:0] ps;
wire [2:0] ns;

rng dut(
    clk,
    rst_n,
    decay_pulse,
    rand_bit_o,
    sync,
    count_enable,
    pulse_rise,
    diff,
   counter,
   
    capture_delta1,
    capture_delta2,
    calc_enable,
    rand_enable,
    counter_reset,
    delta1,

    delta2,

    ps,
    ns
);

//////////////////////////////////////////////////////
// 300 MHz Clock
//////////////////////////////////////////////////////

initial begin
    clk = 0;
    forever #1.666 clk = ~clk;
end

//////////////////////////////////////////////////////
// Stimulus
//////////////////////////////////////////////////////

initial begin

    rst_n = 0;
    decay_pulse = 0;

    #50;
    rst_n = 1;

    // Pulse 1
    #50;
    decay_pulse = 1;
    #20;
    decay_pulse = 0;

    // 500 ns interval
    #3240;

    // Pulse 2
    decay_pulse = 1;
    #20;
    decay_pulse = 0;

    // 300 ns interval
    #2500;

    // Pulse 3
    decay_pulse = 1;
    #20;
    decay_pulse = 0;

    // 300 ns interval
    #5784;

    // Pulse 4
    decay_pulse = 1;
    #20;
    decay_pulse = 0;

    // Allow FSM to finish
#1000000;

    $finish;
end

//////////////////////////////////////////////////////
// State changes only
//////////////////////////////////////////////////////

reg [3:0] ps_prev;

always @(posedge clk)
begin
    if(ps != ps_prev)
    begin
        $display(
        "\nTIME=%0t  STATE %0d -> %0d",
        $time,
        ps_prev,
        ps
        );
        ps_prev <= ps;
    end
end

//////////////////////////////////////////////////////
// Pulse detection
//////////////////////////////////////////////////////

always @(posedge clk)
begin
    if(pulse_rise)
    begin
        $display(
        "TIME=%0t  PULSE DETECTED  sync=%b",
        $time,
        sync
        );
    end
end

//////////////////////////////////////////////////////
// Delta1 capture
//////////////////////////////////////////////////////

always @(posedge clk)
begin
    if(capture_delta1)
    begin
        $display(
        "TIME=%0t  DELTA1 CAPTURED counter=%0d",
        $time,
      counter
        );
    end
end

//////////////////////////////////////////////////////
// Delta2 capture
//////////////////////////////////////////////////////

always @(posedge clk)
begin
    if(capture_delta2)
    begin
        $display(
        "TIME=%0t  DELTA2 CAPTURED counter=%0d",
        $time,
        counter
        );
    end
end

//////////////////////////////////////////////////////
// Diff calculation
//////////////////////////////////////////////////////

always @(posedge clk)
begin
    if(calc_enable)
    begin
        $display(
        "TIME=%0t  CALC ENABLE  D1=%0d  D2=%0d",
        $time,
        delta1,
        delta2
        );
    end
end

//////////////////////////////////////////////////////
// Random output
//////////////////////////////////////////////////////

always @(posedge clk)
begin
    if(rand_enable)
    begin
        $strobe(
        "TIME=%0t  RAND OUTPUT = %h  DIFF=%0d",
        $time,
        rand_bit_o,
        diff
        );
    end
end
endmodule


# run 10000000ns
TIME=112000  PULSE DETECTED  sync=111
TIME=3370000  PULSE DETECTED  sync=111
TIME=3374000  DELTA1 CAPTURED counter=978
TIME=5893000  PULSE DETECTED  sync=111
TIME=11697000  PULSE DETECTED  sync=111
TIME=11700000  DELTA2 CAPTURED counter=1742
TIME=11704000  CALC ENABLE  D1=978  D2=1742
TIME=11707000  RAND OUTPUT = 3fffffd04  DIFF=-764
$finish called at time : 1011704 ns : File "C:/rng/ip_repo/project_6/project_6.srcs/sim_1/new/tb.v" Line 105
INFO: [USF-XSim-96] XSim completed. Design snapshot 'tb_rng_behav' loaded.
INFO: [USF-XSim-97] XSim simulation ran for 10000000ns
